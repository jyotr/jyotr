//
//  MainController.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "MainController.h"

@implementation MainController


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UIViewController *) getMainView{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"MAIN VIEW");
        SignOutViewController *signOutVC = [[SignOutViewController alloc] init];
        self.mainView = signOutVC;
    } else {
        if (true/*!currentUser*/) {
            NSLog(@"LogInViewController");
            LogInViewController *logInController =[[LogInViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
            self.mainView = logInController;
        } else {
            NSLog(@"logged in user");
            // Send request to Facebook
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                // handle response
                NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
                
                if (!error) {
                    // Parse the data received
                    NSDictionary *userData = (NSDictionary *)result;
                    NSString *facebookID = userData[@"id"];
                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                    
                    if (facebookID) {
                        userProfile[@"facebookId"] = facebookID;
                    }
                    
                    if (userData[@"name"]) {
                        userProfile[@"name"] = userData[@"name"];
                    }
                    
                    if (userData[@"location"][@"name"]) {
                        userProfile[@"location"] = userData[@"location"][@"name"];
                    }
                    
                    if (userData[@"gender"]) {
                        userProfile[@"gender"] = userData[@"gender"];
                    }
                    
                    if (userData[@"birthday"]) {
                        userProfile[@"birthday"] = userData[@"birthday"];
                    }
                    
                    if (userData[@"relationship_status"]) {
                        userProfile[@"relationship"] = userData[@"relationship_status"];
                    }
                    
                    if ([pictureURL absoluteString]) {
                        userProfile[@"pictureURL"] = [pictureURL absoluteString];
                    }
                    
                    [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                    [[PFUser currentUser] saveInBackground];
                    
                } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                            isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
                    NSLog(@"The facebook session was invalidated");
                } else {
                    NSLog(@"Some other error: %@", error);
                }
                NSLog(@"%@", userProfile);
            }];
        }
    }
    return self.mainView;
}

@end
