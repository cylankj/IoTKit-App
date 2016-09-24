//
//  JFGSDKVideo.h
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/28.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 *  历史录像信息
 */
@interface JFGSDKHistoryVideoInfo : NSObject

/*!
 *  开始时间
 */
@property (nonatomic,assign)int64_t beginTime;

/*!
 *  持续时长
 */
@property (nonatomic,assign)int duration;

@end


/*!
 *  历史录像错误信息
 */
@interface JFGSDKHistoryVideoErrorInfo : NSObject

/*!
 *  开始时间
 */
@property (nonatomic,assign)int64_t beginTime;


/*!
 *  错位码
 */
@property (nonatomic,assign)int code;

@end
