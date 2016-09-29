//
//  version.h
//  JFGSDK
//
//  Created by yangli on 16/8/11.
//  Copyright © 2016年 yangli. All rights reserved.
//
#define JFGSDKVersion @"3.0.7"

/**
 
 3.0.2
 1.添加设备、App消息同步回调
 2.修复DataPoint回调，block为nil时可能崩溃问题
 3.绑定设备sn类型检测，增加成功回调，成功返回被绑定设备cid
 
 3.0.3
 1.优化数据库数据获取
 
 3.0.4
 1.数据库使用事务
 2.添加修改密码等操作
 3.添加文件上传云
 
 3.0.5
 1.添加好友相关接口
 2.优化数据库访问方式（使用JKDBModel）
 
 3.0.6
 1.所有的消息添加SEQ字段
 2.添加setAcount相关属性设置
 3.密码加密处理
 
 3.0.7
 1.优化视频相关内容
 2.删除JFGSDKPlayVideo类，使用JFGSDKVideoView替换
 3.添加配置sdk服务器地址功能
 
 */