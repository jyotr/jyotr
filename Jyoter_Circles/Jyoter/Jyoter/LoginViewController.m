//
//  LoginViewController.m
//  Jyoter
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Jyoter. All rights reserved.
//

#import "LoginViewController.h"
#import "UINavigationController+Fade.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) goToMainView {
    MainViewController * mainVC = [[MainViewController alloc] init];
    [self.navigationController pushFadeViewController:mainVC];
}

- (void) loadView {
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 320, 480);
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * testAnimation = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testAnimation setTitle:@"Fade" forState:UIControlStateNormal];
    
    
    testAnimation.frame = CGRectMake(100, 200, 100, 30);
    [testAnimation addTarget:self action:@selector(goToMainView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testAnimation];
}

@end
