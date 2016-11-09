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

//VERSION_UPGRADE
/**
 *  bool          hasNewpkg;
 /// null if hasNewpkg is false, else this is a http url which we can directly download a upgrade file.
 std::string   url;
 /// new version of this upgrade
 std::string   version;
 /// show upgradeTips to user interface
 std::string   upgradeTips;
 /// file md5 checksum
 std::string   md5;
 */

@interface JFGSDKDeviceVersionInfo : NSObject

@property (nonatomic,assign)BOOL hasNewPkg;

/**
 *  null if hasNewpkg is false, else this is a http url which we can directly download a upgrade file.
 */
@property (nonatomic,copy)NSString *url;

/**
 *  new version of this upgrade
 */
@property (nonatomic,copy)NSString *version;

/**
 *  show upgradeTips to user interface
 */
@property (nonatomic,copy)NSString *upgradeTips;

/**
 *  file md5 checksum
 */
@property (nonatomic,copy)NSString *md5;

@end
