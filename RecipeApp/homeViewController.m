//
//  homeViewController.m
//  RecipeApp
//
//  Created by Emilien Sanchez on 02/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "homeViewController.h"
#import "XMLReader.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface homeViewController ()


@end

@implementation homeViewController
@synthesize Overlay;
@synthesize Anim;
@synthesize Objet;
@synthesize Pause;
@synthesize utterance;
@synthesize synth;
@synthesize Stop_Vue;
@synthesize StartApp;
@synthesize State;
@synthesize NewsWithoutHTML;
@synthesize Title;
@synthesize locationManager;
@synthesize NbArticle;
@synthesize Titre;
@synthesize musicPlayer;
@synthesize Content;
@synthesize lowPassResults;
@synthesize Icon;
@synthesize latitude;
@synthesize longitude;
@synthesize ActionArticle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        Overlay = NO;
        Anim = NO;
        Stop_Vue = NO;
        Pause = NO;
        NbArticle = 1;
        ActionArticle = 1;
        numberOfMusic = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [self registerMediaPlayerNotifications];
    
    // Create the text
    State = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height/3 -10, 300, 20)];
    [State setTextColor:[UIColor blackColor]];
    [State setBackgroundColor:[UIColor clearColor]];
    [State setFont:[UIFont fontWithName: @"Trebuchet MS" size: 20.0f]];
    State.textAlignment=1;
    [self.view addSubview:State];
    
    Titre = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height/5, 300, 20)];
    [Titre setTextColor:[UIColor blackColor]];
    [Titre setBackgroundColor:[UIColor clearColor]];
    [Titre setFont:[UIFont fontWithName: @"Trebuchet MS" size: 12.0f]];
    Titre.textAlignment=1;
    Titre.numberOfLines=2;
    Titre.lineBreakMode= NSLineBreakByClipping;
    [self.view addSubview:Titre];
    
    //Define location

    // locationManager update as location
    locationManager = [[CLLocationManager alloc] init];
    //locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"latitude %@",latitude);
    NSLog(@"longitude %@",longitude);
    //Fetch Weather News Feed
    
    if ((latitude == 0) && (longitude ==0)) {
        NSLog(@"Faire meteo");
    }
    
    //Fetch RSS News Feed
    /*
     http://images.apple.com/main/rss/hotnews/hotnews.rss
     http://news.yahoo.com/rss/
     */
    
    NSString *theURL2 = @"http://feeds.feedburner.com/businessinsider?format=xml";
    NSData *data2=[NSData dataWithContentsOfURL:[NSURL URLWithString:theURL2]];
    
    // Parse the XML into a dictionary
    NSError *parseError2 = nil;
    NSDictionary *xmlDictionary2 = [XMLReader dictionaryForXMLData:data2 error:&parseError2];
    // Print the dictionary

    _News2  = [[[[[xmlDictionary2 valueForKey:@"rss"]valueForKey:@"channel"] valueForKey:@"item" ] valueForKey:@"description"] valueForKey:@"text"];
    //NSLog(@"%@", xmlDictionary2);
    
    
    NSString *theURL = @"http://news.yahoo.com/rss/";
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:theURL]];
    
    // Parse the XML into a dictionary
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:data error:&parseError];
    // Print the dictionary
    // NSLog(@"%@", xmlDictionary);
    
    //NSDictionary *test = [xmlDictionary objectForKey: @"channel.title"];
    
    NSDictionary *name = [xmlDictionary valueForKey:@"rss"];
    //NSString *yourId = [[[xmlDictionary objectForKey:@"data"] objectAtIndex:0] objectForKey:@"id"];
    _News = [[[[name valueForKey:@"channel"] valueForKey:@"item" ] valueForKey:@"description"] valueForKey:@"text"];
    NewsWithoutHTML = [[NSMutableArray alloc] init];
    
    Title = [[[[name valueForKey:@"channel"] valueForKey:@"item" ] valueForKey:@"title"] valueForKey:@"text"];
    //NSString *test2 = xmlDictionary[1];
    NSLog(@"%@", _News);
    NSLog(@"%@", Title);
    
    
    //Fetch weather
    /*
    NSData *weather = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139"]];

    NSError *error2;
    NSMutableDictionary *Meteo = [NSJSONSerialization
                                       JSONObjectWithData:weather
                                       options:NSJSONReadingMutableContainers
                                       error:&error2];
    
    NSLog(@"%@", Meteo);
    */
     
     
    //Animation
    //[self drawBezierAnimate:1];
    //[self Animate:1];
    
    //Gesture
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    singleFingerTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleFingerTap];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleFingerTap requireGestureRecognizerToFail:doubleTap];
    
    //voice
    synth = [[AVSpeechSynthesizer alloc] init];
    self.synth.delegate = self;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.rate = 0.65*AVSpeechUtteranceDefaultSpeechRate;
    
    
    StartApp = YES;
    if (StartApp == YES) {
        [self addOverlay:1];
    } else {
        NSLog(@"Ne MArche Pas");
    }
    
    //Image
    Content = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 75, self.view.frame.size.height/2 - 75, 150, 150)];
    [self.view addSubview:Content];
    
    Icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height, 200, 200)];
    [self.view addSubview:Icon];
    

    

}



-(void)handleDoubleTap:(UISwipeGestureRecognizer *)recognizer{
    //do something on double tap
    if (Stop_Vue == 0) {
        NSLog(@"DoubleTap");
        [self addOverlay:3];
        Stop_Vue = YES;
        [self.synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        NbArticle=0;
        [PFUser logOut];
    } else
    NSLog(@"NoDoubletap");
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer{
    //do something on swipe right
    NSLog(@"swipe right");
    if (musicPlayer.playbackState != MPMusicPlaybackStatePlaying) {
        if (NbArticle>0) {
            [self.synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            if (NbArticle == 1) {
                [self actionParler:1];
            } else {
            NbArticle = NbArticle - 1;
            ActionArticle = ActionArticle -1;
            [self actionParler:1];
            }
        }

    } else {
        [musicPlayer stop];
        NbArticle = NbArticle - 1;
        ActionArticle = ActionArticle -1;
        [self actionParler:1];
    }
    
}

-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer{
    //do something on swipe left
    NSLog(@"swipe left");
    if (musicPlayer.playbackState != MPMusicPlaybackStatePlaying) {
        NSLog(@"Voice stops");
        [self.synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        NbArticle = NbArticle + 1;
        ActionArticle = ActionArticle + 1;
        [self actionParler:1];
    } else {
        NSLog(@"Music stops");
        [musicPlayer stop];
        NbArticle = NbArticle + 1;
        ActionArticle = 0;
        [self actionParler:1];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Tap");
    if (Stop_Vue == 1) {
        NSLog(@"Remove stop view");
        [self addOverlay:1];
        Stop_Vue = NO;
        [self actionParler:1];
    } else if (StartApp==1){
        NSLog(@"Remove start view");
        [self addOverlay:1];
        StartApp = NO;
        [self actionParler:1];
        //[self Weather:1];
    } else {
    [self addOverlay:2];
    //[self drawBezierPause:1];
    [self pause:1];

    }
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

- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_NowPlayingItemChanged:)
                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
    [musicPlayer beginGeneratingPlaybackNotifications];
}

- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    
    if (playbackState == MPMusicPlaybackStatePaused) {
       
    } else if (playbackState == MPMusicPlaybackStatePlaying) {

        
    } else if (playbackState == MPMusicPlaybackStateStopped) {
        
        [musicPlayer stop];
        
    }
    
}

- (void) handle_NowPlayingItemChanged: (id) notification
{
    //Do
    NSLog(@"changed");
    switch(musicPlayer.indexOfNowPlayingItem) {
        case 1:
            NSLog(@"stop music");
            [self.musicPlayer stop];
            [self Parler:NbArticle];
            break;
            
    }
    
    
}

-(MPMediaItem*) getRandomTrack
{
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    // Get all Media Items into an Array (Fast)
    NSArray *allTracks = [everything items];
    // Check we have enough Tracks for a Random Choice
    if ([allTracks count] < 2)
    {
        return nil;
    }
    // Pick Random Track
    int trackNumber = arc4random() % [allTracks count];
    MPMediaItem *item = [allTracks objectAtIndex:trackNumber];
    // Display and Return
    return item;
    
    
}






-(void) actionParler:(BOOL)test
{
    //do
    //[self Parler:NbArticle];
    
    if (ActionArticle == 1) {
        [self actionMusic:1];
        ActionArticle = 0;
    } else {
        [self Parler:NbArticle];
        ActionArticle = ActionArticle +1;
    }
    

}

-(void) actionMusic:(BOOL)test
{
    //do
    
    MPMediaItem * item = [self getRandomTrack];
    item2 = [self getRandomTrack];
    NSMutableArray *song = [[NSMutableArray alloc] init];
    [song addObject:item];
    [song addObject:item2];
    MPMediaItemCollection * collection = [[MPMediaItemCollection alloc] initWithItems:[NSArray arrayWithObject:song]];
    musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    [musicPlayer setQueueWithItemCollection:collection];
    [musicPlayer setRepeatMode:MPMusicRepeatModeNone];
    [musicPlayer play];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_NowPlayingItemChanged:)
                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
    [musicPlayer beginGeneratingPlaybackNotifications];
    
    MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
    if (titleString) {
        Titre.text = [NSString stringWithFormat:@"%@",titleString];
    } else {
        Titre.text = @"Title: Unknown title";
    }
}


-(void) pause:(bool)state
{

    if (Pause == YES) {
        if (self.musicPlayer.playbackState == MPMusicPlaybackStatePaused) {
            [musicPlayer play];
            Pause = NO;
        } else {
            [self.synth continueSpeaking];
            Pause = NO;
        }
    } else if (Pause == NO){
        if (self.musicPlayer.playbackState == MPMusicPlaybackStatePlaying) {
            [musicPlayer pause];
            Pause = YES;
        } else {
        [self.synth pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        Pause = YES;
        }
    }
}

-(void) Parler:(int) article{
    //formatage
    
        NSString *Speech = _News[article];
        //NSLog(@"Avant formatage %@", Speech);
    
    /*
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *TempURL = @"http://feedenlarger.com/makefulltextfeed.php?url=news.google.com%2Fnews%2Furl%3Fsa%3Dt%26fd%3DR%26ct2%3Dfr%26usg%3DAFQjCNFemj0s53PoqyR2FaBYCyz4o3HLKg%26clid%3Dc3a7d30bb8a4878e06b80cf16b898331%26cid%3D52778910912726%26ei%3D3qyfU8DzGIaKwAHf_4DgDQ%26url%3Dhttp%3A%2F%2Fwww.rtl.fr%2Factu%2Fsociete-faits-divers%2Fgreve-sncf-76-des-francais-y-sont-opposes-7772686400&max=5&links=remove&exc=1&format=json&submit=Create+full+text+feed";
        [request setURL:[NSURL URLWithString:TempURL]];
        [request setHTTPMethod:@"GET"];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",returnData);
    */
    
        NSAttributedString *SpeechWithoutHTML = [[NSAttributedString alloc] initWithData:[Speech dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
        //NSLog(@"Apres formatage %@", SpeechWithoutHTML);
        NSString *Actual = SpeechWithoutHTML.string;
        NSLog(@"Apres formatage %@", Actual);
    
        utterance = [AVSpeechUtterance
                     speechUtteranceWithString:Actual];
        utterance.rate = 0.65*AVSpeechUtteranceDefaultSpeechRate;
        utterance.postUtteranceDelay = 1;
        [synth speakUtterance:utterance];
    
        Titre.text = Title[article];
        Content.image = [UIImage imageNamed:@"rss.png"];
        NSLog(@"article n° %D", article);
    

}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NbArticle = NbArticle +1;
    [self actionParler:1];
    NSLog(@"didFinish ActionArticle = %D", ActionArticle);
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"didContinue");
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didStart");
}

-(void)addOverlay:(NSInteger)active
{
    NSLog(@"%lD",(long)active);

    if (Overlay == 0) {
        if (active == 1) {
            NSLog(@"Display start");
            CGRect newSize = CGRectMake(0.0f ,0.0f, 320.f, 600.0f);
            UIView *newView = [[UIView alloc] initWithFrame:newSize];
            _NewView = newView;
            [newView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
            [self.view addSubview:newView];
            State.text = @"tap to start";
            Overlay = 1;
            //NSLog(@"%lD",(long)Overlay);
        } else if (active ==2 && synth.speaking==TRUE){
            NSLog(@"Display pause");
            CGRect newSize = CGRectMake(0.0f ,0.0f, 320.f, 600.0f);
            UIView *newView = [[UIView alloc] initWithFrame:newSize];
            _NewView = newView;
            [newView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
            [self.view addSubview:newView];
            State.text = @"Pause";
            Icon.image = [UIImage imageNamed:@"Pause200x200.png"];
            [UIView animateWithDuration:0.3f
                                  delay: 0.0f
                 usingSpringWithDamping: 0.5
                  initialSpringVelocity: 1.0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                //Move the image view to 100, 100 over 10 seconds.
                Icon.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, Icon.frame.size.width, Icon.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 //NSLog(@"Done!");
            }];
            
            Overlay = 1;
            //NSLog(@"%lD",(long)Overlay);
        } else if (active ==2 && musicPlayer.playbackState==MPMusicPlaybackStatePlaying){
            NSLog(@"Display pause");
            CGRect newSize = CGRectMake(0.0f ,0.0f, 320.f, 600.0f);
            UIView *newView = [[UIView alloc] initWithFrame:newSize];
            _NewView = newView;
            [newView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
            [self.view addSubview:newView];
            State.text = @"Pause";
            Icon.image = [UIImage imageNamed:@"Pause200x200.png"];
            [UIView animateWithDuration:0.3f
                                  delay: 0.0f
                 usingSpringWithDamping: 0.5
                  initialSpringVelocity: 1.0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 //Move the image view to 100, 100 over 10 seconds.
                                 Icon.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, Icon.frame.size.width, Icon.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 //NSLog(@"Done!");
                             }];
            
            Overlay = 1;
            //NSLog(@"%lD",(long)Overlay);
        }
        
        else if (active ==3){
            NSLog(@"Display stop");
            CGRect newSize = CGRectMake(0.0f ,0.0f, 320.f, 600.0f);
            UIView *newView = [[UIView alloc] initWithFrame:newSize];
            _NewView = newView;
            [newView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
            [self.view addSubview:newView];
            State.text = @"You just stopped";
            Icon.image = [UIImage imageNamed:@"Stop200x200.png"];
            [UIView animateWithDuration:0.3f
                                  delay: 0.0f
                 usingSpringWithDamping: 0.5
                  initialSpringVelocity: 1.0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 //Move the image view to 100, 100 over 10 seconds.
                                 Icon.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, Icon.frame.size.width, Icon.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 //NSLog(@"Done!");
                             }];
            Overlay = 1;
            //NSLog(@"%lD",(long)Overlay);
        }
        
    } else {
        NSLog(@"Remove");
        State.text =@"";
        [_NewView removeFromSuperview];
        Overlay = 0;
        Icon.image = nil;
        Icon.frame = CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height - 100, 200, 200);
    }
    
}








-(void)Weather:(BOOL)test
{
    //do
}




@end
