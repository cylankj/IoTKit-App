
//
//  VideoViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "VideoViewController.h"
#import <JFGSDK/JFGSDK.h>
#import "HistoryVideoViewController.h"
#import "RobotMsgViewController.h"
#import <JFGSDK/JFGSDKVideoView.h>

@interface VideoViewController ()<JFGSDKPlayVideoDelegate,UITableViewDelegate,UITableViewDataSource,JFGSDKCallbackDelegate>
{
    UIView *btnBgView;
    BOOL isAudio;
    BOOL isTalkBack;
    
    NSMutableArray *dataArray;
    NSMutableArray *_datArray;
    
    JFGSDKVideoView *playView;
}
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIView *videoBackgroudView;//直播视图背景视图
@property (nonatomic,strong)UIButton *voiceButton;//声音
@property (nonatomic,strong)UIButton *microphoneBtn;//麦克风
@property (nonatomic,strong)UIButton *snapBtn;//截图
@property (nonatomic,strong)UIBarButtonItem *rightBarItem;
@property (nonatomic,strong)UITableView *historyTableView;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Video";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    
    //直播视频渲染视图背景视图
    [self.view addSubview:self.videoBackgroudView];
    [self.videoBackgroudView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    [self.view addSubview:self.voiceButton];
    [self.view addSubview:self.snapBtn];
    [self.view addSubview:self.microphoneBtn];
    [self.view addSubview:self.historyTableView];
    _datArray = [NSMutableArray new];
    
    
}

-(void)setViewTop:(CGFloat)top forView:(UIView *)vw
{
    CGRect frame = vw.frame;
    frame.origin.y = top;
    vw.frame = frame;
}

-(void)subViewSizeToFitWithTop:(CGFloat)top
{
    [self setViewTop:top forView:self.voiceButton];
    [self setViewTop:top forView:self.snapBtn];
    [self setViewTop:top forView:self.microphoneBtn];
    [self setViewTop:top+50+20 forView:self.historyTableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    /*!
     *  开始视频直播
     *  可以通过回调#jfgRTCPNotifyBitRate:videoRecved:frameRate:timesTamp: 查看视频加载情况
     长时间接收视频数据为0，则为网络状况差或者超时。
     */
    
    //视频播放类初始化
    if (!playView) {
        playView = [[JFGSDKVideoView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 255)];
        playView.center = CGPointMake(self.view.bounds.size.width*0.5, 64+300);
        playView.delegate = self;
        [self.view addSubview:playView];
        [playView getHistoryVideoList:self._cid];
    }
    
    //开始直播
    [self startLiveVideo];
}

-(void)jfgFriendRequestList:(NSArray<JFGSDKFriendRequestInfo *> *)list error:(JFGErrorType)errorType
{
    
}

//直播
-(void)startLiveVideo
{
    //开始视频播放
    [playView startLiveRemoteVideo:self._cid];
    //菊花
    [self.activityIndicator startAnimating];
    self.voiceButton.alpha = 1;
    self.microphoneBtn.alpha = 1;
    self.snapBtn.alpha = 1;
}

//播放历史视频
-(void)startHistoryVideo:(int64_t)beginTime
{
    [playView startHistoryVideo:self._cid beginTime:beginTime];
    self.voiceButton.alpha = 0;
    self.microphoneBtn.alpha = 0;
    self.snapBtn.alpha = 0;
}

-(void)viewDidDisappear:(BOOL)animated
{
    //停止视频播放
    [playView stopVideo];
    
    
}



#pragma mark JFGSDK delegate
-(void)jfgRTCPNotifyBitRate:(int)bitRate
                videoRecved:(int)videoRecved
                  frameRate:(int)frameRate
                  timesTamp:(int)timesTamp
{
    NSLog(@"bit:%d",bitRate);
}


/*!
 *  摄像头录像分辨率通知
 *
 *  @param width  宽度
 *  @param height 高度
 */
-(void)jfgResolutionNotifyWidth:(int)width
                         height:(int)height
                           peer:(NSString *)peer
{
   
    NSLog(@"[w:%d h:%d]",width,height);
    

    CGRect frame = playView.frame;
    frame.origin.x = 0;
    frame.origin.y = 64;
    frame.size.height = height;
    playView.frame = frame;
    
    [self.activityIndicator stopAnimating];
    
    
    //其他控件重新布局
    [self subViewSizeToFitWithTop:height+64+20];
    CGRect tableframe = self.historyTableView.frame;
    tableframe.size.height = self.view.bounds.size.height - tableframe.origin.y;
    self.historyTableView.frame = tableframe;
   
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
    [self.activityIndicator stopAnimating];
}

//历史录像列表
-(void)jfgHistoryVideoList:(NSArray <JFGSDKHistoryVideoInfo *>*)list
{
    dataArray = [[NSMutableArray alloc]initWithArray:list];
    [self.historyTableView reloadData];
}

#pragma mark- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"hahahahah";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    JFGSDKHistoryVideoInfo *info  = dataArray[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:info.beginTime];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    cell.textLabel.text = dateStr;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"duration:%ds",info.duration];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[playVideo stopVideoPlay];
//    JFGSDKHistoryVideoInfo *info  = dataArray[indexPath.row];
//    [self startHistoryVideo:info.beginTime];
//    [self.rightBarItem setTitle:@"Live"];
    
   
}

#pragma mark- action
//摄像头声音
-(void)voiceAction:(UIButton *)sender
{
    if (sender.selected) {
        isAudio = NO;
        sender.selected = NO;
    }else{
        isAudio = YES;
        sender.selected = YES;
    }
    
    [playView setAudioForLocal:YES openMic:isTalkBack openSpeaker:isAudio];
    
    self.voiceButton.selected = sender.selected;
}

//对讲功能
-(void)microphoneAction:(UIButton *)sender
{
    if (sender.selected) {
        
        isTalkBack = NO;
        sender.selected = NO;
        [playView setAudioForLocal:YES openMic:isTalkBack openSpeaker:isAudio];
        [playView setAudioForLocal:NO openMic:YES openSpeaker:NO];
        self.voiceButton.enabled = YES;
        
    }else{
        
        isTalkBack = YES;
        sender.selected = YES;
        
        [playView setAudioForLocal:YES openMic:isTalkBack openSpeaker:YES];
        [playView setAudioForLocal:NO openMic:YES openSpeaker:YES];
        
        [self.voiceButton setImage:[UIImage imageNamed:@"camera_ico_voicedisabled"] forState:UIControlStateDisabled];
        self.voiceButton.enabled = NO;
        
    }
    self.microphoneBtn.selected = sender.selected;
    
}

//截图
-(void)snap
{
    self.snapBtn.enabled = NO;
    UIImage *videoImage = [playView videoScreenshotForLocal:NO];
    self.snapBtn.enabled = YES;
    [self saveImageToPhotos:videoImage];
}


//暂时不支持历史切直播
-(void)rightBarItemAction:(UIBarButtonItem *)barItem
{
    NSString *title = barItem.title;
    if ([title isEqualToString:@"History"]) {
        
        if (dataArray.count>0) {
            [barItem setTitle:@"Live"];
            //播放历史
            JFGSDKHistoryVideoInfo *info  = dataArray[0];
            [playView stopVideo];
            [self startHistoryVideo:info.beginTime];
            [self.historyTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        
    }else{
        [barItem setTitle:@"History"];
        //直播
        [self startLiveVideo];
    }
}



-(void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark- getter
-(UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _activityIndicator.center = CGPointMake(self.videoBackgroudView.bounds.size.width*0.5, self.videoBackgroudView.bounds.size.height*0.5);
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
    return _activityIndicator;
}

-(UIView *)videoBackgroudView
{
    if (!_videoBackgroudView) {
        _videoBackgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _videoBackgroudView.bounds = CGRectMake(0, 0, 720*.5, 576*0.5);
        _videoBackgroudView.center = CGPointMake(self.view.center.x, 64+576*0.25);
        _videoBackgroudView.backgroundColor = [UIColor blackColor];
    }
    return _videoBackgroudView;
}

#pragma mark- 顶部三个按钮
-(UIButton *)voiceButton
{
    if (!_voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceButton.frame = CGRectMake(96*0.5, CGRectGetMaxY(self.videoBackgroudView.frame)+50, 50, 50);
        [_voiceButton setImage:[UIImage imageNamed:@"camera_ico_voice"] forState:UIControlStateSelected];
        [_voiceButton setImage:[UIImage imageNamed:@"btn_closevoice"] forState:UIControlStateNormal];
        [_voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

-(UIButton *)microphoneBtn
{
    if (!_microphoneBtn) {
        
        _microphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _microphoneBtn.frame = CGRectMake(96*0.5, CGRectGetMaxY(self.videoBackgroudView.frame)+50-5, 60, 60);
        
        CGRect frame = _microphoneBtn.frame;
        frame.origin.x = self.view.bounds.size.width*0.5-frame.size.width*0.5;
        _microphoneBtn.frame= frame;
        [_microphoneBtn setImage:[UIImage imageNamed:@"camera_ico_ talk"] forState:UIControlStateNormal];
        [_microphoneBtn setImage:[UIImage imageNamed:@"camera_ico_ talkbule"] forState:UIControlStateSelected];
        [_microphoneBtn addTarget:self action:@selector(microphoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _microphoneBtn;
}

-(UIButton *)snapBtn
{
    if (!_snapBtn) {
        _snapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _snapBtn.frame = CGRectMake(96*0.5, CGRectGetMaxY(self.videoBackgroudView.frame)+50, 50, 50);
        CGRect frame = _snapBtn.frame;
        frame.origin.x = self.view.bounds.size.width-96*0.5-frame.size.width;
        _snapBtn.frame= frame;
        
        [_snapBtn setImage:[UIImage imageNamed:@"camera_icon_takepic"] forState:UIControlStateNormal];
        [_snapBtn setImage:[UIImage imageNamed:@"camera_icon_takepicdisabled"] forState:UIControlStateDisabled];
        [_snapBtn addTarget:self action:@selector(snap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _snapBtn;
}

-(UITableView *)historyTableView
{
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.microphoneBtn.frame)+10, self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.microphoneBtn.frame)-10) style:UITableViewStylePlain];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        
    }
    return _historyTableView;
}

-(UIBarButtonItem *)rightBarItem
{
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"History" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemAction:)];
    }
    return _rightBarItem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}
- (BOOL)shouldAutorotate
{
    return NO;
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
