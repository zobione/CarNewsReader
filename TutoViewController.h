//
//  TutoViewController.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 30/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface TutoViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *End;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) UIView *controls;

- (IBAction)test:(id)sender;


@property (weak, nonatomic) IBOutlet UIPageControl *PageControl;


@end
