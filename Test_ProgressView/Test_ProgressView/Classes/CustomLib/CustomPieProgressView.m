//
//  CustomPieProgressView.m
//  Test_ProgressView
//
//  Created by forp on 16/1/12.
//  Copyright © 2016年 forp. All rights reserved.
//

#import "CustomPieProgressView.h"

#define CustomProgressViewFontScale (MIN(self.frame.size.width, self.frame.size.height) / 100.0)

@implementation CustomPieProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - CustomProgressViewItemMargin * 0.2;
    
    UIGraphicsBeginImageContext(rect.size);
    /**/
    CGContextRef imgCtx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(imgCtx, xCenter, yCenter);
    CGContextSetFillColor(imgCtx, CGColorGetComponents([UIColor blackColor].CGColor));
    CGFloat to = M_PI * 0.5 - self.progress * M_PI * 2; // 初始值
    //CGContextAddArc(imgCtx, xCenter, yCenter, radius,  M_PI/2, -5*M_PI/4, 1);
    CGContextAddArc(imgCtx, xCenter, yCenter, radius,  M_PI/2, to, 1);
    CGContextFillPath(imgCtx);
    //save the context content into the image mask
    //CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    CGImageRef mask = CGBitmapContextCreateImage(imgCtx);
    
    UIGraphicsEndImageContext();
    /**/
    CGContextRelease(imgCtx);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    //CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, self.bounds, mask);
    UIGraphicsPopContext();
    //CGContextRestoreGState(ctx);
    
    /**/
    CGImageRelease(mask);
    
    //方法A:
    /*
     //UIColor *startColor=[UIColor yellowColor];
     //UIColor *endColor= [UIColor blueColor];
     //UIColor *colors[2] = {startColor,endColor};
     NSArray *arrColors = [NSArray arrayWithObjects:[UIColor yellowColor], [UIColor blueColor], nil];
     UIColor *colors[arrColors.count];
     for (int i = 0; i < arrColors.count; i++) {
     colors[i] = arrColors[i];
     }
     CGFloat components[arrColors.count*4];
     for (int i = 0; i < arrColors.count; i++) {
     CGColorRef tmpcolorRef = colors[i].CGColor;
     const CGFloat *tmpcomponents = CGColorGetComponents(tmpcolorRef);
     for (int j = 0; j < 4; j++) {
     components[i * 4 + j] = tmpcomponents[j];
     }
     }
     */
    
    NSArray *arrColors = self.gradientColors.count > 0 ? self.gradientColors :[NSArray arrayWithObjects:[UIColor yellowColor], [UIColor blueColor], nil];//如果数组里是两个相同的颜色，则没有渐变效果
    UIColor *colors[arrColors.count];
    for (int i = 0; i < arrColors.count; i++) {
        colors[i] = arrColors[i];
    }
    CGFloat components[arrColors.count*4];
    for (int i = 0; i < arrColors.count; i++) {
        CGColorRef tmpcolorRef = colors[i].CGColor;
        const CGFloat *tmpcomponents = CGColorGetComponents(tmpcolorRef);
        for (int j = 0; j < 4; j++) {
            components[i * 4 + j] = tmpcomponents[j];
        }
    }
    
    /*
    //方法B:
    CGFloat components[8]={
        1.0, 1.0, 0.0, 1.0,     //start color(r,g,b,alpha)
        0.0, 0.0, 1.0, 1.0      //end color
    };
    */
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    //CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,2);
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL, (arrColors.count > 1) ? arrColors.count : 2);//直接写个2会带透明效果不知道为什么。。
    CGColorSpaceRelease(space),space=NULL;//release
    
    CGPoint start = CGPointMake(xCenter, yCenter);
    CGPoint end = CGPointMake(xCenter, yCenter);
    CGFloat startRadius = 0.0f;
    CGFloat endRadius = radius;
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
    CGGradientRelease(gradient),gradient=NULL;//release
}

@end
