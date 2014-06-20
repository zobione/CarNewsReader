//
//  loginViewController.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 17/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
