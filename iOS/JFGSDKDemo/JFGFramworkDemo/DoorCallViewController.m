//
//  DoorCallViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/8.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "DoorCallViewController.h"
#import <JFGSDK/JFGSDK.h>


@interface DoorCallViewController ()<JFGSDKCallbackDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_videoView;
    UITableView *_tableView;
    NSMutableArray *dataArray;
    NSString *callCid;
    UIButton *closeBtn;
    UIButton *connectBtn;
}
@end

@implementation DoorCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dataArray = [[NSMutableArray alloc]init];
    [self initView];
    
    [JFGSDK addDelegate:self];
    //get doorbell call record list
    //[JFGSDK getDoorBellCallList:__cid endDate:[NSDate date]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [JFGSDK addDelegate:self];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [JFGSDK removeDelegate:self];
    [self stopVideoPlay];
   
}

-(void)startVideoPlay
{
    connectBtn.enabled = NO;
    closeBtn.enabled = YES;
    /*!
     *  开始视频直播 获取视频播放视图
     */
    //_videoView = [JFGSDK playVideoForCid:__cid isHistory:NO];
    _videoView.frame = CGRectMake(0, 64, 320, 276);
    _videoView.center = CGPointMake(self.view.center.x, _videoView.center.y);
    [self.view addSubview:_videoView];
}

-(void)stopVideoPlay
{
   
}


-(void)initView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+350, self.view.bounds.size.width, self.view.bounds.size.height-64-350) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    CGFloat width = 80;
    CGFloat height = 30;
    CGFloat space = (self.view.bounds.size.width-width*2)/3.0;
    CGFloat top = (74-height)*0.5+64+276;
    
    connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    connectBtn.frame = CGRectMake(space, top, width, height);
    [connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
    [connectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [connectBtn addTarget:self action:@selector(startVideoPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connectBtn];
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(space*2+width, top, width, height);
    [closeBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(stopVideoPlay) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.enabled = NO;
    [self.view addSubview:closeBtn];
}

-(void)jfgDoorbellCallRecord:(NSArray<JFGSDKDoorBellCall *> *)callList
{
    dataArray = [[NSMutableArray alloc]initWithArray:callList];
    [_tableView reloadData];
}

-(void)jfgDoorbellCall:(JFGSDKDoorBellCall *)call
{
    if (!call.isAnswer) {
        callCid = call.cid;
        UIAlertView *aler =[[UIAlertView alloc]initWithTitle:@"Door Call" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"connect", nil];
        [aler show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
       // [JFGSDK answerCall:__cid];
        
       

       // [JFGSDK getDoorBellCallList:__cid endDate:[NSDate date]];
    }
}


#pragma mark TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JFGSDKDoorBellCall *cll = dataArray[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cll.url]];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:cll.time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:date];
    cell.textLabel.text = timeStr;
    
    return cell;
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
