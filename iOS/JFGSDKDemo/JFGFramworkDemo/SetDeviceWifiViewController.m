//
//  SetDeviceWifiViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "SetDeviceWifiViewController.h"
#import <JFGSDK/JFGSDK.h>
#import <JFGSDK/JFGSDKBindingDevice.h>

@interface SetDeviceWifiViewController ()<JFGSDKBindDeviceDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *wifiNameTextFiled;
    UITextField *passwordTextFiled;
    UILabel *deviceTitleLabel;
    NSMutableArray *wifiList;
    UITableView *_tableView;
    
    UIView *coverView;
    UIActivityIndicatorView *loadingActivity;
    UILabel *loadingLabel;
    JFGSDKBindingDevice *bindDevice;
}
@end

@implementation SetDeviceWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"set WIFI";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
    bindDevice = [[JFGSDKBindingDevice alloc]init];
    
}

-(void)initView
{
    wifiList = [[NSMutableArray alloc]init];
    
    wifiNameTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(50, 64, self.view.bounds.size.width-100, 40)];
    wifiNameTextFiled.delegate = self;
    wifiNameTextFiled.placeholder = @"wifi Name";
    wifiNameTextFiled.text = @"Xiaomi_ACF2";
    wifiNameTextFiled.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:wifiNameTextFiled];
    
    passwordTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(wifiNameTextFiled.frame)+15, self.view.bounds.size.width-100, 40)];
    passwordTextFiled.delegate = self;
    passwordTextFiled.placeholder = @"wifi Password";
    passwordTextFiled.text = @"88888888";
    passwordTextFiled.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:passwordTextFiled];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"binding" style:UIBarButtonItemStyleDone target:self action:@selector(bindAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    bindDevice.delegate = self;
    //借助设备扫描周边wifi
    [bindDevice scanWifi];
}


-(void)viewWillDisappear:(BOOL)animated
{
    bindDevice.delegate = nil;
}



-(void)bindAction
{
    if (![wifiNameTextFiled.text isEqualToString:@""] && ![passwordTextFiled.text isEqualToString:@""]) {
        
        //bind Device   1.set device wifi   2.bind device
        [bindDevice bindDevWithSn:nil ssid:wifiNameTextFiled.text key:passwordTextFiled.text];
        
        [self starLoading];
    }
}

#pragma mark JFGSDK Delegate
/*!
 *  scan WiFi result
 */
-(void)jfgScanWifiRespose:(JFGSDKUDPResposeScanWifi *)ask
{
    if (!wifiList) {
        wifiList = [[NSMutableArray alloc]init];
    }
    
    BOOL isExsit = NO;
    for (NSString *ssid in [wifiList copy]) {
        
        
        if ([ssid isEqualToString:ask.ssid]) {
            isExsit = YES;
            break;
        }
        
    }
    if (isExsit == NO) {
        [wifiList addObject:ask.ssid];
        [_tableView reloadData];
    }
}

//绑定过程及成功回调
-(void)jfgBindDeviceProgressStatus:(JFGSDKBindindProgressStatus)status
{
    if (status == JFGSDKBindindProgressStatusSuccess) {
        [self stopLoading:@"bind success" delay:1.5 delayAction:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        NSLog(@"bind-Result:success");
    }
}

//绑定失败
-(void)jfgBindDeviceFailed:(int)errorCode
{
    [self stopLoading:@"bind fail" delay:1.5 delayAction:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    NSLog(@"bind-Result:fail");
}

//bind Device Result delegate


#pragma mark laodView
-(void)starLoading
{
    
    if (!coverView) coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    coverView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:coverView];
    
    if (!loadingActivity) loadingActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingActivity.frame = CGRectMake(0, 0, 100, 100);
    loadingActivity.center = coverView.center;
    [loadingActivity startAnimating];
    [loadingActivity setHidesWhenStopped:YES];
    [coverView addSubview:loadingActivity];
    
    if (!loadingLabel) loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loadingActivity.frame), self.view.bounds.size.width, 40)];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.text = @"binding...";
    [coverView addSubview:loadingLabel];
    
}


-(void)stopLoading:(NSString *)text delay:(NSInteger)delay delayAction:(void(^)(void))action
{
    [loadingActivity stopAnimating];
    loadingLabel.text = text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [loadingActivity removeFromSuperview];
        loadingActivity = nil;
        
        [loadingLabel removeFromSuperview];
        loadingLabel = nil;
        
        [coverView removeFromSuperview];
        coverView = nil;
        
        if (action) {
            action();
        }
        
    });
}





-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == wifiNameTextFiled) {
        
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300);
        }];
        return NO;
        
    }
    
    return YES;
    
}



#pragma mark TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return wifiList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"555556666"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"555556666"];
    }
    NSString *ssid = wifiList[indexPath.row];
    cell.textLabel.text = ssid;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ssid = wifiList[indexPath.row];
    wifiNameTextFiled.text = ssid;
    [UIView animateWithDuration:0.5 animations:^{
         _tableView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 300);
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 300);
    }];
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
