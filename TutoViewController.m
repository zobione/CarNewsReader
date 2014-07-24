//
//  TutoViewController.m
//  RecipeApp
//
//  Created by Emilien Sanchez on 30/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "TutoViewController.h"
#import "selectionViewController.h"

@interface TutoViewController ()

@end

@implementation TutoViewController
@synthesize pageViewController;
@synthesize controls;
@synthesize End;
@synthesize PageControl;

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
    _pageTitles = @[@"test", @"test", @"test"];
    _pageImages = @[@"P1.png", @"P2.png", @"P3.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 37);
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [self.view addSubview:pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
    
    [End setFrame:CGRectMake(End.frame.origin.x, self.view.frame.size.height - 100, End.frame.size.width, End.frame.size.height)];
    
    PageControl = [UIPageControl appearance];
    PageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    PageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    PageControl.backgroundColor = [UIColor clearColor];
    [controls addSubview:PageControl.superview];
    
    [self.view insertSubview:controls aboveSubview:pageViewController.view];
    [self.view bringSubviewToFront:self.End];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    PageControl.currentPage = index;
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}





- (IBAction)test:(id)sender {
    NSLog(@"touch");
    //do
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    selectionViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"selection"];
    [self presentViewController:lvc animated:YES completion:nil];
}




@end
