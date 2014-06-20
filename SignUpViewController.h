//
//  SignUpViewController.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 17/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;
- (IBAction)signUp:(id)sender;

@end
