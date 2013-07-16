//
//  LogInViewController.h
//  jyotr
//
//  Created by Anatoli Petrosyants on 5/21/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <Parse/Parse.h>
#import "RegistrationViewController.h"

@interface LogInViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;


- (IBAction)loginFacebookButtonTouchHandler:(id)sender;
- (IBAction)loginTwitterButtonTouchHandler:(id)sender;
- (IBAction)registrationButtonTouchHandler:(id)sender;
- (IBAction)loginButtonTouchHandler:(id)sender;
- (IBAction)resetPasswordTouchHandler:(id)sender;

@end
