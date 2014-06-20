//
//  selectionViewController.m
//  RecipeApp
//
//  Created by Emilien Sanchez on 17/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "selectionViewController.h"
#import <Parse/Parse.h>

@interface selectionViewController ()

@end

@implementation selectionViewController

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
    PFQueryTableViewController *tblView = [PFQueryTableViewController alloc];
    //tblView.view.frame = CGRectMake(0, 0, 320, 150);
    tblView.parseClassName = @"Todo";
    tblView.pullToRefreshEnabled = YES;
    tblView.paginationEnabled = YES;
    tblView.objectsPerPage = 25;
    [self addChildViewController:tblView];
    tblView.view.frame = CGRectMake(0, 0, 320, 150);
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

@end
