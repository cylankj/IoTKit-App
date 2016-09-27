//
//  JFGSDKBindingDevice.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/7.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGSDKBindDeviceDelegate.h"

@interface JFGSDKBindingDevice : NSObject

/**
 *  绑定代理
 */
@property (nonatomic,assign)id <JFGSDKBindDeviceDelegate> delegate;


/**
 *  借助设备扫描周边wifi
 *  需在连接设备wifi后执行此操作
 */
-(void)scanWifi;


/*!
 *  绑定设备（绑定成功后会触发JFGSDKCallbackDelegate #jfgDeviceList:回调）
 *  需在连接设备wifi后执行此操作
 *  @param sn  新设备填写设备sn，旧设备无需填写（cid）
 *  @param ssid  wifi ssid
 *  @param key   wifi 密码
 *  注：暂不支持绑定有sn设备
 */
-(void)bindDevWithSn:(NSString *)sn ssid:(NSString *)ssid key:(NSString *)key;

@end
