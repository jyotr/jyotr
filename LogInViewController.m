//
//  LogInViewController.m
//  jyotr
//
//  Created by Anatoli Petrosyants on 5/21/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:
    //                             [UIImage imageNamed:@"bg.jpg"]];
    //Customize Logo
    UILabel *label =[[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor brownColor];
    label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:55];
    label.text = @"JYotr";
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    self.logInView.logo = label;
    self.logInView.logo.frame = CGRectMake(0, 0, 320, 40);
    
    /*//FaceBook Button
    self.logInView.facebookButton.frame = CGRectMake(0.0, 44.0, 314, 44);
    UIImage *image = [[UIImage imageNamed:@"fb.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0,10.0,0.0,10.0)];
    [self.logInView.facebookButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
    NSLog(@"%@",self.logInView.facebookButton);
    */
    //self.logInView.logInButton.frame = CGRectMake(0, 0, 320, 80);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
