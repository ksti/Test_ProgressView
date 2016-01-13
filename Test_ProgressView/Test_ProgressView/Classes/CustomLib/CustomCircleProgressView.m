//
//  CustomCircleProgressView.m
//  Test_ProgressView
//
//  Created by forp on 16/1/8.
//  Copyright © 2016年 forp. All rights reserved.
//

#import "CustomCircleProgressView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度
#define PROCESS_COLOR [UIColor greenColor]

@interface CustomCircleProgressView () {
    CAShapeLayer *_trackLayer;
    CAShapeLayer *_progressLayer;
    CGFloat _percent;
}

@end

@implementation CustomCircleProgressView

- (void)drawRect:(CGRect)rect {
    //
    [self drawGradientLayer:(rect)];
}

- (void)clearLayers {
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    _progressLayer = nil;
    _trackLayer = nil;
}

- (void)createTrackLayer:(UIBezierPath *)path {
    _trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = self.bounds;
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    _trackLayer.strokeColor = [_strokeColor?_strokeColor:[UIColor blueColor] CGColor];//指定path的渲染颜色
    _trackLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _trackLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:(PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(-210) endAngle:degreesToRadians(30) clockwise:YES];//上面说明过了用来构建圆形
    _trackLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
}

- (void)drawGradientLayer:(CGRect)rect {
    
    [self clearLayers];
    
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - CustomProgressViewItemMargin;
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = rect;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [PROCESS_COLOR CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:(PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(-210) endAngle:degreesToRadians(30) clockwise:YES];//用来构建圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)) radius:(radius-PROGRESS_LINE_WIDTH) startAngle:degreesToRadians(-90) endAngle:degreesToRadians(270) clockwise:YES];//用来构建圆形
    _progressLayer.path = [path CGPath];
    
    [self createTrackLayer:path];
    
    //_progressLayer.strokeEnd = 0;
    [self setPercent:self.progress animated:self.animatedFlag];
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, rect.size.width/2, rect.size.height);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[UIColorFromRGB(0xfde802) CGColor], nil]];
    [gradientLayer1 setLocations:@[@0.5,@0.9,@1 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    [gradientLayer2 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer2.frame = CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[UIColorFromRGB(0xfde802) CGColor],(id)[[UIColor blueColor] CGColor], nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 0)];
    [gradientLayer addSublayer:gradientLayer2];
    
    [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
    
    // 进度数字
    NSString *progressStr = [NSString stringWithFormat:@"%.0f%s", self.progress * 100, "\%"];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:18 * CustomProgressViewFontScale];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [self setCenterProgressText:progressStr withAttributes:attributes];
}

-(void)setPercent:(CGFloat)percent animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:MAIN_SCREEN_ANIMATION_TIME];
    //_progressLayer.strokeEnd = percent/100.0;
    _progressLayer.strokeEnd = percent;
    [CATransaction commit];
}

@end
