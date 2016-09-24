//
//  HistoryVideoViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/6.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "HistoryVideoViewController.h"
#import <JFGSDK/JFGSDK.h>

@interface HistoryVideoViewController ()<UITableViewDelegate,UITableViewDataSource,JFGSDKCallbackDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    UIView *videoView;
}
@end

@implementation HistoryVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    //get device info
    //JFGSDKDevice * deviceInfo = [JFGSDK getDeviceInfoByCid:__cid];
    
    
//    //is camera （只有摄像头，并且摄像头插有sd卡才有历史视频）
//    if (deviceInfo.deviceType == JFGDeviceTypeCameraWifi
//        || deviceInfo.deviceType == JFGDeviceTypeCamera3G
//        || deviceInfo.deviceType == JFGDeviceTypeCamera4G) {
//    
//        // hasSDCard
//        if (deviceInfo.runStatusInfo.hasSDCard) {
//            
//            
//            [self initView];
//            
//            [JFGSDK addDelegate:self];
//            [JFGSDK getHistoryVideoList:__cid];
//            
//            videoView = [JFGSDK playVideoForCid:__cid isHistory:YES];
//            videoView.frame = CGRectMake(0, 64, videoView.bounds.size.width, videoView.frame.size.height);
//            videoView.center = CGPointMake(self.view.center.x, videoView.center.y);
//            [self.view addSubview:videoView];
//            
//            _tableView.frame = CGRectMake(0, CGRectGetMaxY(videoView.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(videoView.frame));
//            
//            return;
//            
//        }
//        
//    }
//    
//    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"not history video" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [aler show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[JFGSDK stopVideoPlay];
}

-(void)initView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark JFGSDK Delegate
-(void)jfgHistoryVideoList:(NSArray<JFGSDKHistoryVideoInfo *> *)list
{
    dataArray = [[NSMutableArray alloc]initWithArray:list];
    [_tableView reloadData];
    
    if (dataArray.count > 1) {
        //JFGSDKHistoryVideoInfo *info = dataArray[0];
        //[JFGSDK historyBeginTime:info.beginTime];
    }
}

-(void)jfgRTCPNotifyBitRate:(int)bitRate videoRecved:(int)videoRecved frameRate:(int)frameRate timesTamp:(int)timesTamp
{
    NSLog(@"bit:%d videoRec:%d",bitRate,videoRecved);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"22222"];
    if (!cell) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"22222"];
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
    JFGSDKHistoryVideoInfo *info  = dataArray[indexPath.row];
    //[JFGSDK historyBeginTime:info.beginTime];
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
