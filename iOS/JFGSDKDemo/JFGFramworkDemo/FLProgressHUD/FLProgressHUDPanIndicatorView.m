//
//  FLProgressHUDPanIndicatorView.m
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import "FLProgressHUDPanIndicatorView.h"

@interface FLProgressHUDPanIndicatorView()
{
    //进度
    CAShapeLayer *progressShapeLayer;
    //环形遮罩
    CAShapeLayer *ringShapeLayer;
}
@end


@implementation FLProgressHUDPanIndicatorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width != frame.size.height) {
        frame = CGRectMake(frame.origin.x, frame.origin.y,MIN(frame.size.height, frame.size.width), MIN(frame.size.height, frame.size.width));
    }
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.width/2.0;
        
        //创建shapeLayer
        progressShapeLayer = [CAShapeLayer layer];
        progressShapeLayer.frame = self.bounds;
        progressShapeLayer.position = self.center;
        //创建圆形贝塞尔曲线
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        //关联贝塞尔曲线与shapeLayer
        progressShapeLayer.path = bezierPath.CGPath;
        //设置线条宽度
        progressShapeLayer.lineWidth = self.bounds.size.width;
        //设置路径颜色
        progressShapeLayer.strokeColor = [UIColor blackColor].CGColor;
        //设置填充颜色
        progressShapeLayer.fillColor = [UIColor clearColor].CGColor;
        //设置路径结束位置(默认开始位置为0)
        progressShapeLayer.strokeEnd = 0.f;
        [self.layer addSublayer:progressShapeLayer];
        
        
        ringShapeLayer = [CAShapeLayer layer];
        ringShapeLayer.frame = self.bounds;
        ringShapeLayer.position = self.center;
        UIBezierPath *outsideBezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        ringShapeLayer.path = outsideBezierPath.CGPath;
        ringShapeLayer.fillColor = [UIColor clearColor].CGColor;
        ringShapeLayer.lineWidth = self.bounds.size.width/15.0;
        ringShapeLayer.strokeColor = [UIColor blackColor].CGColor;
        ringShapeLayer.strokeEnd = 1;
        [self.layer addSublayer:ringShapeLayer];
        
        
    }
    return self;
}

@synthesize progress = _progress;

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    progressShapeLayer.strokeEnd = progress;
}


@synthesize progressColor = _progressColor;

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    progressShapeLayer.strokeColor = progressColor.CGColor;
    ringShapeLayer.strokeColor = progressColor.CGColor;
}

@end
