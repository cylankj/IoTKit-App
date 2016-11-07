//
//  JFGSDKBindDeviceDelegate.h
//  JFGSDK
//
//  Created by 杨利 on 16/7/27.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGSDKUDPRespose.h"

typedef NS_ENUM (NSInteger,JFGSDKBindindProgressStatus){
    
    JFGSDKBindindProgressStatusPing,//ping操作
    
    JFGSDKBindindProgressStatusConfigureStart,//开始配置摄像头参数
    JFGSDKBindindProgressStatusConfigureSuccess,//配置摄像头参数成功
    JFGSDKBindindProgressStatusStartBinding,//开始绑定
    
    JFGSDKBindindProgressStatusSuccess,//绑定成功
    
    JFGSDKBindindProgressStatusSetWifiFailed,//设置摄像头wifi失败
    JFGSDKBindindProgressStatusBindTimeout,//绑定超时
    
    JFGSDKBindindProgressStatusCIDNotExist = 200,//CID不存在。关联消息：客户端绑定
    JFGSDKBindindProgressStatusCIDBinding,// 绑定中，正在等待摄像头上传随机数与CID关联关系，随后推送绑定通知
    
};


@protocol JFGSDKBindDeviceDelegate <NSObject>

@optional

/*!
 *  扫描WiFi回调，可能会回调很多次
 */
-(void)jfgScanWifiRespose:(JFGSDKUDPResposeScanWifi *)ask;


/**
 *  绑定过程，结果回调
 *
 *  @param status 绑定状态
 */
-(void)jfgBindDeviceProgressStatus:(JFGSDKBindindProgressStatus)status;

/**
 *  绑定失败
 *
 *  @param errorCode 错误码
 */
-(void)jfgBindDeviceFailed:(JFGSDKBindindProgressStatus)errorType;

/**
 *  绑定成功
 *
 *  @param peer 设备标示
 */
-(void)fjgBindDeviceSuccessForPeer:(NSString *)peer;


@end
