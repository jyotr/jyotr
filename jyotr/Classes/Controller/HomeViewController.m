//
//  HomeViewController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 03/07/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "FacebookHelper.h"
#import "HomeViewController.h"
#import "SignOutViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    [self setGraphPath:nil];
    [super viewDidUnload];
}
- (IBAction)getGraph:(id)sender {
    [FacebookHelper graphApi:self.graphPath.text withNotifier:nil];
}

- (IBAction)friends:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(viewFriends:)
												 name:@"fb_friends"
											   object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"fb_friends" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//        
//        
//    }];
    [FacebookHelper graphApi:@"/me/friends" withNotifier:@"fb_friends"];
    
    self.fbView = [[FacebookViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:self.fbView animated:YES];
    
}

- (void) viewFriends:(NSNotification *)notification{
    NSDictionary *theDict = [notification object];
    NSLog(@"theArray %@", theDict);
    
    NSArray *friendsObjects = [theDict objectForKey:@"data"];
    
    self.fbView.friends = friendsObjects;
    
    [self.fbView.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"fb_friends"
                                                  object:nil];
}

- (IBAction)signout:(id)sender {
    SignOutViewController *signOutVC = [[SignOutViewController alloc] initWithNibName:@"SignoutView_iPhone" bundle:nil];
    [self.navigationController pushViewController:signOutVC animated:YES];
}
@end
