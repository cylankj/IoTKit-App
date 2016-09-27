//
//  FLProgressHUDPanIndicatorView.h
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLProgressHUDPanIndicatorView : UIView
//进度块的颜色
@property (nonatomic,strong)UIColor *progressColor;
//进度
@property (nonatomic,assign)CGFloat progress;
@end
