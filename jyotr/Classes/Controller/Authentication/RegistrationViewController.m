//
//  RegistrationViewController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "RegistrationViewController.h"
#import <Parse/PFUser.h>
#import "SignOutViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSignupBtn:nil];
    [self setNameField:nil];
    [self setEmailField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
}

- (IBAction)signUp:(id)sender {
    
    PFUser *user = [PFUser user];
    user.username = self.nameField.text;
    user.password = self.passwordField.text;
    user.email = self.emailField.text;
    
    // other fields can be set just like with PFObject
    //[user setObject:@"415-392-0202" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Hooray! Let them use the app now.");
            SignOutViewController *signOutVC = [[SignOutViewController alloc] init];
            [self.navigationController pushViewController:signOutVC animated:YES];
        } else {
            //NSString *errorString = [[error userInfo] objectForKey:@"error"];
             NSLog(@"Show the errorString somewhere and let the user try again.");
        }
    }];
}

- (IBAction)closeButtonTouchHandler:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dismissKeyboard:(id)sender{
    [self.nameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
