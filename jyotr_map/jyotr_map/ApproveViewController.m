//
//  ApproveViewController.m
//  jyotr_map
//
//  Created by Armen Mkrtchian on 07/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import "ApproveViewController.h"
#import "AppDelegate.h"

@interface ApproveViewController ()

@end

@implementation ApproveViewController {
    UIImageView *snapshotImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) goBack {
    
//    self.backButton.hidden = YES;
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [del.navController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:216/255.0f green:222/255.0f blue:222/255.0f alpha:1.0f];
    
    
    
    //Header view init
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    topLabel.backgroundColor = [UIColor whiteColor];
    topLabel.textColor = [UIColor blackColor];
    
    topLabel.font = [UIFont systemFontOfSize:25.0f];
    topLabel.textAlignment = UITextAlignmentCenter;
    
    topLabel.text = @"Check the details";
    [topView addSubview:topLabel];
    
    
    
    //Back button init
    
    self.backButton = [[UIButton alloc] init];
    [self.backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateSelected];
    [self.backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateHighlighted];
    self.backButton.showsTouchWhenHighlighted = YES;
    self.backButton.frame = CGRectMake(15, 15, 12, 20.5f);
    [self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.backButton];
    
    [self.view addSubview:topView];
    
    snapshotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 150)];
    [self.view addSubview:snapshotImageView];
    
    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=16&size=320x150&sensor=false&visual_refresh=true&scale=2&format=png&maptype=roadmap&markers=%f,%f", self.selectedCoordinate.latitude, self.selectedCoordinate.longitude,self.selectedCoordinate.latitude, self.selectedCoordinate.longitude]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    snapshotImageView.image = image;
    
    //Time label
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 205, 320, 33)];
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.textColor = [UIColor blackColor];
    
    timeLabel.font = [UIFont systemFontOfSize:18.0f];
    timeLabel.textAlignment = UITextAlignmentCenter;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EE dd, MMMM  hh:mm";
    NSString *timeText = @"Blind time    ";
    timeLabel.text = [timeText stringByAppendingString:[dateFormatter stringFromDate:self.selectedDate]] ;
    
    [self.view addSubview:timeLabel];
    
    //Footer view init
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 410, 320, 100)];
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    bottomLabel.backgroundColor = [UIColor colorWithRed:5/255.0f green:252/255.0f blue:181/255.0f alpha:1.0f];
    bottomLabel.textColor = [UIColor whiteColor];
    
    bottomLabel.font = [UIFont systemFontOfSize:25.0f];
    bottomLabel.textAlignment = UITextAlignmentCenter;
    
    bottomLabel.text = @"Approve";
    [bottomView addSubview:bottomLabel];
    
    [self.view addSubview:bottomView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
