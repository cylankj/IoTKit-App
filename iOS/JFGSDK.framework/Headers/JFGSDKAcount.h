//
//  JFGAcount.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/25.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  加菲狗账号信息
 */
@interface JFGSDKAcount : NSObject

/*!
 *  账号
 */
@property (nonatomic,copy) NSString *account;
/*!
 *  别名
 */
@property (nonatomic,copy) NSString *alias;
/*!
 *  邮箱
 */
@property (nonatomic,copy) NSString *email;
/*!
 *  手机
 */
@property (nonatomic,copy) NSString *phone;

/*!
 *  是否接受消息通知
 */
@property (nonatomic,assign) BOOL pushEnable;
/*!
 *  是否开启震动
 */
@property (nonatomic,assign) BOOL isVibrate;
/*!
 *  是否开启声音
 */
@property (nonatomic,assign) BOOL isOpneSound;

/**
 *  头像url
 */
@property (nonatomic,copy) NSString *headUrl;

@property (nonatomic,assign)int photoVersion;

@end


/**
 *  好友属性信息
 */
@interface JFGSDKFriendInfo : NSObject

@property (nonatomic,copy)NSString *account;
@property (nonatomic,copy)NSString *remarkName;//备注名
@property (nonatomic,copy)NSString *alias;//昵称

@end


/**
 *  请求加好友消息
 */
@interface JFGSDKFriendRequestInfo : NSObject

@property (nonatomic,copy)NSString *account;
@property (nonatomic,copy)NSString *alias;
@property (nonatomic,copy)NSString *additionMsg;
@property (nonatomic,assign)int64_t requestTime;

@end
