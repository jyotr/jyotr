//
//  LogInViewController.m
//  jyotr
//
//  Created by Anatoli Petrosyants on 5/21/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LogInViewController.h"
#import "HomeViewController.h"
#import "FacebookHelper.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

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
    self.userNameField.delegate = self;
    self.loginPasswordField.delegate = self;
}

/* Login to facebook method */
- (IBAction)loginFacebookButtonTouchHandler:(id)sender  {
    [[FacebookHelper sharedInstance] login];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"fb_login" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeView_iPhone" bundle:nil];
        [self.navigationController pushViewController:homeVC animated:YES];
    }];
    
}

- (IBAction)loginTwitterButtonTouchHandler:(id)sender  {
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }
    }];

}

- (IBAction)registrationButtonTouchHandler:(id)sender {
    RegistrationViewController *registVC =[[RegistrationViewController alloc] initWithNibName:@"RegistrationView_iPhone" bundle:nil];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)loginButtonTouchHandler:(id)sender {
    [self dismissKeyboard];
    [PFUser logInWithUsernameInBackground:self.userNameField.text password:self.loginPasswordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"Do stuff after successful login.");
                                            HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeView_iPhone" bundle:nil];
                                            [self.navigationController pushViewController:homeVC animated:YES];
                                        } else {
                                            //NSLog(@"%@ -- ", error);
                                            UIAlertView *invalidLogin  = [[UIAlertView alloc] initWithTitle:nil
                                                                                                         message:@"Invalid Login"
                                                                                                        delegate:self
                                                                                               cancelButtonTitle:@"OK"
                                                                                               otherButtonTitles:nil];
                                            [invalidLogin show];
                                        }
                                    }];
}

- (IBAction)resetPasswordTouchHandler:(id)sender {
    #warning Incomplete method implementation.
    NSLog(@"reset password");
    //check not empty before using
    [PFUser requestPasswordResetForEmailInBackground:@"tolik.petrosyants@mail.ru"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.userNameField isFirstResponder] && (self.userNameField != touch.view))
    {
        // textField1 lost focus
        [self.userNameField resignFirstResponder];
    }
    
    if ([self.loginPasswordField isFirstResponder] && (self.loginPasswordField != touch.view))
    {
        // textField2 lost focus
        [self.loginPasswordField resignFirstResponder];
    }
}


- (void)dismissKeyboard{
    [self.userNameField resignFirstResponder];
    [self.loginPasswordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserNameField:nil];
    [self setLoginPasswordField:nil];
    [super viewDidUnload];
}
@end
