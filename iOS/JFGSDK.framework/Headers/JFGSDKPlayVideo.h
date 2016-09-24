//
//  JFGSDKPlayVideo.h
//  JFGSDK
//
//  Created by 杨利 on 16/7/11.
//  Copyright © 2016年 yangli. All rights reserved.
//  视频播放相关

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import "JFGSDKPlayVideoDelegate.h"

enum MountMode {
    MOUNT_TOP,
    MOUNT_WALL,
};

class CameraParam {
public:
    static CameraParam getTopPreset();
    static CameraParam getWallPreset();
    
    CameraParam(int t_cx, int t_cy, int t_r, int t_w, int t_h, int t_fov);
    CameraParam();
    
    int cx;  // 圆心X
    int cy;  // 圆心Y
    int r;   // 圆半径
    
    int w;   // 图片width
    int h;   // 图片height
    int fov; // field of view
};

//视频渲染视图
@interface VideoRenderIosView : UIView

//以下为全景摄像头函数
- (id)initPanoramicViewWithFrame:(CGRect)frame;
- (bool)isPanorama;
- (void)setMountMode:(MountMode)mode;
- (void)configV360:(CameraParam)p;
- (void)enableGyro:(bool)enable;
- (void)enableVRMode:(bool)enable;
- (void)notifyViewSizeChanged;
- (BOOL)loadImage:(NSString*)imgPath;

@end


@interface JFGSDKPlayVideo : NSObject
/**
 *  远程视频画面视图(只有当视频渲染成功后才有效,停止播放后会自动从superView移除)
 *  回调分辨率时(#jfgResolutionNotifyWidth:height:peer:)，表示视图已经渲染
 */
@property (nonatomic,strong,readonly)VideoRenderIosView *remoteVideoView;

/**
 *  本地视频视图画面(只有当视频渲染成功后才有效，停止播放后会自动移除)
 *  回调分辨率时（#jfgResolutionNotifyWidth:height:peer:），表示视图已经渲染
 */
@property (nonatomic,strong,readonly)VideoRenderIosView *localVideoView;

/**
 *  视频回调代理
 */
@property (nonatomic,assign)id <JFGSDKPlayVideoDelegate> delegate;

#pragma mark- 直播
/**
 *  开始直播
 *  开始后视图将渲染到self.remoteVideoView上
 *  @param cid     设备标示
 *  @param isLocal 是否打开本地摄像头渲染本地画面
 */
-(void)startLiveVideo:(NSString *)cid isLoadLocalVideo:(BOOL)isLocal;


/**
 *  请使用startLiveVideo:isLoadLocalVideo:
 */
-(void)startLiveVideo:(NSString *)cid renderView:(VideoRenderIosView *)renderView;

/**
 *  打开本地摄像头
 *  (默认打开前置摄像头)
 *  @param front YES:前置摄像头  NO:后置摄像头
 */
-(void)openLocalCamera:(BOOL)front;

#pragma mark- 历史视频
/**
 *  开始准备历史视频
 *  开始后视图将渲染到self.localVideoView上
 *  @param cid 设备标示
 */
-(void)startHistoryVideo:(NSString *)cid beginTime:(int64_t)time;


/*!
 *  获取历史视频列表
 *
 *  @param cid 设备标示
 */
-(void)getHistoryVideoList:(NSString *)cid;

#pragma mark- 停止视频播放
/**
 *  停止视频播放（直播，历史）
 */
-(void)stopVideoPlay;

#pragma mark- 截图
/**
 *  截图
 *
 *  @param local 本地，远程
 *
 *  @return 截图
 */
-(UIImage *)videoScreenshotForLocal:(BOOL)local;

#pragma mark- 音频设置
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
