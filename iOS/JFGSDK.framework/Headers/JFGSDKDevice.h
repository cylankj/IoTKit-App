//
//  JFGSDKDevice.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/28.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGTypeDefine.h"
/*!
 *  加菲狗设备属性
 *  这些属性一般情况不会发生改变
 */
@interface JFGSDKDevice : NSObject

/*!
 *  设备别名
 */
@property (nonatomic,copy) NSString *alias;
/*!
 *  设备系统类型
 */
@property (nonatomic,copy) NSString *pid;
/**
 *  设备序列号
 */
@property (nonatomic,copy) NSString *sn;
/**
 *  设备唯一标示
 */
@property (nonatomic,copy) NSString *uuid;
/**
 *  不为空标识设备是来自于分享
 */
@property (nonatomic,copy) NSString *shareAccount;


@end
