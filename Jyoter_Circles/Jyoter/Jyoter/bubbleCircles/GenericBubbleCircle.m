//
//  GenericBubbleCircle.m
//  Jyoter
//
//  Created by Armen Abrahamyan on 8/2/13.
//  Copyright (c) 2013 Jyoter. All rights reserved.
//

#import "GenericBubbleCircle.h"
#import <QuartzCore/QuartzCore.h>

@implementation GenericBubbleCircle

- (id) initWithColorFrameAnimationType: (CGRect) frame
                             withColor: (UIColor *) color
                            withRadius: (CGFloat) radius
                              withText: (NSString *) text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = color;
        self.layer.opacity = 0.9;
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0,-1.0);
        self.layer.shadowRadius = 60;
        
        self.layer.borderColor = [UIColor colorWithRed:230/255.0 green:227/255.0 blue:228/255.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 2.0;
        self.layer.cornerRadius = radius;
        self.center = self.center;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont fontWithName:@"desyrel" size:radius/1.8];
        textLabel.numberOfLines = 2;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = text;
        [self addSubview: textLabel];
    }
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect {
 [super drawRect:rect];
 CGPoint c = self.center ;
 // Drawing code
 CGContextRef cx = UIGraphicsGetCurrentContext();
 
 CGContextSaveGState(cx);
 CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
 
 CGFloat comps[] = {1.0,1.0,0.0,1.0,0.0,1.0,0.0,1.0};
 CGFloat locs[] = {0,1};
 CGGradientRef g = CGGradientCreateWithColorComponents(space, comps, locs, 2);
 
 
 CGMutablePathRef path = CGPathCreateMutable();
 CGPathMoveToPoint(path, NULL, c.x, c.y);
 CGPathAddLineToPoint(path, NULL, c.x, c.y-100);
 CGPathAddArcToPoint(path, NULL, c.x+100, c.y-100, c.x+100, c.y, 100);
 CGPathAddLineToPoint(path, NULL, c.x, c.y);
 
 CGContextAddPath(cx, path);
 CGContextClip(cx);
 
 CGContextDrawRadialGradient(cx, g, c, 1.0f, c, 320.0f, 0);
 
 CGContextRestoreGState(cx);
 }*/


@end
