//
//  openViewController.m
//  RecipeApp
//
//  Created by Emilien Sanchez on 17/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import "openViewController.h"
#import "homeViewController.h"
#import "loginViewController.h"
#import <Parse/Parse.h>

@interface openViewController ()

@end

@implementation openViewController

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
}

-(void)viewDidAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"Logged");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        homeViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
        [self presentViewController:lvc animated:YES completion:nil];
    }  else {
      /*  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        loginViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:lvc animated:YES completion:nil]; */
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

@end
