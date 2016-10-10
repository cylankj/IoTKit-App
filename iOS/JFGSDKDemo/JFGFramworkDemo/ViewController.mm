//
//  ViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/3/25.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "ViewController.h"
#import <JFGSDK/JFGSDK.h>
#import <JFGSDK/JFGSDKBindingDevice.h>
//#import <JFGSDK/JFGSDKBase.h>
//#import "JFGSDK.h"
#import "MessageViewController.h"
#import "BindingDevicesViewController.h"
#import "AddDeviceViewController.h"
#import <JFGSDK/JFGSDKDataPoint.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "FLProressHUD.h"


#define TRANSPORT_READY_NOTIFICATION @"transport_ready_notification"
#define REMOTE_VIEW_TAG 1000
#define LOCALL_VIEW_TAG 1001


#define USERNAME @"18503060168"
#define USERPASS @"123456"

#define VID @"0001"
#define VKEY @"dnwB7zfqjOqUmayw9XbVbfWh8ahSIShs"


@interface ViewController ()<JFGSDKCallbackDelegate,UITextFieldDelegate>
{
    UIButton *connectButton;
    UIButton *messageButton;
    UIButton *bindDeviceButton;
    UIButton *addButton;
    NSString *smsToken;
    BOOL isConnectServer;
    BOOL isLogin;
    
    NSArray *_deviceList;
    NSDate *recordDate;
    
    
    UITextField *accountTextField;
    UITextField *passwordTextField;
    UITextField *codeTextField;
    
    UIButton *switchBtn;//切换登陆注册
    UIButton *loginButton;//登陆/注册按钮
    UIButton *codeBtn;//获取手机验证码
    BOOL isLoginAction;//状态记录
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    path = [path stringByAppendingPathComponent:@"jfgworkdic"];
    
    //SDK初始化
    [JFGSDK connectForWorkDir:path];
    
    //SDK回调设置
    [JFGSDK addDelegate:self];
    
    //打开SDK操作日志
    [JFGSDK logEnable:YES];
    
   
#pragma mark view

    isLoginAction = YES;
    
    [self initView];

    
//    DataPointIDVerSeg * seg0 = [[DataPointIDVerSeg alloc]init];
//    seg0.msgId = 201;
//    DataPointIDVerSeg * seg1 = [[DataPointIDVerSeg alloc]init];
//    seg1.msgId = 205;
//    DataPointIDVerSeg * seg2 = [[DataPointIDVerSeg alloc]init];
//    seg2.msgId = 203;
//    DataPointIDVerSeg * seg3 = [[DataPointIDVerSeg alloc]init];
//    seg3.msgId = 206;
//    DataPointIDVerSeg * seg4 = [[DataPointIDVerSeg alloc]init];
//    seg4.msgId = 208;
//    DataPointIDVerSeg * seg5 = [[DataPointIDVerSeg alloc]init];
//    seg5.msgId = 209;
//    
//    NSArray * msgArr0 = @[seg0,seg1,seg3,seg4,seg5,seg2];
//    
//    
//    [[JFGSDKDataPoint sharedClient]robotGetDataForCacheWithPeer:@"200000149340" msgIds:msgArr0 asc:NO limit:1 success:^(NSString *identity, NSArray<NSArray<DataPointSeg *> *> *idDataList) {
//        if (idDataList.count > 0) {
//            NSMutableArray * tempArray = [NSMutableArray array];
//            
//            for (NSArray * subArr in idDataList) {
//                for (DataPointSeg *seg in subArr) {
//                    NSError * error = nil;
//                    id obj = [MPMessagePackReader readData:seg.value error:&error];
//                    [tempArray addObject:obj];
//                    NSLog(@"_______%@",tempArray);
//                }
//            }
//            
//            
//        }
//        
//       
//    }];
    
    


    NSLog(@"sdkVersion:%@",[JFGSDK getSDKVersion]);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark- JFGSDK Delegate
//账号在线状态改变通知
-(void)jfgAccountOnline:(BOOL)online
{
    NSLog(@"online:%d",online);
    [self isLoginSuccess:online];
}

//登陆结果
-(void)jfgLoginResult:(JFGErrorType)errorType
{
    NSLog(@"登录消耗时间：%f",[[NSDate date] timeIntervalSinceDate:recordDate]);
    if (errorType == JFGErrorTypeNone) {
        
        [self isLoginSuccess:YES];
        //[JFGSDK addFriendByAccount:@"1586711571@qq.com" additionTags:@"hello"];
        
    }else{
        
        [self isLoginSuccess:NO];
    }
}

-(void)jfgResultIsRelatedToFriendWithType:(JFGFriendResultType)type error:(JFGErrorType)errorType
{
    
}

//注册结果
-(void)jfgRegisterResult:(JFGErrorType)errorType
{
    NSString *msg ;
    if (errorType == 0) {
        msg = @"注册成功";
    }else{
        msg = @"注册失败";
    }
    [FLProressHUD showTextFLHUDForStyleLightWithView:self.view text:msg position:FLProgressHUDPositionCenter];
    [FLProressHUD hideAllHUDForView:self.view animation:YES delay:1];
}


//发送验证码结果
-(void)jfgSendSMSResult:(JFGErrorType)errorType token:(NSString *)token
{
    NSString *msg;
    if (errorType == 0) {
        msg = @"验证码发送成功";
    }else{
        msg = @"验证码发送失败";
    }
    [FLProressHUD showTextFLHUDForStyleLightWithView:self.view text:msg position:FLProgressHUDPositionCenter];
    [FLProressHUD hideAllHUDForView:self.view animation:YES delay:1];
    smsToken = token;
}


//验证码校验结果
-(void)jfgVerifySMSResult:(JFGErrorType)errorType
{
    
    if (errorType == 0) {
        [JFGSDK userRegister:accountTextField.text keyword:passwordTextField.text registerType:0 token:smsToken vid:VID];
    }
}



//已绑定设备列表
-(void)jfgDeviceList:(NSArray<JFGSDKDevice *> *)deviceList
{
    for (JFGSDKDevice *device in deviceList) {
        NSLog(@"pid:%@ sn:%@ uuid:%@",device.pid,device.sn,device.uuid);
        //[JFGSDK getDevStatus:device.uuid];
    }
    _deviceList = [[NSArray alloc]initWithArray:deviceList];
    //登陆成功，跳转设备列表页面
    BindingDevicesViewController *bind = [BindingDevicesViewController new];
    bind.deviceList = (NSMutableArray *)_deviceList;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:bind];
    [self presentViewController:nav animated:YES completion:nil];
    [FLProressHUD hideAllHUDForView:self.view animation:NO delay:0];
}

//账号信息
-(void)jfgUpdateAccount:(JFGSDKAcount *)account
{
    NSLog(@"phone:%@",account.phone);
}

-(void)jfgDoorbellCall:(JFGSDKDoorBellCall *)call
{
    NSLog(@"来自门铃的呼叫");
}

-(void)isLoginSuccess:(BOOL)success
{
    loginButton.selected = isLogin = success;
    bindDeviceButton.enabled = addButton.enabled = success;
    if (success) {
        
        //获取账号信息
        [JFGSDK getAccount];
        [FLProressHUD showTextFLHUDForStyleLightWithView:self.view text:@"登陆成功" position:FLProgressHUDPositionCenter];
        [FLProressHUD hideAllHUDForView:self.view animation:YES delay:1];
        NSLog(@"登陆成功");
        
    }else{
        
        NSLog(@"登陆失败");
        [FLProressHUD showTextFLHUDForStyleLightWithView:self.view text:@"登陆失败" position:FLProgressHUDPositionCenter];
        [FLProressHUD hideAllHUDForView:self.view animation:YES delay:1];
    }
    
}



-(void)initView
{
#pragma mark- textField
    
    CGFloat textFieldWidth = 260;
    CGFloat textFieldHeight = 35;
    CGFloat left = (self.view.bounds.size.width-textFieldWidth)*0.5;
    CGFloat space = 30;
    
    NSArray *titleArr = @[@"phone number",@"password",@"security code"];
    
    [titleArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITextField *textfield = [self factoryTextFieldWithFrame:CGRectMake(left, 50+idx*(space+textFieldHeight), textFieldWidth, textFieldHeight) placeholder:title];
        [self.view addSubview:textfield];
        
        switch (idx) {
            case 0:{
                accountTextField = textfield;
                textfield.text= USERNAME;
            }
                break;
            case 1:{
                passwordTextField = textfield;
                textfield.text= USERPASS;
            }
                break;
            case 2:{
                codeTextField = textfield;
                codeTextField.hidden = YES;
                
                CGRect newFrame = codeTextField.frame;
                newFrame.size.width = textFieldWidth*0.6;
                codeTextField.frame = newFrame;
            }
                break;
             
            default:
                break;
        }
        
    }];
    
#pragma mark- button
    CGFloat btnWidth = 100;
    CGFloat btnHeight = 30;
    
    loginButton = [self factoryBtnWithFrame:CGRectMake((self.view.bounds.size.width-btnWidth)*0.5, CGRectGetMaxY(codeTextField.frame)+50, 100, btnHeight) title:@"Login"];
    [loginButton addTarget:self action:@selector(loginRegiterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
   
    switchBtn = [self factoryBtnWithFrame:CGRectMake(loginButton.frame.origin.x, self.view.bounds.size.height-btnHeight-30, btnWidth, btnHeight) title:@"Register"];
    [switchBtn addTarget:self action:@selector(switchLoginOrRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchBtn];
    
    codeBtn = [self factoryBtnWithFrame:CGRectMake(textFieldWidth*0.6+10+left, CGRectGetMinY(codeTextField.frame), textFieldWidth-textFieldWidth*0.6-10, textFieldHeight) title:@"code"];
    [codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    codeBtn.hidden = YES;
}

-(void)getCode
{
    if ([accountTextField.text isEqualToString:@""]) {
        [FLProressHUD showTextFLHUDForStyleLightWithView:self.view text:@"请输入手机号" position:FLProgressHUDPositionCenter];
        [FLProressHUD hideAllHUDForView:self.view animation:YES delay:2];
    }else{
        [JFGSDK sendSMSWithPhoneNumber:accountTextField.text type:0];
    }
}

-(void)switchLoginOrRegister
{
    if (isLoginAction) {
        
        codeTextField.hidden = codeBtn.hidden = NO;
        [loginButton setTitle:@"Register" forState:UIControlStateNormal];
        [switchBtn setTitle:@"Login" forState:UIControlStateNormal];
        isLoginAction = NO;
        
    }else{
        
        codeTextField.hidden = codeBtn.hidden = YES;
        
        [loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [switchBtn setTitle:@"Register" forState:UIControlStateNormal];
        isLoginAction = YES;
    }
}

-(void)loginRegiterAction
{
    NSString *alertStr;
    BOOL isOk = NO;
    if (isLoginAction) {
        //登陆
        if ([accountTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""]) {
            alertStr = @"请输入正确的账号密码信息";
        }else{
            recordDate = [NSDate date];
            [JFGSDK userLogin:accountTextField.text keyword:passwordTextField.text vid:VID vkey:VKEY];
            alertStr = @"登录中...";
            isOk = YES;
        }
        
    }else{
        
        if ([accountTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""] ) {
            
            alertStr = @"请输入完整的注册信息";
            
        }else{
            
            alertStr = @"注册中...";
            isOk = YES;
            [JFGSDK verifySMSWithAccount:accountTextField.text code:codeTextField.text token:smsToken];
            
        }
        
        
    }
    if (isOk) {
        [FLProressHUD showIndicatorViewFLHUDForStyleLightWithView:self.view text:alertStr position:FLProgressHUDPositionCenter];
    }else{
        [FLProressHUD showTextFLHUDForStyleLightWithView:self.view text:alertStr position:FLProgressHUDPositionCenter];
        [FLProressHUD hideAllHUDForView:self.view animation:YES delay:2];
    }
    
}




-(UIButton *)factoryBtnWithFrame:(CGRect)frame title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    button.frame =frame;
    return button;
}

-(UITextField *)factoryTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    UITextField *textFiled = [[UITextField alloc]initWithFrame:frame];
    textFiled.delegate = self;
    textFiled.placeholder = placeholder;
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    return textFiled;
}

-(void)action:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 1000:{
            //登陆
            if (isLogin) {
                //退出登陆
                [JFGSDK logout];
                [self isLoginSuccess:NO];
                
            }else{
                //登陆
                [JFGSDK userLogin:USERNAME keyword:USERPASS vid:VID vkey:VKEY];
            }
        }
            
            break;
        case 1001:{
            //已绑定设备
            BindingDevicesViewController *bind = [BindingDevicesViewController new];
            bind.deviceList = _deviceList;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:bind];
            [self presentViewController:nav animated:YES completion:nil];
        }
            
            break;
        case 1002:{
            AddDeviceViewController *add = [AddDeviceViewController new];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:add];
            [self presentViewController:nav animated:YES completion:nil];

        }
           
        default:
            break;
    }
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
