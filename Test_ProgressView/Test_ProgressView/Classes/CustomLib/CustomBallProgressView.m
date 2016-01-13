//
//  CustomBallProgressView.m
//  Test_ProgressView
//
//  Created by forp on 16/1/8.
//  Copyright © 2016年 forp. All rights reserved.
//

#import "CustomBallProgressView.h"

#define colorRatio 0.5

@implementation CustomBallProgressView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    //[[UIColor whiteColor] set];
    if (self.backgrounBallColor && [self.backgrounBallColor isKindOfClass:[UIColor class]]) {
        [self.backgrounBallColor set];
    } else {
        [[UIColor whiteColor] set];
    }
    
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - CustomProgressViewItemMargin;
    
    
    CGFloat w = radius * 2 + CustomProgressViewItemMargin;
    CGFloat h = w;
    CGFloat x = (rect.size.width - w) * 0.5;
    CGFloat y = (rect.size.height - h) * 0.5;
    CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
    CGContextFillPath(ctx);
    
    //[[UIColor grayColor] set];
    if (self.frontBallColor && [self.frontBallColor isKindOfClass:[UIColor class]]) {
        if (self.gradientFlag) {
            /*
            NSArray *arrColorRGB = [self changeUIColorToRGB:self.frontBallColor];
            if (4 == arrColorRGB.count) {
                CGFloat R = [arrColorRGB[0] floatValue] * colorRatio * self.progress + [arrColorRGB[0] floatValue] * (1 - colorRatio);
                CGFloat G = [arrColorRGB[1] floatValue] * colorRatio * self.progress + [arrColorRGB[1] floatValue] * (1 - colorRatio);
                CGFloat B = [arrColorRGB[2] floatValue] * colorRatio * self.progress + [arrColorRGB[2] floatValue] * (1 - colorRatio);
                CGFloat A = [arrColorRGB[3] floatValue];
                [CustomColorMaker(R, G, B, A) set];
            }
            */
            
            //
            CGRect rectGradient = CGRectMake(x, y, w, h);
            UIImage *gradientImage = [self gradientImageWithRect:rectGradient startColor:self.gradientStartColor?self.gradientStartColor.CGColor:[UIColor redColor].CGColor endColor:self.gradientEndColor?self.gradientEndColor.CGColor:[UIColor greenColor].CGColor];
            if (gradientImage) {
                //UIColor *color = [self getPixelColorAtLocation:CGPointMake(CGRectGetMidX(rectGradient), CGRectGetMinY(rectGradient) + CGRectGetHeight(rectGradient) * self.progress) Image:gradientImage];
                UIColor *color = [self getPixelColorAtLocation:CGPointMake(CGRectGetMidX(rectGradient), CGRectGetMinY(rectGradient) + 1 + (CGRectGetHeight(rectGradient) - 2) * self.progress) Image:gradientImage];
                if (color) {
                    [color set];
                }
            }
            
        } else {
            [self.frontBallColor set];
        }
    } else {
        [[UIColor grayColor] set];
    }
    CGFloat startAngle = M_PI * 0.5 - self.progress * M_PI;
    CGFloat endAngle = M_PI * 0.5 + self.progress * M_PI;
    CGContextAddArc(ctx, xCenter, yCenter, radius, startAngle, endAngle, 0);
    CGContextFillPath(ctx);
    
    // 进度数字
    NSString *progressStr = [NSString stringWithFormat:@"%.0f%s", self.progress * 100, "\%"];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:18 * CustomProgressViewFontScale];
    if (self.textColor) {
        attributes[NSForegroundColorAttributeName] = self.textColor;
    } else {
        attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    }
    [self setCenterProgressText:progressStr withAttributes:attributes];
}

//将UIColor转换为RGB值
- (NSMutableArray *) changeUIColorToRGB:(UIColor *)customColor
{
    CGFloat R, G, B, A;
    
    CGColorRef color = [customColor CGColor];
    NSInteger numComponents = CGColorGetNumberOfComponents(color);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        R = components[0];
        G = components[1];
        B = components[2];
        A = components[3];
        
        NSMutableArray *mArrRGB = [NSMutableArray array];
        [mArrRGB addObject:[NSNumber numberWithFloat:R * 255]];
        [mArrRGB addObject:[NSNumber numberWithFloat:G * 255]];
        [mArrRGB addObject:[NSNumber numberWithFloat:B * 255]];
        [mArrRGB addObject:[NSNumber numberWithFloat:A]];
        return mArrRGB;
    }
    //返回保存RGB值的数组
    return nil;
}

@end
