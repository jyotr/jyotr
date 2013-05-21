//
//  AppDelegate.m
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "MainController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"ZmXU76oRGKKHlMI4jWMyo1Zx7QAO0y5xfyGOe3d3"
                  clientKey:@"M0dWGklbwKe3fi80vwMz5TudOYn3pB8DlbSj8feN"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    MainController *mainController = [[MainController alloc] init];
    
    self.window.rootViewController = [mainController getMainView];
    [self.window makeKeyAndVisible];
    return YES;
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
