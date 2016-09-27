//
//  RobotMsgViewController.m
//  JFGFramworkDemo
//
//  Created by 杨利 on 16/4/18.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "RobotMsgViewController.h"
#import <JFGSDK/JFGSDK.h>

@interface RobotMsgViewController ()<UITextFieldDelegate,JFGSDKCallbackDelegate>
{
    UITextField *msgTextFiled;
    UITextView *receiveTextView;
    NSString *receiveMsg;
}
@end

@implementation RobotMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"robot message";
    [JFGSDK addDelegate:self];
    [self initView];
    
    // Do any additional setup after loading the view.
}

-(void)initView
{
    CGFloat btnWidth = 50;
    msgTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, self.view.bounds.size.width-20-btnWidth-40, 30)];
    msgTextFiled.delegate = self;
    msgTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    msgTextFiled.placeholder = @"send message";
    [self.view addSubview:msgTextFiled];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(CGRectGetMaxX(msgTextFiled.frame)+20, CGRectGetMinY(msgTextFiled.frame), btnWidth, 30);
    [sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    receiveTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(msgTextFiled.frame), self.view.bounds.size.width-40, 100)];
    receiveTextView.editable = NO;
    [self.view addSubview:receiveTextView];
    
}


-(void)sendAction
{
    
    if ([msgTextFiled.text isEqualToString:@""]) {
        return;
    }
    [msgTextFiled resignFirstResponder];
    JFGSDKRobotMessage *robot = [[JFGSDKRobotMessage alloc]init];
    robot.msg = msgTextFiled.text;
    robot.sn = 23;
    robot.targets = @[__cid];
    robot.isAck = YES;
    [JFGSDK robotTransmitMsg:robot];
}


-(void)jfgOnRobotMsgAck:(int)sn
{
    if (receiveMsg == nil) {
        receiveMsg = [NSString stringWithFormat:@"sn:%d \n",sn];
    }
    
    receiveMsg = [receiveMsg stringByAppendingString:[NSString stringWithFormat:@"sn:%d \n",sn]];
    NSLog(@"robot msg ask-%d",sn);
}

-(void)jfgOnRobotTransmitMsg:(JFGSDKRobotMessage *)message
{
    if (receiveMsg == nil) {
        receiveMsg = [NSString stringWithFormat:@"sn:%d---msg:%@\n",message.sn,message.msg];
    }
    receiveMsg = [receiveMsg stringByAppendingString:[NSString stringWithFormat:@"sn:%d---msg:%@\n",message.sn,message.msg]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
