//
//  JFGSDKVideoView.h
//  JFGSDK
//
//  Created by 杨利 on 16/8/29.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFGSDKPlayVideoDelegate.h"


//视频渲染视图
@interface VideoRenderIosView : UIView

@end

@interface PanoramicIosView : VideoRenderIosView

// 初始化全景view
- (id)initPanoramicViewWithFrame:(CGRect)frame;

@end

//全景摄像头悬挂模式
typedef NS_ENUM(NSInteger,PanoramaCameraMode){
    PanoramaLiveModeTop,
    PanoramaLiveModeWall,
};

//全景摄像头参数设置
typedef NS_ENUM(NSInteger,PanoramaCameraParam){
    PanoramaCameraParamTopPreset,
    PanoramaCameraParamWallPreset,
};


@interface JFGSDKVideoView : UIView
#pragma mark- 代理
/**
 *  视频回调代理
 */
@property (nonatomic,assign)id <JFGSDKPlayVideoDelegate> delegate;


#pragma mark- 视频播放相关
/**
 *  播放直播（普通摄像头）
 *
 *  @param cid            设备标示
 */
-(void)startLiveRemoteVideo:(NSString *)cid;


/**
 *  开始播放历史视频
 *
 *  @param cid  设备标示
 *  @param time 历史视频开始时间戳
 *  @param panoramic 是否是加载全景视图
 */
-(void)startHistoryVideo:(NSString *)cid beginTime:(int64_t)time;


/**
 *  停止播放视频
 */
-(void)stopVideo;

#pragma mark- 本地摄像头图像
/**
 *  开始渲染本地摄像头画面
 *
 *  @param superView 本地图像渲染承载视图
 *  @param tag       本地渲染视图tag
 *  @param front     是否使用前置摄像头 YES：前置  NO：后置
 */
-(void)startRenderLocalView:(UIView *)superView localViewTag:(NSInteger)tag forFrontCamera:(BOOL)front;


/**
 *  停止渲染本地视图
 */
-(void)stopRenderLocalView;

#pragma mark- 功能性API
/**
 *  获取历史视频列表
 *
 *  @param cid 设备标示
 */
-(void)getHistoryVideoList:(NSString *)cid;


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


#pragma mark- 全景摄像头相关（持续完善中）
/**
 *  播放直播（全景摄像头,此功能暂时不完善）
 *
 *  @param cid 设备标示
 */
- (void)startPanoramaLiveRemoteVideoForCid:(NSString *)cid;
// 设置悬挂模式
- (void)setMountMode:(PanoramaCameraMode)mode;
//cx:圆心X  cy:圆心Y  r:圆半径  w:图片width  h:图片height  fov:field of view
-(void)configV360WithCx:(int)cx cy:(int)cy r:(int)r w:(int)w h:(int)h fov:(int)fov;
// 开启陀螺仪
- (void)enableGyro:(BOOL)enable;
// 开启VR分屏
- (void)enableVRMode:(BOOL)enable;
// 载入图片
- (BOOL)loadImage:(NSString*)imgPath;
// 获取双击的手势对象
- (UITapGestureRecognizer*)getDoubleTapRecognizer;
// 通知view方向变化
- (void)detectOrientationChange;

@end
