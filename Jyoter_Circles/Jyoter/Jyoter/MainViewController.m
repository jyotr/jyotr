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

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define POS_PINK_LEFT 410
#define POS_PINK_RIGHT 160

#define POS_LILAC_LEFT -200
#define POS_LILAC_RIGHT 80

#define POS_GREEN_LEFT 400
#define POS_GREEN_RIGHT 220

#define POS_BLUE_LEFT 400
#define POS_BLUE_RIGHT 265

#define POS_ORANGE_LEFT -200
#define POS_ORANGE_RIGHT 80

@interface MainViewController () {
    GenericBubbleCircle * pinkBubble;
    GenericBubbleCircle * lilacBubble;
    GenericBubbleCircle * blueBubble;
    GenericBubbleCircle * greenBubble;
    GenericBubbleCircle * orangeBubble;
    BOOL pinkVisible;
    BOOL lilacVisible;
    BOOL blueVisible;
    BOOL greenVisible;
    BOOL orangeVisible;
    BOOL bubbleZoomedIn;
}

@end

@implementation MainViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) loadView {
    [super loadView];
    pinkVisible = YES;
    lilacVisible = YES;
    blueVisible = YES;
    greenVisible = YES;
    orangeVisible = YES;
    bubbleZoomedIn = NO;
    
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    self.view.frame = CGRectMake(0, 0, 320, 480);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(animateBubbles) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Animate" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 10.0, 160.0, 40.0);
    
    [self.view addSubview:button];
    
    pinkBubble = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(POS_PINK_LEFT, 160, 160, 160) withColor: RGBA(255, 61, 97, 1.0) withRadius:80.0 withText:@"Create"];
    
    lilacBubble = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(POS_LILAC_LEFT, 280, 100, 100) withColor: RGBA(205, 97, 255, 1.0) withRadius:50.0 withText:@"Call"];
    
    blueBubble = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(POS_BLUE_LEFT, 240, 90, 90) withColor: RGBA(79, 188, 224, 1.0) withRadius:45.0 withText:@"fb"];
    
    greenBubble = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(POS_GREEN_LEFT, 310, 80, 80) withColor: RGBA(76, 199, 111, 1.0) withRadius:40.0 withText:@"Date"];
    
    orangeBubble = [[GenericBubbleCircle alloc] initWithColorFrameAnimationType:CGRectMake(POS_ORANGE_LEFT, 100, 100, 100) withColor: RGBA(252, 103, 53, 1.0) withRadius:50.0 withText:@"Profile"];
    
    [self.view addSubview: pinkBubble];
    [self.view addSubview: lilacBubble];
    [self.view addSubview: blueBubble];
    [self.view addSubview: greenBubble];
    [self.view addSubview: orangeBubble];
    
    [self.view bringSubviewToFront: pinkBubble];
    
    [self animateBubbles];
}

- (void) zoomInBubble:(GenericBubbleCircle *) bubble {
    [UIView animateWithDuration:0.7f
                     animations:^
     {
         [self.view bringSubviewToFront:bubble];
         [bubble setCenter:CGPointMake(160, 240)];
         
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.3f delay:0.0 options:0
                          animations:^{
                              bubble.transform = CGAffineTransformScale(bubble.transform, 10, 10);
                          }
                          completion:^(BOOL finished){
                              
                          }];
     }
     ];
    bubbleZoomedIn = YES;
}


- (void) zoomOutBubble:(GenericBubbleCircle *) bubble {
    [UIView animateWithDuration:0.7f
                     animations:^
     {
         bubble.transform = CGAffineTransformScale(bubble.transform, 1.0f/10.0f, 1.0f/10);  
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.3f delay:0.0 options:0
                          animations:^{
                               [bubble setCenter:CGPointMake(160, 240)];
                          }
                          completion:^(BOOL finished){
                             
                          }];
     }
     ];
    bubbleZoomedIn = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog(@"%@", touch.view);
    if([touch.view isKindOfClass:[GenericBubbleCircle class]])
    {
        // perform my actions
        if (bubbleZoomedIn) {
            [self zoomOutBubble:(GenericBubbleCircle*)touch.view];
        } else {
            [self zoomInBubble:(GenericBubbleCircle*)touch.view];
        }
    
    }
}

- (void) animateBubbles {
    [self performSelector:@selector(animatePinkBubble) withObject:nil afterDelay:.0];
    [self performSelector:@selector(animateGreenBubble) withObject:nil afterDelay:.8];
    [self performSelector:@selector(animateOrangeBubble) withObject:nil afterDelay:.9];
    [self performSelector:@selector(animateLilacBubble) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(animateBlueBubble) withObject:nil afterDelay:1.9];
//    [self animatePinkBubble];
//    [self animateLilacBubble];
//    [self animateGreenBubble];
//    [self animateBlueBubble];
//    [self animateOrangeBubble];
}

- (void) animatePinkBubble {
    NSValue * from = [NSNumber numberWithFloat:pinkBubble.layer.position.x];
    NSValue * to = pinkVisible ? [NSNumber numberWithFloat:POS_PINK_RIGHT] : [NSNumber numberWithFloat:POS_PINK_LEFT];
    NSString * keypath = @"position.x";
    [pinkBubble.layer addAnimation:[self bounceAnimationFrom:from to:to forKeyPath:keypath withDuration:.8] forKey:@"bounce"];
    [pinkBubble.layer setValue:to forKeyPath:keypath];
    pinkVisible = !pinkVisible;
}

- (void) animateLilacBubble {
    NSValue * from = [NSNumber numberWithFloat:lilacBubble.layer.position.x];
    NSValue * to = lilacVisible ? [NSNumber numberWithFloat:POS_LILAC_RIGHT] : [NSNumber numberWithFloat:POS_LILAC_LEFT];
    NSString * keypath = @"position.x";
    [lilacBubble.layer addAnimation:[self bounceAnimationFrom:from to:to forKeyPath:keypath withDuration:.8] forKey:@"bounce"];
    [lilacBubble.layer setValue:to forKeyPath:keypath];
    lilacVisible = !lilacVisible;
}

- (void) animateGreenBubble {
    NSValue * from = [NSNumber numberWithFloat:greenBubble.layer.position.x];
    NSValue * to = greenVisible ? [NSNumber numberWithFloat:POS_GREEN_RIGHT] : [NSNumber numberWithFloat:POS_GREEN_LEFT];
    NSString * keypath = @"position.x";
    [greenBubble.layer addAnimation:[self bounceAnimationFrom:from to:to forKeyPath:keypath withDuration:.8] forKey:@"bounce"];
    [greenBubble.layer setValue:to forKeyPath:keypath];
    greenVisible = !greenVisible;
}

- (void) animateBlueBubble {
    NSValue * from = [NSNumber numberWithFloat:blueBubble.layer.position.x];
    NSValue * to = blueVisible ? [NSNumber numberWithFloat:POS_BLUE_RIGHT] : [NSNumber numberWithFloat:POS_BLUE_LEFT];
    NSString * keypath = @"position.x";
    [blueBubble.layer addAnimation:[self bounceAnimationFrom:from to:to forKeyPath:keypath withDuration:.8] forKey:@"bounce"];
    [blueBubble.layer setValue:to forKeyPath:keypath];
    blueVisible = !blueVisible;
}
- (void) animateOrangeBubble {
    NSValue * from = [NSNumber numberWithFloat:orangeBubble.layer.position.x];
    NSValue * to = orangeVisible ? [NSNumber numberWithFloat:POS_ORANGE_RIGHT] : [NSNumber numberWithFloat:POS_ORANGE_LEFT];
    NSString * keypath = @"position.x";
    [orangeBubble.layer addAnimation:[self bounceAnimationFrom:from to:to forKeyPath:keypath withDuration:.8] forKey:@"bounce"];
    [orangeBubble.layer setValue:to forKeyPath:keypath];
    orangeVisible = !orangeVisible;
}
#pragma mark - CAAnimations

-(CABasicAnimation *)bounceAnimationFrom:(NSValue *)from
                                      to:(NSValue *)to
                              forKeyPath:(NSString *)keypath
                            withDuration:(CFTimeInterval)duration
{
    CABasicAnimation * result = [CABasicAnimation animationWithKeyPath:keypath];
    [result setFromValue:from];
    [result setToValue:to];
    [result setDuration:duration];
    
    [result setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.5 :1.8 :.8 :0.8]];
    
    return  result;
}


@end
