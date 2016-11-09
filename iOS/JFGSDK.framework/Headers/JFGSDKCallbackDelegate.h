//
//  JFGSDKCallbackDelegate.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/26.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGSDKAcount.h"
#import "JFGSDKMessage.h"
#import "JFGSDKDevice.h"
#import "JFGSDKUDPRespose.h"
#import "JFGSDKHistoryVideoTimeInfo.h"
#import "JFGSDKDataPointModel.h"

@protocol JFGSDKCallbackDelegate <NSObject>

@optional

#pragma mark - Account And connect
/*!
 *  登录结果
 *
 *  @param ssession  用户登录session,只在登录成功时有效
 *  @param errorType  可能的值为 JFGErrorTypeNone(登录成功), JFGErrorTypeLoginInvalidPass, JFGErrorTypeLoginInvalidSession
 */
-(void)jfgLoginResult:(JFGErrorType)errorType;


/**
 *  注册结果
 *
 *  @param errorType 注册错误类型
 */
-(void)jfgRegisterResult:(JFGErrorType)errorType;


/**
 *  发送验证码结果
 *
 *  @param errorType 错误码
 */
-(void)jfgSendSMSResult:(JFGErrorType)errorType token:(NSString *)token;

/**
 *  校验验证码结果
 *
 *  @param errorType 错误码
 */
-(void)jfgVerifySMSResult:(JFGErrorType)errorType;

/**
 *  忘记密码结果
 *
 *  @param errorType 错误码
 */
-(void)jfgForgetPasswordResult:(JFGErrorType)errorType;

/**
 *  重置密码
 *
 *  @param errorType 错误码
 */
-(void)jfgChangerPasswordResult:(JFGErrorType)errorType;


/**
 *  修改邮箱密码
 *
 *  @param email     被修改邮箱
 *  @param errorType 错误码
 */
-(void)jfgForgetPassByEmail:(NSString *)email errorType:(JFGErrorType)errorType;


/**
 *  账号在线状态
 *
 *  @param online 在线状态
 */
-(void)jfgAccountOnline:(BOOL)online;


/**
 *  账号被服务器强制退出
 *
 *  @param errorType 退出原因
 */
-(void)jfgLoginOutByServerWithCause:(JFGErrorType)errorType;

/*!
 *  用户账号属性更新
 *
 *  @param account 账户信息
 */
-(void)jfgUpdateAccount:(JFGSDKAcount *)account;

/**
 *  设置账号信息
 *
 *  @param errorType 错误码
 */
-(void)jfgResetAccountResult:(JFGErrorType)errorType;

#pragma mark - Device Message
/*!
 *  设备列表
 *
 *  @param deviceList 设备列表
 */
-(void)jfgDeviceList:(NSArray <JFGSDKDevice *> *)deviceList;

/**
 *  解除绑定结果
 *
 *  @param errorType 错误码
 */
-(void)jfgDeviceUnBind:(JFGErrorType)errorType;

/**
 *  设备版本信息
 *
 *  @param info 版本信息
 */
-(void)jfgDevVersionUpgradInfo:(JFGSDKDeviceVersionInfo *)info;


/*!
 *  其他客户端已接听门铃的呼叫
 */
-(void)jfgOtherClientAnswerDoorbellCall;


/*!
 *  来自门铃的呼叫
 *
 *  @param call 呼叫门铃信息
 */
-(void)jfgDoorbellCall:(JFGSDKDoorBellCall *)call;


/**
 *  设备别名
 *
 *  @param alias     别名
 *  @param errorType 错误码
 */
-(void)jfgDeviceAlias:(NSString *)alias errorType:(JFGErrorType)errorType;


/**
 *  设置设备别名
 *
 *  @param errorType 错误码
 */
-(void)jfgSetDeviceAliasResult:(JFGErrorType)errorType;

#pragma mark - Server Message
/*!
 *  Http请求回调
 *
 *  @param ret       HTTP状态码, 200为成功,其余为失败
 *  @param requestID 请求标示,和 #HttpGet 或 #HttpPostFile 返回值对应
 *  @param result    服务器返回消息, 仅在 JFGMsgHttpResult::ret 为200时有效
 */
-(void)jfgHttpResposeRet:(int)ret requestID:(int)requestID result:(NSString *)result;


#pragma mark- UDP通信
/*!
 *  fping 回调
 */
-(void)jfgFpingRespose:(JFGSDKUDPResposeFping *)ask;

/**
 *  ping respose
 *
 *  @param ask ping msg
 */
-(void)jfgPingRespose:(JFGSDKUDPResposePing *)ask;

/**
 *  set wifi
 *
 *  @param ask setwifi msg
 */
-(void)jfgSetWifiRespose:(JFGSDKUDPResposeSetWifi *)ask;


#pragma mark- robot
/*!
 *  收到萝卜头透传的消息
 */
-(void)jfgOnRobotTransmitMsg:(JFGSDKRobotMessage *)message;

/*!
 *  萝卜头消息应答
 *
 *  @param sn 消息序列号
 */
-(void)jfgOnRobotMsgAck:(int)sn;


/**
 *  萝卜头DataPoint推送消息
 *
 *  @param peer    对端设备标示
 *  @param msgList 消息列表（最终数据类型DataPointSeg）
 */
-(void)jfgRobotPushMsgForPeer:(NSString *)peer msgList:(NSArray <NSArray <DataPointSeg *>*>*)msgList;


/**
 *  来自其他APP/设备 触发的DP同步消息
 *
 *  @param peer    数据所属对象
 *  @param isDev   YES:同步来自设备，NO:来自APP操作触发
 *  @param msgList DP数据列表
 */
-(void)jfgRobotSyncDataForPeer:(NSString *)peer fromDev:(BOOL)isDev msgList:(NSArray <DataPointSeg *> *)msgList;


/**
 *  网络变化
 *
 *  @param netType 网络类型（WWAN网络,返回3G）
 */
-(void)jfgNetworkChanged:(JFGNetType)netType;

/**
 *  加好友请求列表
 *
 *  @param list      列表数据
 *  @param errorType 错误码
 */
-(void)jfgFriendRequestList:(NSArray <JFGSDKFriendRequestInfo *>*)list error:(JFGErrorType)errorType;

/**
 *  好友列表
 *
 *  @param list      列表数据
 *  @param errorType 错误码
 */
-(void)jfgFriendList:(NSArray *)list error:(JFGErrorType)errorType;

/**
 *  获取好友备注
 *
 *  @param remark  备注名
 *  @param account 好友账号
 */
-(void)jfgGetFriendInfo:(JFGSDKFriendInfo *)info error:(JFGErrorType)errorType;

/**
 *  好友请求相关回调
 *
 *  @param type      返回类型
 *  @param errorType 结果
 */
-(void)jfgResultIsRelatedToFriendWithType:(JFGFriendResultType)type error:(JFGErrorType)errorType;

/**
 *  检测账号是否存在
 *
 *  @param account 被检查的账号
 *  @param isExist 是否存在
 */
-(void)jfgCheckAccount:(NSString *)account alias:(NSString *)alias isExist:(BOOL)isExist;

/**
 *  分享设备结果
 *
 *  @param ret     结果
 *  @param cid     分享的设备标示
 *  @param account 分享给的账号
 */
-(void)jfgShareResult:(JFGErrorType)ret device:(NSString *)cid forAccount:(NSString *)account;

/**
 *  取消分享
 *
 *  @param ret     结果
 *  @param cid     同上
 *  @param account 同上
 */
-(void)jfgUnshareResult:(JFGErrorType)ret device:(NSString *)cid forAccount:(NSString *)account;


/**
 *  设备分享列表
 *
 *  @param friendList 分享列表
 */
-(void)jfgDeviceShareList:(NSDictionary <NSString *,NSArray <JFGSDKFriendInfo *>*> *)friendList;

/**
 *  某设备未分享好友列表
 *
 *  @param errorType 结果
 *  @param list      好友列表
 */
-(void)jfgUnshareFriendListByCidResult:(JFGErrorType)errorType list:(NSArray <JFGSDKFriendInfo *>*)list;

/**
 *  NTP时间更新
 *
 *  @param unixTimestamp unix时间戳
 */
-(void)jfgOnUpdateNTP:(uint32_t)unixTimestamp;


/**
 *  中控消息回调
 *
 *  @param msg msgpack解析后消息
 */
-(void)jfgEfamilyMsg:(id)msg;


/**
 *  获取反馈消息回调
 *
 *  @param infoList  消息列表
 *  @param errorType 错误码
 */
-(void)jfgFeedBackWithInfoList:(NSArray <JFGSDKFeedBackInfo *> *)infoList errorType:(JFGErrorType)errorType;


/**
 *  发送反馈意见结果
 *
 *  @param errorType 错误码
 */
-(void)jfgSendFeedBackResult:(JFGErrorType)errorType;


/**
 *  upload device token result
 *
 *  @param errorType  error type
 */
-(void)jfgUploadDeviceTokenResult:(JFGErrorType)errorType;

@end
