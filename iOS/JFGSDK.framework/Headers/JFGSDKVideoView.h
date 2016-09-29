//
//  JFGSDKVideoView.h
//  JFGSDK
//
//  Created by 杨利 on 16/8/29.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <UIKit/UIKit.h>
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

//以下为全景摄像头函数(暂时不用)
- (id)initPanoramicViewWithFrame:(CGRect)frame;
- (bool)isPanorama;
- (void)setMountMode:(MountMode)mode;
- (void)configV360:(CameraParam)p;
- (void)enableGyro:(bool)enable;
- (void)enableVRMode:(bool)enable;
- (void)notifyViewSizeChanged;
- (BOOL)loadImage:(NSString*)imgPath;

@end



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
 *  播放直播（全景摄像头,此功能暂时不完善）
 *
 *  @param cid 设备标示
 */
-(VideoRenderIosView *)startPanoramaLiveRemoteVideoForCid:(NSString *)cid;


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
 *  @param localView 本地摄像头渲染视图
 *  @param front     是否使用前置摄像头 YES：前置  NO：后置
 */
-(void)startRenderLocalView:(VideoRenderIosView *)localView forFrontCamera:(BOOL)front;


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




@end
