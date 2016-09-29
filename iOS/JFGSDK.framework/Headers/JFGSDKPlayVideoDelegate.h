//
//  JFGSDKPlayVideoDelegate.h
//  JFGSDK
//
//  Created by 杨利 on 16/7/13.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFGSDKHistoryVideoTimeInfo.h"
#import "JFGTypeDefine.h"


@protocol JFGSDKPlayVideoDelegate <NSObject>

@optional
/*!
 *  视频RTCP通知(每秒一次回调)
 *
 *  @param bitRate      码率,单位为 KB/s
 *  @param videoRecved  本次连接以来总共收到多少数据,单位为KB
 *  @param frameRate    帧率
 *  @param timesTamp    设备发送的时间戳,用于在查看历史录像时同步本地进度,看实时画面时此参数为0
 */
-(void)jfgRTCPNotifyBitRate:(int)bitRate
                videoRecved:(int)videoRecved
                  frameRate:(int)frameRate
                  timesTamp:(int)timesTamp;


/*!
 *  渲染视图尺寸(这时候已经开始渲染画面)
 *  注意：一次连接只会回调一次
 *  @param width  宽度
 *  @param height 高度
 */
-(void)jfgResolutionNotifyWidth:(int)width
                         height:(int)height
                           peer:(NSString *)peer;



/*!
 *  音视频连接断开
 *
 *  @param remoteID  对端标示
 *  @param errorCode 错误码
 */
-(void)jfgTransportFail:(NSString *)remoteID
                  error:(JFGErrorType)errorType;


/*!
 *  历史录像信息
 *
 *  @param list 录像信息集合
 */
-(void)jfgHistoryVideoList:(NSArray <JFGSDKHistoryVideoInfo *>*)list;


/*!
 *  历史录像文件错误信息
 *
 *  @param errorInfo 错误信息详情
 */
-(void)jfgHistoryVideoErrorInfo:(JFGSDKHistoryVideoErrorInfo *)errorInfo;



@end
