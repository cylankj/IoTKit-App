//
//  FLProgressHUDRingIndicatorView.m
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import "FLProgressHUDRingIndicatorView.h"

@interface FLProgressHUDRingIndicatorView()
{
    CAShapeLayer *forwardShapeLayer;
    CAShapeLayer *backgroundShapeLayer;
}
@end

@implementation FLProgressHUDRingIndicatorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width != frame.size.height) {
        frame = CGRectMake(frame.origin.x, frame.origin.y,MIN(frame.size.height, frame.size.width), MIN(frame.size.height, frame.size.width));
    }
    if (self = [super initWithFrame:frame]) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds ];
        backgroundShapeLayer = [CAShapeLayer layer];
        backgroundShapeLayer.frame = self.bounds;
        backgroundShapeLayer.position = self.center;
        backgroundShapeLayer.fillColor = [UIColor clearColor].CGColor;
        backgroundShapeLayer.strokeColor = [UIColor grayColor].CGColor;
        backgroundShapeLayer.path = bezierPath.CGPath;
        backgroundShapeLayer.lineWidth = self.bounds.size.width/8.0;
        backgroundShapeLayer.strokeEnd = 1;
        [self.layer addSublayer:backgroundShapeLayer];
        
        forwardShapeLayer = [CAShapeLayer layer];
        forwardShapeLayer.frame = self.bounds;
        forwardShapeLayer.position = self.center;
        forwardShapeLayer.fillColor = [UIColor clearColor].CGColor;
        forwardShapeLayer.strokeColor = [UIColor blackColor].CGColor;
        forwardShapeLayer.path = bezierPath.CGPath;
        forwardShapeLayer.lineWidth = backgroundShapeLayer.lineWidth;
        forwardShapeLayer.strokeEnd = 0;
        forwardShapeLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:forwardShapeLayer];
        
        
    }
    return self;
}

-(void)setForwardRingColor:(UIColor *)forwardRingColor
{
    _forwardRingColor = forwardRingColor;
    forwardShapeLayer.strokeColor = forwardRingColor.CGColor;
}

-(void)setBackgroungRingColor:(UIColor *)backgroungRingColor
{
    _backgroungRingColor = backgroungRingColor;
    backgroundShapeLayer.strokeColor = backgroungRingColor.CGColor;
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    forwardShapeLayer.strokeEnd = progress;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
