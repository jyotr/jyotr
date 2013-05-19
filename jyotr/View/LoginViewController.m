//
//  LoginViewController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    [self setRegistrationButton:nil];
    [super viewDidUnload];
}
- (IBAction)openRegistration:(id)sender {
    
    RegistrationViewController *regVC = [[RegistrationViewController alloc] initWithNibName:@"RegistrationView_iPhone" bundle:nil];
    
    //Note presentViewController
    [self presentModalViewController:regVC animated:YES];
    
}

@end
