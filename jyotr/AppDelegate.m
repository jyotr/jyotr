//
//  AppDelegate.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "LogInViewController.h"
#import "SignOutViewController.h"
#import "HomeViewController.h"
#import "FacebookHelper.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"ZmXU76oRGKKHlMI4jWMyo1Zx7QAO0y5xfyGOe3d3"
                  clientKey:@"M0dWGklbwKe3fi80vwMz5TudOYn3pB8DlbSj8feN"];
    
    [PFTwitterUtils initializeWithConsumerKey:@"jUbO89kv9PhQPZj3Ld459w"
                               consumerSecret:@"gHhxcTKnitv75IQkN9lORheMFnvUP4P0EWJWN60"];
    
    [PFFacebookUtils initializeFacebook];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    // Override point for customization after application launch.
    NSLog(@"AppDelegate View Init");
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
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainView];
    [navVC setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
