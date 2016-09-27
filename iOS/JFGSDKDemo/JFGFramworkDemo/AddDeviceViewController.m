//
//  AddDeviceViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "AddDeviceViewController.h"
#import <JFGSDK/JFGSDK.h>
#import <JFGSDK/JFGSDKToolMethods.h>
#import "SetDeviceWifiViewController.h"

@interface AddDeviceViewController ()<JFGSDKCallbackDelegate>
{
    BOOL isConnectedDeviceWifi;
}
@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Device";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
   
    
}

-(void)initView
{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    NSArray *stepArr = @[@"1.Please press the WiFi button 3 seconds",
                         @"2.Please make sure the WiFi indicator light is blue flashing",
                         @"3.Please via \"Settings\"->\"WLAN\",choose \"DOG-******\"join on your iPhone, Password is 11111111",
                         @"4.Return to App,tap 'Next'"];
    UILabel *stepLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 20)];
    stepLable.text = @"step";
    stepLable.font = [UIFont systemFontOfSize:18];
    stepLable.textColor = [UIColor blackColor];
    stepLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:stepLable];
    
    CGFloat top = CGRectGetMaxY(stepLable.frame)+30;
    CGFloat height = 50;
    CGFloat space = (self.view.bounds.size.height-top-height*4-200)/3.0;
    if (space>30) {
        space = 30;
    }
    
    [stepArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, top+idx*(height+space), self.view.bounds.size.width-80, height)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        label.text = title;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
   
}

-(void)viewDidAppear:(BOOL)animated
{
    
}


-(void)getCurrentWifiName
{
    
    //get apple device current WiFi Name
    NSString *currentWifiName = [JFGSDKToolMethods currentWifiName];
    NSLog(@"wifiName:%@",currentWifiName);
    
    
    //is connected Device WiFi
    if ([currentWifiName hasPrefix:@"DOG-"]) {
        isConnectedDeviceWifi = YES;
    }else{
        isConnectedDeviceWifi = NO;
        
    }

}


-(void)nextAction
{
    [self getCurrentWifiName];
    if (isConnectedDeviceWifi) {
        
        SetDeviceWifiViewController *bind = [SetDeviceWifiViewController new];
        [self.navigationController pushViewController:bind animated:YES];
        
    }else{
        NSLog(@"请让您的iphone，连接设备wifi");
    }
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
