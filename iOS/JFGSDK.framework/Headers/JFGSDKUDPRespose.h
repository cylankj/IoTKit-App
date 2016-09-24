//
//  JFGSDKUDPRespose.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/31.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGTypeDefine.h"
/*!
 *  udp通信回应
 */

@interface JFGSDKUDPResposeHead : NSObject

/*!
 *  设备标示
 */
@property(nonatomic,copy)NSString *cid;
/*!
 *  IP地址
 */
@property(nonatomic,copy)NSString *address;
/*!
 *  端口
 */
@property(nonatomic,assign)unsigned short port;


-(instancetype)initWithCid:(NSString *)cid post:(int)post addr:(NSString *)addr;

@end


@interface JFGSDKUDPResposePing : JFGSDKUDPResposeHead

/*!
 *  设备网络类型
 */
@property(nonatomic,assign)JFGNetType net;


@end


@interface JFGSDKUDPResposeFping : JFGSDKUDPResposeHead

/*!
 *  mac地址
 */
@property (nonatomic,copy)NSString *mac;
/*!
 *  版本号
 */
@property (nonatomic,copy)NSString *ver;


@end


@interface JFGSDKUDPResposeSetWifi : JFGSDKUDPResposeHead
/*!
 *  设置是否成功
 */
@property (nonatomic,assign)BOOL success;

@end


@interface JFGSDKUDPResposeScanWifi : JFGSDKUDPResposeHead
/*!
 *  wifi列表序号
 */
@property (nonatomic,assign)int index;
/*!
 *  wifi列表总数
 */
@property (nonatomic,assign)int total;
/*!
 *  wifi信号强度
 */
@property (nonatomic,assign)int rssi;
/*!
 *  安全级别
 */
@property (nonatomic,assign)int security;
/*!
 *  ssid
 */
@property (nonatomic,copy)NSString *ssid;

@end


@interface JFGSDKUDPResposeSetWifiSwitch : JFGSDKUDPResposeHead

/*!
 *  0标示成功 ，其他失败
 */
@property (nonatomic,assign)int ret;


@end


@interface JFGSDKUDPResposeWifiStatus : JFGSDKUDPResposeHead
/*!
 *  0标示成功 ，其他失败
 */
@property (nonatomic,assign)int ret;



@end