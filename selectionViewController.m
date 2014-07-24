//
//  selectionViewController.m
//  RecipeApp
//
//  Created by Emilien Sanchez on 17/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "selectionViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "homeViewController.h"
#import "XMLReader.h"
#import "NSDate+InternetDateTime.h"
#import "RSSFeed.h"

@interface selectionViewController ()

@end

@implementation selectionViewController
@synthesize collectionView;
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{

    
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view.
    Category = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    CategoryTitle = [NSArray arrayWithObjects:@"News", @"Politics" , @"Business", @"Technology", @"Sports",@"Science",@"Celebrity",@"Gaming",@"Cinema",nil];
    
    NSLog(@"Started");
    NSLog(@"%lu",(unsigned long)Category.count);
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - self.view.frame.size.width/2.4, self.view.frame.size.height/2 - self.view.frame.size.height/4, self.view.frame.size.width/1.2, self.view.frame.size.height/2 +20) collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:collectionView];
    
    locationManager = [[CLLocationManager alloc] init];
    //locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"Lat : %@", latitude);
    NSLog(@"Long : %@", longitude);
    
    PassCategory = [[NSMutableArray alloc] init];
    URLs = [[NSMutableArray alloc] init];
    SourceMutable = [[NSMutableArray alloc] init];
    
    NbURL = 0;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView2 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView2 dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    UIImageView *recipeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,80,80)];
    recipeImageView.image = [UIImage imageNamed:[Category objectAtIndex:indexPath.row]];
    [recipeImageView setTag:100+indexPath.row];
    
    [cell addSubview:recipeImageView];
    
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 80, 15)];
    testLabel.text = [NSString stringWithFormat:[CategoryTitle objectAtIndex:indexPath.row]];
    testLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:testLabel];
    
    //cell.backgroundColor=[UIColor greenColor];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

-(void)collectionView:(UICollectionView *)collectionView2 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    long tag = 100 + indexPath.row;
    UIImageView *myImageView = (UIImageView *)[self.view viewWithTag:tag];
    
    if ([PassCategory containsObject:CategoryTitle[indexPath.row]]==TRUE) {
        [PassCategory removeObject:CategoryTitle[indexPath.row]];
        myImageView.image = [UIImage imageNamed:[Category objectAtIndex:indexPath.row]];
    } else {
        [PassCategory addObject:CategoryTitle[indexPath.row]];
        myImageView.image = [UIImage imageNamed:[Category objectAtIndex:indexPath.row+1]];
    }
    
    //[self addCategorie:indexPath.row];
    NSLog(@"didselect %lD",(long)indexPath.row);
    NSLog(@"%@", PassCategory);
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString: @"play"]) {
        //do
        //NSLog(@"cool");
        
    }
        
}


- (IBAction)Selection:(id)sender {
    NSMutableArray *arrayContent = [[NSMutableArray alloc] init];
    NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
    NSMutableArray *arrayDate = [[NSMutableArray alloc] init];
    NSMutableArray *arraySource = [[NSMutableArray alloc] init];
    NSMutableArray *arraySource2 = [[NSMutableArray alloc] init];
    NSMutableArray *arrayRSSFeed = [[NSMutableArray alloc] init];
    NSMutableArray *arrayURL = [[NSMutableArray alloc] init];
    
    long n = PassCategory.count;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

    for (int i=0; i<n ; i++) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Contenu"];
        [query whereKey:@"Categorie" equalTo:PassCategory[i]];
        NSArray *CatUrl = [query findObjects];
        PFObject *element = nil;
        for (element in CatUrl) {
            [URLs addObject:element[@"URL"]];
            [SourceMutable addObject:element[@"Fournisseur"]];
        }
        
    }
    
    NSLog(@"%@", URLs);
    NSLog(@"%@", SourceMutable);
        
        for (NSString *urls in URLs) {
            
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:urls]];
            // Parse the XML into a dictionary
            NSError *parseError = nil;
            NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:data error:&parseError];
            NSArray *articles = [[xmlDictionary valueForKey:@"rss"] valueForKey:@"channel"];
            //NSLog(@"%@", articles);
            /*
            double c =[name count];
            //NSLog(@"%D",c);
            for (NSArray *items in name) {
                //NSLog(@"%@", items);
                /*
                NSString *titre = [[[items valueForKey:@"item"]valueForKey:@"title"] valueForKey:@"text"];
                //NSString *cont = [[[items valueForKey:@"item"]valueForKey:@"description"] valueForKey:@"text"];
                NSString *date = [[[items valueForKey:@"item"]valueForKey:@"pubDate"] valueForKey:@"text"];
                NSDate *articleDate = [NSDate dateFromInternetDateTimeString:date formatHint:DateFormatHintRFC822];
                [content addObject:articleDate];
                [content2 addObject:titre];
             
            }
             */
            
            //NSArray *contenu1= [[[[name valueForKey:@"channel"] valueForKey:@"item" ] valueForKey:@"description"] valueForKey:@"text"];
            //NSArray *title1= [[[[name valueForKey:@"channel"] valueForKey:@"item" ] valueForKey:@"title"] valueForKey:@"text"];
            NSArray *date= [[[articles  valueForKey:@"item" ] valueForKey:@"pubDate"] valueForKey:@"text"];
            NSArray *content= [[[articles  valueForKey:@"item" ] valueForKey:@"description"] valueForKey:@"text"];
            NSArray *title= [[[articles  valueForKey:@"item" ] valueForKey:@"title"] valueForKey:@"text"];
            NSArray *urls= [[[articles  valueForKey:@"item" ] valueForKey:@"link"] valueForKey:@"text"];

            //Source = [Source initWithArray:SourceMutable];
            //NSLog(@"%@",Source);
            //Ajouter les images des sources
            NSLog(@"test: %@", [SourceMutable objectAtIndex:NbURL]);
            
            
            NSInteger dt = [content count];
            for (int i = 0; i<dt; i++ ) {
                [arraySource insertObject:[SourceMutable objectAtIndex:NbURL] atIndex:i];
                NSLog(@"%@", [arraySource objectAtIndex:i]);
                NSLog(@"%@", [urls objectAtIndex:i]);
            }
            
            
            //NSLog(@"%@", arraySource);
            //NSArray *contenu = [[name valueForKey:@"channel"] valueForKey:@"item" ];
            //[content addObjectsFromArray:contenu1];
            //[title addObjectsFromArray:title1];
            [arrayDate addObjectsFromArray:date];
            [arrayTitle addObjectsFromArray:title];
            [arrayContent addObjectsFromArray:content];
            [arrayURL addObjectsFromArray:urls];
            [arraySource2 addObjectsFromArray:arraySource];
            
            //NSLog(@"url utilisée: %@", urls);
            //NSLog(@"%@", content);
            //NSLog(@"%@", content2);
            NbURL = NbURL+1;
        }
        
        double c = [arrayContent count];
        NSLog(@"%D",c);
        for (int i =0; i<c; i++) {
            NSString *date = [arrayDate objectAtIndex:i];
            NSString *title = [arrayTitle objectAtIndex:i];
            NSString *content = [arrayContent objectAtIndex:i];
            NSString *source = [arraySource2 objectAtIndex:i];
            NSString *URL = [arrayURL objectAtIndex:i];
            NSDate *articleDate = [NSDate dateFromInternetDateTimeString:date formatHint:DateFormatHintRFC822];
            //NSLog(@"%@",articleDate);
            RSSFeed *object = [[RSSFeed alloc] init];
            object.Date = articleDate;
            object.Content = content;
            object.Title = title;
            object.Source = source;
            object.URL = URL;
            [arrayRSSFeed addObject:object];
        }
        
        //NSLog(@"%@", arrayRSSFeed);
        
        //RSSFeed *object = [[RSSFeed alloc] init];
        //[arrayRSSFeed sortedArrayUsingSelector:@selector(compare:)];
        //[arrayRSSFeed sortedArrayUsingSelector:@selector(compare:)];
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Date"
                                                     ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [arrayRSSFeed sortedArrayUsingDescriptors:sortDescriptors];
        
        for (RSSFeed *test in sortedArray)  {
          //  NSLog(@"%@",test.Content);
            //NSLog(@"%@",test.Date);
            NSLog(@"%@",test.Source);
            NSLog(@"%@",test.URL);
            //NSLog(@"%@",test.Title);
        }
        /*
        RSSFeed *test = [arrayRSSFeed objectAtIndex:1];
        NSLog(@"%@",test.Content);
        NSLog(@"%@",test.Date);
        NSLog(@"%@",test.Date);
        */
        //NSLog(@"Content: %@", content2);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            homeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
            //lvc.News = content;
            lvc.news = sortedArray;
            //lvc.Title = title;
            [self presentViewController:lvc animated:YES completion:nil];
            
        });
    });
    
    

    
    
}


@end
