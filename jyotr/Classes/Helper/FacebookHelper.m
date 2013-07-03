//
//  FacebookHelper.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 04/06/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "FacebookHelper.h"

@implementation FacebookHelper

#pragma mark -
#pragma mark Singleton Variables
static FacebookHelper *singletonDelegate = nil;

#pragma mark -
#pragma mark Singleton Methods

+ (FacebookHelper *)sharedInstance {
    @synchronized (self) {
        if (singletonDelegate == nil) {
            singletonDelegate = [[self alloc] init]; // assignment not done here
        }
    }
    return singletonDelegate;
}

- (id)init {
    if (!kAppId) {
        NSLog(@"missing app id!");
        exit(1);
        return nil;
    }

    if ((self = [super init])) {
//        _permissions = [NSArray arrayWithObjects:@"read_stream", @"publish_stream", @"offline_access", @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", nil];
        _permissions = [NSArray arrayWithObjects:@"user_about_me", @"user_relationships", @"user_birthday", @"user_location", nil];
    }

    return self;
}

-(void)login {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = _permissions;
    //PFUser *currentUser = [PFUser currentUser];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
        } else {
            NSLog(@"User with facebook logged in!");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fb_login" object:nil userInfo:nil];
        }
    }];
}

+ (NSArray *)getFriends {
    // Issue a Facebook Graph API request to get your user's friend list
    __block NSArray *friendObjects;

    [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
       if (!error) {
           // result will contain an array with your user's friends in the "data" key
            
           friendObjects = [result objectForKey:@"data"];
            
           NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
           // Create a list of friends' Facebook IDs
           for (NSDictionary *friendObject in friendObjects) {
               [friendIds addObject:[friendObject objectForKey:@"id"]];
           }
            
           NSLog(@"%@", friendObjects);
           [[NSNotificationCenter defaultCenter] postNotificationName:@"fb_friends" object:nil userInfo:nil];
        }
    }];
    return friendObjects;
}

+ (NSMutableDictionary *)getMyInfo:(PFUser *)currentUser {

    NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];

        if (!error) {
            //Link Parse user with Facebook account
            if (![PFFacebookUtils isLinkedWithUser:currentUser]) {
                [PFFacebookUtils linkUser:currentUser permissions:nil block:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"Woohoo, user is linked with Facebook!");
                    }
                }];
            }

            // Parse the data received
            NSDictionary *userData = (NSDictionary *) result;
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
                isEqualToString:@"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
        } else {
            NSLog(@"Some other error: %@", error);
        }
        NSLog(@"%@", userProfile);
    }];
    return userProfile;
}

+(void)graphApi:(NSString *)graphPath {
    NSLog(@"starting request with path: %@", graphPath);
//    NSMutableDictionary *params
    FBRequest *request = [FBRequest requestForGraphPath:graphPath];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if(!error) {
            NSLog(@"request completed to graph API: %@, with result: %@", graphPath, result);
        }
        
    }];
}

+ (void)getPublishPermissions:(PFUser *)currentUser {
    //Get publish permissions
    [PFFacebookUtils reauthorizeUser:currentUser
              withPublishPermissions:@[@"publish_stream"]
                            audience:FBSessionDefaultAudienceFriends
                               block:^(BOOL succeeded, NSError *error) {
                                   if (succeeded) {
                                       NSLog(@"reauthorizeUser: publish_stream");
                                       // Your app now has publishing permissions for the user
                                   }
                               }];
}

@end
