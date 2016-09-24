//
//  FLProressHUD.h
//  FLProgressHUD
//
//  Created by 紫贝壳 on 15/8/20.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FLProgressHUDStyleEnum.h"

@interface FLProressHUD : UIView

typedef void(^FLProressHUDDidAppear)(FLProressHUD *hud);
typedef void(^FLProressHUDDisappear)(FLProressHUD *hud);

/**
 HUD已经呈现到界面的Block回调
 */
@property (nonatomic,copy)FLProressHUDDidAppear flProressHUDDidAppear;

/**
 HUD消失后的Block回调
 */
@property (nonatomic,copy)FLProressHUDDisappear flProressHUDDisappear;

/**
 HUD实际显示的背景块
 */
@property (nonatomic,strong,readonly)UIView *HUDView;

/**
 用于在HUD上显示文字的文本标签
 */
@property (nonatomic,strong,readonly)UILabel *textLabel;

/**
 加载指示器
 */
@property (nonatomic,strong)UIView *progressIndicatorView;

/**
 进度
 */
@property (nonatomic,assign)CGFloat progress;

/**
 进度指示器样式，默认是系统样式
 */
@property (nonatomic,assign)FLProgressHUDIndicatorViewStyle indicatorViewStyle;

/**
 HUD的显示样式
 */
@property (nonatomic,assign,readonly)FLProgressHUDStyle style;

/**
 HUD显示位置
 */
@property (nonatomic,assign)FLProgressHUDPosition position;

/**
 是否显示加载指示器,默认是YES
 */
@property (nonatomic,assign)BOOL showProgressIndicatorView;


/**
 显示内容的(textLable,ProgressIndicatorView)位置偏移量，默认是(20,20,20,20)
 */
@property (nonatomic,assign)UIEdgeInsets contentInsets;

/**
 HUDView相对于显示位置的偏移量,默认是(20,20,20,20)
 */
@property (nonatomic,assign)UIEdgeInsets marginInsets;

/**
 正在执行的事务标签
 */
@property (nonatomic,copy)NSString *taskTag;




#pragma mark 初始化方法
/**
 初始化
 @param style HUD背景样式
 */
-(instancetype)initWithStyle:(FLProgressHUDStyle)style;

/**
 创建一个显示进度加载器的HUD
 @param indicatorViewStyle 加载指示器类型
 @param style HUD类型
 @param position 显示位置
 @param superView 父类视图
 */
+(FLProressHUD *)showIndicatorViewFLProgressHUDWithIndicatorViewStyle:(FLProgressHUDIndicatorViewStyle)indicatorViewStyle hudStyle:(FLProgressHUDStyle)style position:(FLProgressHUDPosition)position text:(NSString *)text superView:(UIView *)superView;

/**
 创建一个只显示文字的HUD
 @param indicatorViewStyle 加载指示器类型
 @param style HUD类型
 @param position 显示位置
 @param superView 父类视图
 */
+(FLProressHUD *)showTextFLProgressHUDWithStyle:(FLProgressHUDStyle)style position:(FLProgressHUDPosition)position text:(NSString *)text superView:(UIView *)superView;


#pragma mark 显示，隐藏
/**
 添加显示到指定界面
 @param supView 父类视图
 @param animated 是否支持动画效果
 */
-(void)showInView:(UIView *)supView animated:(BOOL)animated;

/**
 从视图上移除HUD
 */
-(void)hide:(BOOL)animation delay:(NSTimeInterval)timeInterval;



#pragma mark helper 以下类方法不提供获取FLProressHUD实例
/**
 创建一个只显示文本,Light类型的HUD
 @param position HUD显示位置
 */
+(void)showTextFLHUDForStyleLightWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position;

/**
 创建一个只显示文本,Dark类型的HUD
 @param position HUD显示位置
 */
+(void)showTextFLHUDForStyleDarkWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position;

/**
 创建一个显示系统加载器,Light类型的HUD
 @param position HUD显示位置
 */
+(void)showIndicatorViewFLHUDForStyleLightWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position;

/**
 创建一个显示系统加载器,Dark类型的HUD
 @param position HUD显示位置
 */
+(void)showIndicatorViewFLHUDForStyleDarkWithView:(UIView *)superView text:(NSString *)text position:(FLProgressHUDPosition)position;

/**
 移除指定view上的所有HUD视图
 @param timeInterval 延迟几秒执行
 */
+(void)hideAllHUDForView:(UIView *)superView animation:(BOOL)animation delay:(NSTimeInterval)timeInterval;

@end
