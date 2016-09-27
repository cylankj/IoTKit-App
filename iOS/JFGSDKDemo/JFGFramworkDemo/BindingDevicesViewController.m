//
//  BindingDevicesViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "BindingDevicesViewController.h"
#import <JFGSDK/JFGSDK.h>
#import "VideoViewController.h"
#import "DoorCallViewController.h"
#import "AddDeviceViewController.h"
#import <JFGSDK/JFGSDKDataPoint.h>
#import "PanoramicCameraViewController.h"
//200000149340
@interface BindingDevicesViewController ()<JFGSDKCallbackDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIBarButtonItem *rightBarItem;
@property (nonatomic,strong)UIBarButtonItem *leftBarItem;

@end

@implementation BindingDevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Device that has been bound";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [JFGSDK addDelegate:self];
    
    //添加设备按钮
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;

    //设备列表视图
    [self.view addSubview:self.tableView];
    
    
    /**
     
     msgpack 数据打包
     NSString *sourceStr = @"msgpack pack test";
     NSData *msgPackData = [MPMessagePackWriter writeObject:sourceStr error:nil];
     
     */
//    DataPointIDVerSeg *seg = [[DataPointIDVerSeg alloc]init];
//    seg.msgId = 507;
//    seg.version = 0;
    
//    DataPointSeg *setSeg = [[DataPointSeg alloc]init];
//    setSeg.msgId = 215;
//    setSeg.value = [MPMessagePackWriter writeObject:[NSNumber numberWithBool:YES] error:nil];
//    setSeg.version = 0;
//    
//   [[JFGSDKDataPoint sharedClient] robotSetDataWithPeer:@"200000149340" dps:@[setSeg] success:^(NSArray<DataPointIDVerRetSeg *> *dataList) {
//       NSLog(@"%@",dataList);
//   } failure:^(RobotDataRequestErrorType type) {
//       
//   }];

    
    
    
}

-(void)logout
{
    [JFGSDK logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    
//dataPoint实力
    
//    DataPointSeg *seg = [[DataPointSeg alloc]init];
//    seg.msgId = 214;
//    seg.version = 0;
//    NSArray *arr = [[NSArray alloc]initWithObjects:@"Asia",@"123456", nil];
//    
//    NSData *vD = [MPMessagePackWriter writeObject:arr error:nil];
//    seg.value = vD;
//    
//    [[JFGSDKDataPoint sharedClient] robotSetDataWithPeer:@"200000149340" dps:@[seg] success:^(NSArray<DataPointIDVerRetSeg *> *dataList) {
//        NSLog(@"%@",dataList);
//    } failure:^(RobotDataRequestErrorType type) {
//        
//    }];
    
    
    
    
//    [[JFGSDKDataPoint sharedClient] robotGetSingleDataWithPeer:@"200000149340" msgIds:@[[NSNumber numberWithInt:214]] success:^(NSString *identity, NSArray<NSArray<DataPointSeg *> *> *idDataList) {
//        
//        for (NSArray *subArray in idDataList) {
//            
//            for (DataPointSeg *seg in subArray) {
//                
//                id obj = [MPMessagePackReader readData:seg.value error:nil];
//                NSLog(@"%@",obj);
//                
//            }
//            
//        }
//        
//    } failure:^(RobotDataRequestErrorType type) {
//        
//    }];
//    
   
    
    
    
    
}

-(void)jfgDeviceShareList:(NSDictionary<NSString *,NSArray<JFGSDKFriendRequestInfo *> *> *)friendList
{
    
    NSLog(@"%@",[friendList description]);
    
}


-(void)jfgResultIsRelatedToFriendWithType:(JFGFriendResultType)type error:(JFGErrorType)errorType
{
    NSLog(@"%d,%d",type,errorType);
    if (type == JFGFriendResultTypeSetRemarkName) {
        [JFGSDK getFriendInfoByAccount:@"yangli996@126.com"];
    }
}

-(void)jfgFriendList:(NSArray *)list error:(JFGErrorType)errorType
{
    
}

-(void)jfgFriendRequestList:(NSArray <JFGSDKFriendRequestInfo *>*)list error:(JFGErrorType)errorType
{
//    for (JFGSDKFriendRequestInfo *info in list) {
//        
////        [JFGSDK agreeRequestForAddFriendByAccount:info.account];
//        
//    }
}

-(void)jfgGetFriendInfo:(JFGSDKFriendInfo *)info error:(JFGErrorType)errorType
{
    
}

//添加设备
-(void)addDeviceAction
{
    AddDeviceViewController *add = [AddDeviceViewController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:add];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)jfgDeviceList:(NSArray<JFGSDKDevice *> *)deviceList
{
    _deviceList = [[NSMutableArray alloc]initWithArray:deviceList];
    [_tableView reloadData];
    NSLog(@"设备列表更新");
}


#pragma mark- tableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:@"dingCellID"];
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"dingCellID"];
    }
    
    id obj = self.deviceList[indexPath.row];
    if ([obj isKindOfClass:[JFGSDKDevice class]]) {
        JFGSDKDevice *message = obj;
        
        if (message.alias && ![message.alias isEqualToString:@""]) {
            
            _cell.textLabel.text = message.alias;
            
        }else{
            
            _cell.textLabel.text = message.uuid;
        }
    }
    return  _cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JFGSDKDevice *message = self.deviceList[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    switch ([message.pid intValue]) {
        case 4:
        case 5:
        case 7:
        case 13:{
            
            //摄像头
            VideoViewController *video = [VideoViewController new];
            video._cid = message.uuid;
            [self.navigationController pushViewController:video animated:YES];
            
        }
            break;
        case 6:
        case 14:
        case 15:{
            //门铃
            VideoViewController *video = [VideoViewController new];
            video._cid = message.uuid;
            [self.navigationController pushViewController:video animated:YES];
        }
            break;
        case 11:{
            //门磁
        }
            break;
        case 8:{
            //中控
        }
            break;
            
        case 18:
        case 86:{
            PanoramicCameraViewController *pan = [PanoramicCameraViewController new];
            pan.cid = message.uuid;
            [self.navigationController pushViewController:pan animated:YES];
        }
            break;
        default:
            break;
    }

}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //        获取选中删除行索引值
        NSInteger row = [indexPath row];
        //        通过获取的索引值删除数组中的值
        
        JFGSDKDevice *message = self.deviceList[row];
        
        //解除绑定
        [JFGSDK unBindDev:message.uuid];
        
        [self.deviceList removeObjectAtIndex:row];
        
        //        删除单元格的某一行时，在用动画效果实现删除过程
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }  
}

#pragma mark- getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(UIBarButtonItem *)rightBarItem
{
    if (!_rightBarItem) {
        _rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addDeviceAction)];
    }
    return _rightBarItem;
}

-(UIBarButtonItem *)leftBarItem
{
    if (!_leftBarItem) {
        _leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    }
    return _leftBarItem;
}

-(void)setDeviceList:(NSMutableArray *)deviceList
{
    _deviceList = [deviceList mutableCopy];
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
