//
//  MainController.h
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "LogInViewController.h"
#import "SignOutViewController.h"

@interface MainController : NSObject <PFLogInViewControllerDelegate>

@property(nonatomic) UIViewController *mainView;
-(UIViewController *) getMainView;

@end
