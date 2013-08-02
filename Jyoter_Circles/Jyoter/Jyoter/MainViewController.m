//
//  MainViewController.m
//  Jyoter
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Jyoter. All rights reserved.
//

#import "MainViewController.h"
#import "GenericBubbleCircle.h"
#import <QuartzCore/QuartzCore.h>


@interface MainViewController ()

@end

@implementation MainViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    self.view.frame = CGRectMake(0, 0, 320, 480);
    self.view.backgroundColor = [UIColor whiteColor];
    
    GenericBubbleCircle * sirennevi = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(30, 280, 100, 100) withColor:[UIColor colorWithRed:205/255.0 green:97/255.0 blue:1.0 alpha:1.0] withRadius:50.0];
    
    GenericBubbleCircle * kaput = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(210, 240, 90, 90) withColor:[UIColor colorWithRed:79/255.0 green:188/255.0 blue:224/255.0 alpha:1.0] withRadius:45.0];//[UIColor redColor]];
    
    GenericBubbleCircle * kanach = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(180, 310, 80, 80) withColor:[UIColor colorWithRed:76/255.0 green:199/255.0 blue:111/255.0 alpha:1.0] withRadius:40.0];
    
    GenericBubbleCircle * rozvi = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(80, 160, 160, 160) withColor:[UIColor colorWithRed:1.0 green:61/255.0 blue:97/255.0 alpha:1.0] withRadius:80.0];
    
    GenericBubbleCircle * orange = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(30, 100, 100, 100) withColor:[UIColor colorWithRed:252/255.0 green:103/255.0 blue:53/255.0 alpha:1.0] withRadius:50.0];

    
    [self.view addSubview:sirennevi];
    [self.view addSubview:kaput];
    [self.view addSubview:kanach];
    [self.view addSubview:rozvi];
    [self.view addSubview:orange];
    
    [self.view bringSubviewToFront:rozvi];
}

@end
