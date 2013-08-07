//
//  UIImage+Blur.m
//  jyotr_map
//
//  Created by Armen Mkrtchyan on 07/08/13.
//  Copyright (c) 2013 Armen Mkrtchian. All rights reserved.
//

#import "UIImage+Blur.h"
#import <Accelerate/Accelerate.h>

#define kNyxNumberOfComponentsPerARBGPixel 4
static CGColorSpaceRef __rgbColorSpace = NULL;

@implementation UIImage (Blur)

-(UIImage *)boxblurImageWithBlur:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 50);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"JFDepthView: error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

static int16_t __s_gaussianblur_kernel_5x5[25] = {
	1, 4, 6, 4, 1,
	4, 16, 24, 16, 4,
	6, 24, 36, 24, 6,
	4, 16, 24, 16, 4,
	1, 4, 6, 4, 1
};

CGContextRef NYXCreateARGBBitmapContext(const size_t width, const size_t height, const size_t bytesPerRow, BOOL withAlpha)
{
	/// Use the generic RGB color space
	/// We avoid the NULL check because CGColorSpaceRelease() NULL check the value anyway, and worst case scenario = fail to create context
	/// Create the bitmap context, we want pre-multiplied ARGB, 8-bits per component
	CGImageAlphaInfo alphaInfo = (withAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst);
	CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8/*Bits per component*/, bytesPerRow, NYXGetRGBColorSpace(), kCGBitmapByteOrderDefault | alphaInfo);
    
	return bmContext;
}

CGColorSpaceRef NYXGetRGBColorSpace(void)
{
	if (!__rgbColorSpace)
	{
		__rgbColorSpace = CGColorSpaceCreateDeviceRGB();
	}
	return __rgbColorSpace;
}

BOOL NYXImageHasAlpha(CGImageRef imageRef)
{
	CGImageAlphaInfo alpha = CGImageGetAlphaInfo(imageRef);
	BOOL hasAlpha = (alpha == kCGImageAlphaFirst || alpha == kCGImageAlphaLast || alpha == kCGImageAlphaPremultipliedFirst || alpha == kCGImageAlphaPremultipliedLast);
    
	return hasAlpha;
}

-(UIImage*)gaussianBlurWithBias:(NSInteger)bias
{
	/// Create an ARGB bitmap context
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;
	const size_t bytesPerRow = width * kNyxNumberOfComponentsPerARBGPixel;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(width, height, bytesPerRow, NYXImageHasAlpha(self.CGImage));
	if (!bmContext)
		return nil;
    
	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
	/// Grab the image raw data
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}
    
	const size_t n = sizeof(UInt8) * width * height * 4;
	void* outt = malloc(n);
	vImage_Buffer src = {data, height, width, bytesPerRow};
	vImage_Buffer dest = {outt, height, width, bytesPerRow};
	vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_gaussianblur_kernel_5x5, 5, 5, 256/*divisor*/, bias, NULL, kvImageCopyInPlace);
	memcpy(data, outt, n);
	free(outt);
    
	CGImageRef blurredImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage* blurred = [UIImage imageWithCGImage:blurredImageRef];
    
	/// Cleanup
	CGImageRelease(blurredImageRef);
	CGContextRelease(bmContext);
    
	return blurred;
}

@end