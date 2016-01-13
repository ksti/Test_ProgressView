//
//  CustomBaseProgressView.h
//  Test_ProgressView
//
//  Created by forp on 16/1/8.
//  Copyright © 2016年 forp. All rights reserved.
//

#import <UIKit/UIKit.h>

//RGB Color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define CustomColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define CustomProgressViewItemMargin 10//0

#define CustomProgressViewFontScale (MIN(self.frame.size.width, self.frame.size.height) / 100.0)

// 背景颜色
#define CustomProgressViewBackgroundColor CustomColorMaker(240, 240, 240, 0.9)//[UIColor clearColor]

#define MAIN_SCREEN_ANIMATION_TIME 1.0f

@interface CustomBaseProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)setCenterProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes;

- (void)dismiss;

+ (id)progressView;

//获取图片中单个点的颜色：
- (UIColor*) getPixelColorAtLocation:(CGPoint)point Image:(UIImage *)image;
//渐变色图像
- (UIImage *)gradientImageContext:(CGRect)bounds imageSize:(CGSize)imageSize startColor:(UIColor *)colorStart endColor:(UIColor *)colorEnd;
//渐变色图像
- (UIImage *)gradientImageWithRect:(CGRect)rect startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor;

@end
