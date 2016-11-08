//
//  JFGSDKMessage.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/28.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGTypeDefine.h"

/*!
 *  JFG设备消息
 */
@interface JFGSDKMessageDevice : NSObject

/*!
 根据type不同，有不同的消息类型
 */
@property (nonatomic,assign)JFGPushNotificationType type;

/*!
 *  此消息的发生时间
 */
@property (nonatomic,assign)int64_t time;

/*!
 *  消息所属设备
 */
@property (nonatomic,copy)NSString *cid;

/*!
 *  该消息是否为服务器消息
 */
@property (nonatomic,assign)BOOL fromServer;

/*!
 *  设备（消息)类型
 */
@property (nonatomic,assign)JFGDeviceType os;

/*!
 *  未读消息
 */
@property (nonatomic,assign)int unReadCount;

/*!
 *  公共的保留字段，可以用做其他赋值
 */
@property (nonatomic,copy)NSString *msg;

@end






/*!
 *  门铃呼叫消息
 */
@interface JFGSDKDoorBellCall : NSObject

/*!
 *  来自此cid的呼叫
 */
@property (nonatomic,copy)NSString *cid;
/*!
 *  呼叫时间
 */
@property (nonatomic,assign)int time;
/*!
 *  门铃截图地址
 */
@property (nonatomic,copy)NSString *url;
/*!
 *  是否已经接听
 */
@property (nonatomic,assign)BOOL isAnswer;

@end

@interface JFGSDKRobotMessage : NSObject

/*!
 *  需要将消息发送的目标
 */
@property (strong,nonatomic) NSArray <NSString *> * targets;

/*!
 *  是否需要回应
 */
@property (nonatomic,assign) BOOL isAck;

/*!
 *  此消息的序列号
 */
@property (nonatomic,assign) int sn;


/*!
 *  消息内容，最大长度为64k
 */
@property (nonatomic,strong) NSData *msg;


/**
 *  消息发送者
 */
@property (nonatomic,copy) NSString *caller;

@end



@interface JFGSDKFeedBackInfo : NSObject

/**
 *  消息内容
 */
@property (nonatomic,copy)NSString *msg;

/**
 *  消息时间
 */
@property (nonatomic,assign)int64_t timestamp;

@end