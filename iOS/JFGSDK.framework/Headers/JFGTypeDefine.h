//
//  JFGTypeDefine.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/25.
//  Copyright © 2016年 yangli. All rights reserved.
//

/*!
 *  错误码
 */
typedef NS_ENUM (NSUInteger, JFGErrorType){
    // EOK 成功
    JFGErrorTypeNone = 0,
    
    // P2P 错误
    JFGErrorTypeP2PDns,
    JFGErrorTypeP2PSocket,
    JFGErrorTypeP2PCallerRelay,
    JFGErrorTypeP2PCallerStun,
    JFGErrorTypeP2PCalleeStun = 5,
    JFGErrorTypeP2PCalleeWaitCallerCheckNetTimeOut,
    JFGErrorTypeP2PPeerTimeOut,
    JFGErrorTypeP2PUserCancel,
    JFGErrorTypeP2PConnectionCheck,
    JFGErrorTypeP2PChannel = 10,
    JFGErrorTypeP2PDisconetByUser,
    
    // 直播类
    // 对端不在线
    JFGErrorTypeVideoPeerNotExist = 100,
    // 对端断开
    JFGErrorTypeVideoPeerDisconnect,
    // 正在查看中
    JFGErrorTypeVideoPeerInConnect,
    // 本端未登陆
    JFGErrorTypeVideoPeerNotLogin,
    
    // 未知错误
    JFGErrorTypeUnknown = 120,
    // 数据库错误
    JFGErrorTypeDataBase,
    // 会话无效
    JFGErrorTypeInvalidSession,
    
    // 设备端鉴权。
    // 厂家CID达到配额。关联消息：注册。
    JFGErrorTypeCIDExceedQuota = 140,
    // SN签名验证失败。关联消息：登陆。
    JFGErrorTypeCIDSNVerifyFailed,
    
    // 客户端登陆类.
    // vid, bundleID, vkey校验失败。
    JFGErrorTypeLoginInvalidVKey = 160,
    
    // 帐号或密码错误。
    JFGErrorTypeLoginInvalidPass,
    
    // 客户端帐号类.
    // 短信验证码错误。
    JFGErrorTypeSMSCodeNotMatch = 180,
    // 短信验证码超时。
    JFGErrorTypeSMSCodeTimeout,
    // 帐号不存在。
    JFGErrorTypeAccountNotExist,
    // 帐号已存在。
    JFGErrorTypeAccountAlreadyExist,
    // 原始密码与新密码相同。关联消息：修改密码。
    JFGErrorTypeSamePass,
    // 原密码错误。关联消息：修改密码。
    JFGErrorTypeInvalidPass = 185,
    // 此手机号码已被绑定。关联消息：帐号、手机号、邮箱绑定。
    JFGErrorTypePhoneExist,
    // 此邮箱已被绑定。关联消息：帐号、手机号、邮箱绑定。
    JFGErrorTypeEmailExist,
    // 手机号码不合规
    JFGErrorTypeIsNotPhone,
    // 邮箱账号不合规
    JFGErrorTypeIsNotEmail,
    
    // 客户端绑定设备类.
    // CID不存在。关联消息：客户端绑定。
    JFGErrorTypeCIDNotExist = 200,
    // 绑定中，正在等待摄像头上传随机数与CID关联关系，随后推送绑定通知
    JFGErrorTypeCIDBinding,
    // 设备别名已存在。
    JFGErrorTypeCIDAliasExist,
    
    // 客户端分享设备类.
    // 此帐号还没有注册。
    JFGErrorTypeShareInvalidAccount = 220,
    // 此帐号已经分享。
    JFGErrorTypeShareAlready,
    // 您不能分享给自己。
    JFGErrorTypeShareToSelf,
    // 设备分享，被分享账号不能超过5个。
    JFGErrorTypeShareExceedsLimit,
    
    // 客户端亲友关系类.
    //添加好友失败 对方账户未注册
    JFGErrorTypeFriendInvalidAccount = 240,
    // 已经是好友关系
    JFGErrorTypeFriendAlready,
    // 不能添加自己为好友
    JFGErrorTypeFriendToSelf,
    // 好友请求消息过期
    JFGErrorTypeFriendInvalidRequest,
    
    // APP测错误号
    // 非法的调用，ex: 摄像头/APP 调用对方才有的功能
    JFGErrorTypeInvalidMethod = 1000,
    // 非法的调用参数，ex: 登陆不带用户名
    JFGErrorTypeInvalidParameter,
    // 非法的状态， ex: 和摄像头在连接状态再次调用连接
    JFGErrorTypeInvalidState,
    // 解析域名失败
    JFGErrorTypeResolve,
    // 连接服务器失败
    JFGErrorTypeConnect,
};

typedef NS_ENUM (NSUInteger,JFGFriendResultType){
    
    /// 添加好友请求的发送结果
    JFGFriendResultTypeAddFriend = 8,
    /// 删除好友请求的发送结果
    JFGFriendResultTypeDelFriend,
    /// 同意添加好友请求的发送结果
    JFGFriendResultTypeAgreeAddFriend,
    /// 设置好友备注名
    JFGFriendResultTypeSetRemarkName,
};

/*!
 *  网络类型定义
 */
typedef NS_ENUM(NSUInteger,JFGNetType) {
    /*!
     *  无网络,不在线
     */
    JFGNetTypeOffline = 0,
    
    /*!
     *  WIFI
     */
    JFGNetTypeWifi,
    
    /*!
     *  3G
     */
    JFGNetType3G,
    
    /*!
     *  绑定后的连接中
     */
    JFGNetTypeConnect,
    
    /*!
     *  4G
     */
    JFGNetType4G,
    
    /*!
     *  5G
     */
    JFGNetType5G,
    
    /*!
     *  2G
     */
    JFGNetType2G,
};


/*!
 *  语言
 */
typedef NS_ENUM(NSUInteger,JFGLanguageType) {
    /*!
     *  中文
     */
    JFGLanguageTypeChinese = 0,
    /*!
     *  英文
     */
    JFGLanguageTypeEnglish,
    /*!
     *  俄语
     */
    JFGLanguageTypeRussian,
    /*!
     *  葡萄牙
     */
    JFGLanguageTypePortuguese,
    /*!
     *  西班牙语
     */
    JFGLanguageTypeSpanish,
    /*!
     *  日语
     */
    JFGLanguageTypeJapanese,
    /*!
     *  法语
     */
    JFGLanguageTypeFrench,
    /*!
     *  德语
     */
    JFGLanguageTypeGerman,
};


/*!
 *  加菲狗设备类型
 */
typedef NS_ENUM(NSUInteger,JFGDeviceType) {
    /*!
     *  未知设备类型
     */
    JFGDeviceTypeUnknown,
    /*!
     *  加菲狗WIFI版摄像头
     */
    JFGDeviceTypeCameraWifi,
    /*!
     *  加菲狗摄像头3G版本
     */
    JFGDeviceTypeCamera3G,
    /*!
     *  加菲狗摄像头4G版本
     */
    JFGDeviceTypeCamera4G,
    /*!
     *  加菲狗门铃
     */
    JFGDeviceTypeDoorBell,
    /*!
     *  加菲狗E家人
     */
    JFGDeviceTypeEfamily,
    /*!
     *  加菲狗门窗磁感应器
     */
    JFGDeviceTypeDoorSensor,
};


/*!
 *  推送消息类别
 */
typedef NS_ENUM(NSUInteger,JFGPushNotificationType) {
    /*!
     *  未知
     */
    JFGPushNotificationTypeUnknow = 0,
    /*!
     *  版本升级
     */
    JFGPushNotificationTypeNewVersion,
    /*!
     *  开启警报
     */
    JFGPushNotificationTypeWarnOn,
    /*!
     *  触发报警
     */
    JFGPushNotificationTypeWarn,
    /*!
     *  关闭警报
     */
    JFGPushNotificationTypeWarnOff,
    /*!
     *  低电量
     */
    JFGPushNotificationTypeLowBattery,
    /*!
     *  sd卡弹出，卸载
     */
    JFGPushNotificationTypeSDCardEject,
    /*!
     *  SD卡接入
     */
    JFGPushNotificationTypeSDCardMount,
    /*!
     *  解除绑定
     */
    JFGPushNotificationTypeUnBind,
    /*!
     *   绑定
     */
    JFGPushNotificationTypeBind,
    /*!
     *  重复绑定
     */
    JFGPushNotificationTypeRebind,
    /*!
     *  分享
     */
    JFGPushNotificationTypeShare,
    /*!
     *  取消分享
     */
    JFGPushNotificationTypeCancelShare,
    /*!
     *  门磁打开
     */
    JFGPushNotificationTypeMagnetOn,
    /*!
     *  门磁关闭
     */
    JFGPushNotificationTypeMagnetOff,
};


/*!
 *  绑定设备错误类型
 */
typedef NS_ENUM(NSUInteger,JFGBindDeviceErrorType)
{
    /*!
     *  未知错误
     */
    JFGBindDeviceErrorTypeUnknow = 0,
    /*!
     *  操作超时
     */
    JFGBindDeviceErrorTypeTimeOut,
    /*!
     *  设置设备wifi失败
     */
    JFGBindDeviceErrorTypeSetWifi,
    /*!
     *  重新连接服务器失败
     */
    JFGBindDeviceErrorTypeReConnectServerFail,
    /*!
     *  重新用户登录失败
     */
    JFGBindDeviceErrorTypeReLoginFail,
    /*!
     *  未连接设备wifi
     */
    JFGBindDeviceErrorTypeNotConnectDeviceWifi,
};


typedef NS_ENUM(NSUInteger,JFGSDKServerType)
{
    /*!
     *  测试平台
     */
    JFGSDKServerTypeTestAddr,
    
    /*!
     *  云平台
     */
    JFGSDKServerTypeYunAddr,
    
    /*!
     *  研发平台
     */
    JFGSDKServerTypeYanfaAddr,
};




