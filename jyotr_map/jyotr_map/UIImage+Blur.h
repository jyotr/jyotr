//
//  UIImage+Blur.h
//  jyotr_map
//
//  Created by Armen Mkrtchyan on 07/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;
-(UIImage*)gaussianBlurWithBias:(NSInteger)bias;
@end
