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
#import "StartViewController.h"
#import "HomeViewController.h"
#import "FacebookHelper.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"ZmXU76oRGKKHlMI4jWMyo1Zx7QAO0y5xfyGOe3d3"
                  clientKey:@"M0dWGklbwKe3fi80vwMz5TudOYn3pB8DlbSj8feN"];
    
    [PFTwitterUtils initializeWithConsumerKey:@"jUbO89kv9PhQPZj3Ld459w"
                               consumerSecret:@"gHhxcTKnitv75IQkN9lORheMFnvUP4P0EWJWN60"];
    
    [PFFacebookUtils initializeFacebook];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    NSLog(@"AppDelegate View Init");
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    StartViewController *startVC = [[StartViewController alloc] initWithNibName:@"StartView_iPhone" bundle:nil];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:startVC];
    [navVC setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navVC;
    
    [self.window makeKeyAndVisible];
    
    [startVC load];
    
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
