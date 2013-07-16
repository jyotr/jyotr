//
//  StartViewController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 16/07/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "StartViewController.h"
#import "LogInViewController.h"
#import "StartViewController.h"
#import "HomeViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

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

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)loginBtnHandler:(id)sender {
    LogInViewController *logInVC =[[LogInViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
    [self.navigationController pushViewController:logInVC animated:YES];
}

-(void)load{
    UIViewController *mainView;
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser: %@", currentUser);
    
    if (currentUser && [PFFacebookUtils isLinkedWithUser:currentUser]) {
        NSLog(@"Logged in user");
        HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeView_iPhone" bundle:nil];
        mainView = homeVC;
        
    } else {
        NSLog(@"Not Logged in");
        LogInViewController *logInVC =[[LogInViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
        mainView = logInVC;
    }
    
    [self.navigationController pushViewController:mainView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
