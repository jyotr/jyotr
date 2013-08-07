//
//  ApproveViewController.m
//  jyotr_map
//
//  Created by Armen Mkrtchian on 07/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import "ApproveViewController.h"
#import "AppDelegate.h"
#import "UIImage+Blur.h"
#import <QuartzCore/QuartzCore.h>
#import "MHNatGeoViewControllerTransition.h"

@interface ApproveViewController ()

@end

@implementation ApproveViewController {
    UIImageView *snapshotImageView;
    UIButton *approveButton;
    UIImageView *shareButtons;
    UIView *blurView;
    UIImageView *blurImageView;
    BOOL blur;
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
    [self dismissNatGeoViewController];
//    self.backButton.hidden = YES;
//    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    [del.navController popViewControllerAnimated:YES];
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
    
    
    //Share buttons
    shareButtons = [[UIImageView alloc] initWithFrame:CGRectMake(0, 330, 320, 117)];
    shareButtons.image = [UIImage imageNamed:@"shareButtons.png"];
    
    [self.view addSubview:shareButtons];
    
    blurImageView = [[UIImageView alloc] initWithFrame:shareButtons.frame];
    
    [self.view addSubview:blurImageView];
    
    blurImageView.image = [self getBlurredImage:shareButtons.frame withLevel:4];
        
    //Footer view init
    approveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 360, 320, 100)];
    UILabel *approveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    approveLabel.backgroundColor = [UIColor colorWithRed:5/255.0f green:252/255.0f blue:181/255.0f alpha:1.0f];
    approveLabel.textColor = [UIColor whiteColor];
    
    approveLabel.font = [UIFont systemFontOfSize:25.0f];
    approveLabel.textAlignment = UITextAlignmentCenter;
    
    approveLabel.text = @"Approve";
    [approveButton addSubview:approveLabel];
    [approveButton addTarget:self action:@selector(approve) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:approveButton];
}

- (void) approve {
    approveButton.hidden = NO;
    approveButton.alpha = 1.0f;
    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
    [UIView animateWithDuration:0.7 delay:0.0 options:0 animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        approveButton.alpha = 0.0f;
        blurImageView.image = [self getBlurredImage:shareButtons.frame withLevel:1];
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        approveButton.hidden = YES;
        blurImageView.hidden = YES;
    }];
    
    return;
}

- (UIImage*)getBlurredImage:(CGRect)blurRect withLevel:(int)level {
    // x, y and size variables below are only examples.
    // You will want to calculate this in code based on the view you will be presenting.
    float x = blurRect.origin.x;
    float y = blurRect.origin.y;
    CGSize size = blurRect.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, -x, -y);
    [self.view.layer renderInContext:c]; // view is the view you are grabbing the screen shot of. The view that is to be blurred.
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    for (int i=1; i<= level; i++) {
        image = [image gaussianBlurWithBias:0.0f];
    }
    return image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
