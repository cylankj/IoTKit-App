//
//  FLProgressHUDIndicatorView.h
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLProgressHUDStyleEnum.h"
#import "FLProgressHUDRingIndicatorView.h"
#import "FLProgressHUDPanIndicatorView.h"

@interface FLProgressHUDIndicatorView : NSObject

@property (nonatomic,strong)UIView *indicatorView;
@property (nonatomic,assign)CGFloat progress;
@property (nonatomic,assign,readonly)FLProgressHUDIndicatorViewStyle indicatorViewStyle;

-(instancetype)initWithStyle:(FLProgressHUDStyle)style IndicatorViewStyle:(FLProgressHUDIndicatorViewStyle)indicatorViewStyle;

@end
