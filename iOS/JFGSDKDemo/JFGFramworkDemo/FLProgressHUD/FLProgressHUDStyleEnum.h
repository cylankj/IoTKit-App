//
//  FLProgressHUDStyleEnum.h
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

/**
 指示器样式
 */
typedef NS_ENUM(NSInteger, FLProgressHUDIndicatorViewStyle){
    FLProgressHUDIndicatorViewSystem = 0,//系统自带的指示器视图
    FLProgressHUDIndicatorViewPan,//圆饼形状的进度加载
    FLProgressHUDIndicatorViewRing//环形进度加载
};

/**
 HUD显示位置
 */
typedef NS_ENUM(NSInteger, FLProgressHUDPosition){
    FLProgressHUDPositionCenter = 0,
    FLProgressHUDPositionTop,
    FLProgressHUDPositionBottom
};

/**
 HUD显示样式.
 */
typedef NS_ENUM(NSUInteger, FLProgressHUDStyle) {
    FLProgressHUDStyleLight = 0,//白底
    FLProgressHUDStyleDark //黑底
};
