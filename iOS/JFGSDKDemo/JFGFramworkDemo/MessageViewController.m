//
//  MessageViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/1.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "MessageViewController.h"
#import <JFGSDK/JFGSDK.h>

@interface MessageViewController ()<JFGSDKCallbackDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"Message";
    
    [self initView];
    
    [JFGSDK addDelegate:self];
    
    //Get All device newest message list
    //[JFGSDK getMessageContents];
    
}



-(void)initView
{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"Ignore" style:UIBarButtonItemStyleDone target:self action:@selector(ignoreUnRead)];
    UIBarButtonItem *refreshBar = [[UIBarButtonItem alloc]initWithTitle:@"Refresh" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    
    
    
    self.navigationItem.rightBarButtonItems = @[rightBar,refreshBar];
    
    dataArray = [[NSMutableArray alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}


//refresh
-(void)refresh
{
    //[JFGSDK getMessageContents];
}


//ignore unread
-(void)ignoreUnRead
{
    //[JFGSDK igoreUnReadMessage];
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark JFGSDK Delegate

-(void)jfgMessageList:(NSArray<JFGSDKMessageDevice *> *)list
{
    dataArray = [[NSMutableArray alloc]initWithArray:list];
    [_tableView reloadData];
    
    if (list.count>0) {
        JFGSDKMessageDevice *deve = list[0];
         //get Deviece All Message
        //[JFGSDK getDev:deve.cid MessageByTime:[NSDate date]];
    }
    
    //NSDate *oneYearAgo = [NSDate dateWithTimeIntervalSinceNow:-1*365*24*60*60];
    
   
    
    
}


//Device All Message
-(void)jfgMessageDetailByCid:(NSString *)cid list:(NSArray<JFGSDKMessageDevice *> *)list
{
    for (JFGSDKMessageDevice *detail in list) {
        
        NSDate *time = [NSDate dateWithTimeIntervalSince1970:detail.time];
        NSLog(@"time:%@  pushType:%d  devieceType:%d",time,detail.type,detail.os);
    }
    
}

#pragma mark TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:@"messageCellID"];
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"messageCellID"];
        
       
    }
    
   
    
    
    id obj = dataArray[indexPath.row];
    if ([obj isKindOfClass:[JFGSDKMessageDevice class]]) {
        JFGSDKMessageDevice *message = obj;
        
        
        if (message.unReadCount == 0) {
            _cell.textLabel.text = message.cid;
        }else{
            _cell.textLabel.text = [NSString stringWithFormat:@"%@(%d Unread)",message.cid,message.unReadCount];
        }
        
        switch (message.type) {
            case 0:
                _cell.detailTextLabel.text = @"Unknow";
                break;
            case 1:
                _cell.detailTextLabel.text = @"New Version";
                break;
            case 2:
                _cell.detailTextLabel.text = @"Warn On";
                break;
            case 3:
                _cell.detailTextLabel.text = @"Warn";
                break;
            case 4:
                _cell.detailTextLabel.text = @"Warn Off";
                break;
            case 5:
                _cell.detailTextLabel.text = @"Low Battery";
                break;
            case 6:
                _cell.detailTextLabel.text = @"SDCard eject";
                break;
                
            case 7:
                _cell.detailTextLabel.text = @"SDCard Mount";
                break;
            case 8:
                _cell.detailTextLabel.text = @"Remove binding";
                break;

            case 9:
                _cell.detailTextLabel.text = @"Binding success";
                break;

            case 10:
                _cell.detailTextLabel.text = @"Rebind";
                break;

            case 11:
                _cell.detailTextLabel.text = @"Share success";
                break;

            case 12:
                _cell.detailTextLabel.text = @"Cancel share";
                break;

            case 13:
                _cell.detailTextLabel.text = @"Magnet on";
                break;

            case 14:
                _cell.detailTextLabel.text = @"Magnet off";
                break;

            default:
                break;
        }
        
        
    }
    
    
    
    return  _cell;
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
