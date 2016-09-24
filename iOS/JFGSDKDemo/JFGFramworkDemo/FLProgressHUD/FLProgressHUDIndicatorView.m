//
//  FLProgressHUDIndicatorView.m
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import "FLProgressHUDIndicatorView.h"


@interface FLProgressHUDIndicatorView()
{
    FLProgressHUDStyle _style;
}
@end

@implementation FLProgressHUDIndicatorView

-(instancetype)initWithStyle:(FLProgressHUDStyle)style IndicatorViewStyle:(FLProgressHUDIndicatorViewStyle)indicatorViewStyle
{
    if (self = [super init]) {
        _indicatorViewStyle = indicatorViewStyle;
        _style = style;
        [self initFLProgressHUDIndicatorView];
    }
    return self;
}

-(void)initFLProgressHUDIndicatorView
{
    if (_indicatorViewStyle == FLProgressHUDIndicatorViewSystem) {
        
        UIActivityIndicatorView * systemIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [systemIndicatorView startAnimating];
        
        if (_style != FLProgressHUDStyleDark) {
            systemIndicatorView.color = [UIColor blackColor];
        }
        _indicatorView = systemIndicatorView;
        
    }else if (_indicatorViewStyle == FLProgressHUDIndicatorViewPan){
        
        FLProgressHUDPanIndicatorView *panIndicatorView = [[FLProgressHUDPanIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        if (_style == FLProgressHUDStyleDark) {
            
            panIndicatorView.progressColor = [UIColor whiteColor];
        }else{
            panIndicatorView.progressColor = [UIColor blackColor];
        
        }
        
        _indicatorView = panIndicatorView;
        
    }else if (_indicatorViewStyle == FLProgressHUDIndicatorViewRing){
        
        FLProgressHUDRingIndicatorView *ringIndicatorView = [[FLProgressHUDRingIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 37, 37)];
        
        if (_style == FLProgressHUDStyleDark) {
            
            ringIndicatorView.forwardRingColor = [UIColor whiteColor];
            ringIndicatorView.backgroungRingColor = [UIColor blackColor];
            
        }else{
            
            ringIndicatorView.forwardRingColor = [UIColor blackColor];
            ringIndicatorView.backgroungRingColor = [UIColor groupTableViewBackgroundColor];
            
        }
        
        _indicatorView = ringIndicatorView;
        
    }
}




-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (_indicatorViewStyle == FLProgressHUDIndicatorViewSystem) {
        
        
    }else if (_indicatorViewStyle == FLProgressHUDIndicatorViewPan){
        
        FLProgressHUDPanIndicatorView *panView = (FLProgressHUDPanIndicatorView *)_indicatorView;
        panView.progress = progress;
        
        
    }else if (_indicatorViewStyle == FLProgressHUDIndicatorViewRing){
        
        
        FLProgressHUDRingIndicatorView *ringView = (FLProgressHUDRingIndicatorView *)_indicatorView;
        ringView.progress = progress;
        
    }
}

@end
