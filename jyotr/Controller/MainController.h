//
//  MainController.h
//  jyotr
//
//  Created by Armen Mkrtchyan on 19/05/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

@interface MainController : NSObject

@property (nonatomic, strong) LoginViewController *loginVC;

-(UIViewController *) getMainView;

@end
