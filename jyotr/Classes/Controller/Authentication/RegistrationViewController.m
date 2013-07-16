//
//  RegistrationViewController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "RegistrationViewController.h"
#import "HomeViewController.h"
#import <Parse/PFUser.h>

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
    self.nameField.delegate = self;
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
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
            HomeViewController *homeVC = [[HomeViewController alloc] init];
            [self.navigationController pushViewController:homeVC animated:YES];
        } else {
            //NSLog(@"%@ -- ", error);
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *invalidLogin  = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:errorString
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
            [invalidLogin show];
        }
    }];
}

- (IBAction)closeButtonTouchHandler:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender{
    [self.nameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
