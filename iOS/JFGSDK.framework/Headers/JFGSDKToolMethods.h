//
//  JFGSDKToolMethods.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/30.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFGSDKToolMethods : NSObject
/*!
 *  当前系统语言
 *
 *  @return 语言
 */
+(NSInteger)languageType;


//获取当前wifi名称
+(NSString *)currentWifiName;

@end
