//
//  JFGSDKVideoView.h
//  JFGSDK
//
//  Created by 杨利 on 16/8/29.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFGSDKPlayVideo.h"
#import "JFGSDKPlayVideoDelegate.h"

@interface JFGSDKVideoView : UIView
#pragma mark- 代理
/**
 *  视频回调代理
 */
@property (nonatomic,assign)id <JFGSDKPlayVideoDelegate> delegate;


#pragma mark- 视频播放相关
/**
 *  播放直播
 *
 *  @param cid            设备标示
 *  @param localSuperView 本地视图父类视图（nil则不绘制本地视图）
 */
-(void)startLiveVideo:(NSString *)cid loadLocalVideo:(UIView *)localSuperView;


/**
 *  开始播放历史视频
 *
 *  @param cid  设备标示
 *  @param time 历史视频开始时间戳
 */
-(void)startHistoryVideo:(NSString *)cid beginTime:(int64_t)time;


/**
 *  停止播放视频
 */
-(void)stopVideo;


#pragma mark- 功能性API
/**
 *  获取历史视频列表
 *
 *  @param cid 设备标示
 */
-(void)getHistoryVideoList:(NSString *)cid;


/**
 *  切换本地(前/后置)摄像头
 *
 *  @param front YES：前置摄像头  NO：后置摄像头
 */
-(void)switchLocalCameraIsUserFront:(BOOL)front;


/**
 *  截图
 *
 *  @param local 本地，远程
 *
 *  @return 截图
 */
-(UIImage *)videoScreenshotForLocal:(BOOL)local;


/**
 *  设置本地及对端 麦克风,喇叭的状态
 *  设置本地及对端 麦克风,喇叭的状态
 *  @param local true:设置本地 false:设置对端
 *  @param mike true:打开麦克风 false:关闭麦克风
 *  @param speaker true:打开喇叭 false:关闭喇叭
 *  @param return
 *  @note 音视频操作要确保在音视频建立连接后进行
 */
-(void)setAudioForLocal:(BOOL)local
                openMic:(BOOL)openMic
            openSpeaker:(BOOL)openSpeaker;




@end
