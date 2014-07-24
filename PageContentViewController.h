//
//  PageContentViewController.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 30/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;


@end
