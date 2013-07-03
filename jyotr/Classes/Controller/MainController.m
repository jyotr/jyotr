//
//  MainController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "MainController.h"
#import "FacebookViewController.h"
#import "FacebookHelper.h"

@implementation MainController


- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


-(void)start {
    
    NSLog(@"Main View Start");
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser: %@", currentUser);
    
    if (currentUser && [PFFacebookUtils isLinkedWithUser:currentUser]) {
                  
        //Get Facebook friends
        NSArray *friends = [FacebookHelper getFriends];
        FacebookViewController *fbView = [[FacebookViewController alloc] initWithFriends:friends];
        fbView.friends = friends;
        [self.mainView presentViewController:fbView animated:YES completion:^{}];
        [[NSNotificationCenter defaultCenter] addObserverForName:@"fb_friends" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [fbView.tableView reloadData];
        }];
        
    } else {
        NSLog(@"LogInViewController");
    }

    
}







@end
