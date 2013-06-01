//
//  SignOutViewController.m
//  jyotr
//
//  Created by Anatoli Petrosyants on 6/1/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "SignOutViewController.h"

@interface SignOutViewController ()

@end

@implementation SignOutViewController

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

- (IBAction)signOut:(id)sender {
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"sign out -- %@",currentUser);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
