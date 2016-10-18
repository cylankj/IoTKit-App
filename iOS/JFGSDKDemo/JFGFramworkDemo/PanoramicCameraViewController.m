//
//  PanoramicCameraViewController.m
//  JFGFramworkDemo
//
//  Created by 杨利 on 16/8/27.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "PanoramicCameraViewController.h"
#import <JFGSDK/JFGSDKVideoView.h>

@interface PanoramicCameraViewController ()<JFGSDKPlayVideoDelegate>
{
    JFGSDKVideoView *playVideo;
    UIView *remoteView;
    UIButton *gyroBtn;//开启、关闭陀螺仪
    UIButton *vrBtn;//开启关闭VR模式
    UIButton *mountModeBtn;//墙壁模式与屋顶模式
    UIButton *snapBtn;
}
@end

@implementation PanoramicCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    playVideo = [[JFGSDKVideoView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.width)];
    playVideo.delegate = self;
    

    remoteView = [playVideo startPanoramaLiveRemoteVideoForCid:self.cid];
    [playVideo configV360:PanoramaLiveModeTop];
    
    [self.view addSubview:playVideo];
    
    [self initVrBtnWithTop:self.view.bounds.size.width+64];
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [playVideo stopRenderLocalView];
}

-(void)jfgRTCPNotifyBitRate:(int)bitRate
                videoRecved:(int)videoRecved
                  frameRate:(int)frameRate
                  timesTamp:(int)timesTamp
{
    NSLog(@"bit:%d",bitRate);
}


/*!
 *  摄像头录像分辨率通知(这时候已经开始渲染画面)
 *  注意：一次连接只会回调一次
 *  @param width  宽度
 *  @param height 高度
 */
-(void)jfgResolutionNotifyWidth:(int)width
                         height:(int)height
                           peer:(NSString *)peer
{
    [self.view bringSubviewToFront:remoteView];
}



/*!
 *  音视频连接断开
 *
 *  @param remoteID  对端标示
 *  @param errorCode 错误码
 */
-(void)jfgTransportFail:(NSString *)remoteID
                  error:(JFGErrorType)errorType
{
    NSLog(@"连接断开");
}

-(BOOL)shouldAutorotate
{
    return YES;
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //计算旋转之后的宽度并赋值
        CGSize screen = [UIScreen mainScreen].bounds.size;
        //界面处理逻辑
        // self.lineChartView.frame = CGRectMake(0, 30, screen.width, 200.0);
        //动画播放完成之后
        if(screen.width > screen.height){
            NSLog(@"横屏");
        }else{
            NSLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        NSLog(@"动画播放完之后处理");
    }];
}

-(void)initVrBtnWithTop:(CGFloat)top
{
    //NSArray *btnTitle
    [vrBtn removeFromSuperview];
    [gyroBtn removeFromSuperview];
    [mountModeBtn removeFromSuperview];
    
    
    NSArray *btnTitleArr = @[@"开启陀螺仪",@"开启VR",@"开启墙壁模式",@"截图"];
    
    NSArray *btnSelectedTitleArr = @[@"关闭陀螺仪",@"关闭VR",@"开启屋顶模式",@"截图"];
    CGFloat bWidth = 100;
    CGFloat space = (self.view.bounds.size.width-bWidth*3)/6;
    [btnTitleArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx+2000;
        btn.frame = CGRectMake(space+(bWidth+space)*idx, top+20, bWidth, 40);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:btnSelectedTitleArr[idx] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(vRAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        
    }];
}

-(void)vRAction:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 2000:{//陀螺仪
            
            [playVideo enableGyro:!sender.selected];
            
        }
            break;
            
        case 2001:{//VR
            
            [playVideo enableVRMode:!sender.selected];
        }
            break;
            
        case 2002:{//悬挂模式
            
            if (sender.selected) {
                [playVideo setMountMode:PanoramaCameraParamTopPreset];
            }else{
                [playVideo setMountMode:PanoramaCameraParamWallPreset];
            }
            
        }
            break;
        case 2003:{//截图
            
            UIImage *image = [playVideo videoScreenshotForLocal:NO];
            NSLog(@"snap:%@",image);
            
        }
        default:
            break;
    }
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
