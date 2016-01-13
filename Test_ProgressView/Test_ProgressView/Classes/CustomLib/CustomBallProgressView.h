//
//  CustomBallProgressView.h
//  Test_ProgressView
//
//  Created by forp on 16/1/8.
//  Copyright © 2016年 forp. All rights reserved.
//

#import "CustomBaseProgressView.h"

@interface CustomBallProgressView : CustomBaseProgressView

@property (nonatomic, strong) UIColor *backgrounBallColor;

@property (nonatomic, strong) UIColor *frontBallColor;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) BOOL gradientFlag;

@property (nonatomic, strong) UIColor *gradientStartColor;

@property (nonatomic, strong) UIColor *gradientEndColor;

@end
