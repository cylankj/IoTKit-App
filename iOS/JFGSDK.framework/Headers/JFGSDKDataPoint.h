//
//  JFGSDKDataPoint.h
//  JFGSDK
//
//  Created by 杨利 on 16/7/18.
//  Copyright © 2016年 yangli. All rights reserved.
//  cylan dpID define  https://github.com/cylankj/IoTKit-MsgDefine/blob/master/msgDefine/atomic_define.md

#import <Foundation/Foundation.h>
#import "JFGSDKDataPointModel.h"
#import "MPMessagePackReader.h"
#import "MPMessagePackWriter.h"
#import "NSArray+MPMessagePack.h"
#import "NSData+MPMessagePack.h"
#import "NSDictionary+MPMessagePack.h"

//dp 错误类型
typedef NS_ENUM (NSInteger,RobotDataRequestErrorType){
    RobotDataRequestErrorTypeTimeout,//超时
    RobotDataRequestErrorTypeRequestFailed,//函数调用失败(网络断开，sdk初始化失败，...)
};

//dp 获取数据请求成功回调block
typedef void (^RobotGetDataRspBlock)(NSString *identity,NSArray <NSArray  <DataPointSeg *>*>*idDataList);

//dp 设置设备请求成功回调block
typedef void (^RobotSetDataRspBlock)(NSArray <DataPointIDVerRetSeg*> *dataList);

//dp 查询未读数回调
typedef void (^RobotCountDataRspBlock)(NSString *identity, NSArray <DataPointCountSeg *> *dataList);

//dp 删除消息回调
typedef void (^RobotDelDataRspBlock)(NSString *identity,int ret);

//dp 请求超时回调
typedef void (^RobotDataFailedBlock)(RobotDataRequestErrorType type);



/**
 *  DataPoint API接口类
 */
@interface JFGSDKDataPoint : NSObject

/**
 *  获取单例对象
 *
 *  @return 对象
 */
+(instancetype)sharedClient;

/**
 *  移除block回调
 *
 *  @param reps 请求标示码集合
 */
-(void)removeBlockForReps:(NSArray <NSNumber *>*)reps;

/**
 *  设置设备DataPoint
 *
 *  @param peer        设备标示（cid）
 *  @param dps         设置参数
 *  @param block       设置请求回调
 *  @param failedBlock 设置失败回调
 *  note   (msgID < 100) 会被过滤
 *  @return 请求标示码，可以用于取消block,防止引用导致引用计数问题
 */
-(NSNumber *)robotSetDataWithPeer:(NSString *)peer
                              dps:(NSArray <DataPointSeg *>*)dps
                          success:(RobotSetDataRspBlock)block
                          failure:(RobotDataFailedBlock)failedBlock;

/**
 *  获取某些消息id的最新一条数据
 *
 *  @param peer        设备标识
 *  @param idList      消息id列表
 *  @param block       成功回调
 *  @param failedBlock 失败回调
 *
 *  @return 请求标示码，可以用于取消block,释放本类对对象的引用
 */
-(NSNumber *)robotGetSingleDataWithPeer:(NSString *)peer
                           msgIds:(NSArray <NSNumber *>*)idList
                          success:(RobotGetDataRspBlock)block
                          failure:(RobotDataFailedBlock)failedBlock;


/**
 *  获取某些消息id的多条数据
 *
 *  @param peer 对端标识
 *  @param idList 查询的datapoint列表
 *  @param limit 返回记录条数，范围是[1, 100]
 *  @param asc 是否按照时间倒叙
 *  @return 返回请求序列号
 *  提示：例如 ：asc为NO，则从服务器查找对应DataPointIDVerSeg中消息id为msgID，以数据产生时间戳version为数据起始点，倒叙的limit条数据。
 */
-(NSNumber *)robotGetDataWithPeer:(NSString *)peer
                           msgIds:(NSArray <DataPointIDVerSeg *> *)idList
                              asc:(BOOL)asc
                            limit:(int)limit
                          success:(RobotGetDataRspBlock)block
                          failure:(RobotDataFailedBlock)failedBlock;

/**
 *  混合查询
 *
 *  @param peer        同上
 *  @param version     数据开始时间戳
 *  @param dpids       dp数组
 *  @param asc         同上
 *  @param block       成功回调
 *  @param failedBlock 失败回调
 *
 *  @return 同上
 */
-(NSNumber *)robotGetDataEx:(NSString *)peer
                    version:(uint64_t)version
                      dpids:(NSArray <NSNumber *> *)dpids
                        asc:(BOOL)asc
                    success:(RobotGetDataRspBlock)block
                    failure:(RobotDataFailedBlock)failedBlock;


/**
 *  获取datapoint本地缓存数据
 *
 *  @param peer   设备标示
 *  @param idList 查询的datapoint列表
 *  @param asc    是否按照时间倒叙
 *  @param limit  每个消息id返回记录条数
 *  @param block  数据回调
 */
-(void)robotGetDataForCacheWithPeer:(NSString *)peer
                             msgIds:(NSArray <DataPointIDVerSeg *> *)idList
                                asc:(BOOL)asc
                              limit:(int)limit
                             success:(RobotGetDataRspBlock)block;


/**
 *  删除dp消息
 *
 *  @param peer        同上
 *  @param queryDps    DataPointIDVerSeg中version为0，则删除所有
 *  @param block       同上
 *  @param failedBlock 同上
 *
 *  @return 同上
 */
-(NSNumber *)robotDelDataWithPeer:(NSString *)peer
                         queryDps:(NSArray <DataPointIDVerSeg *> *)queryDps
                          success:(RobotDelDataRspBlock)block
                          failure:(RobotDataFailedBlock)failedBlock;

/**
 *  未读消息数
 *
 *  @param peer        同上
 *  @param dpids       dp消息id集合
 *  @param block       同上
 *  @param failedBlock 同上
 *
 *  @return 同上
 */
-(NSNumber *)robotCountDataWithPeer:(NSString *)peer
                              dpIDs:(NSArray <NSNumber *> *)dpids
                            success:(RobotCountDataRspBlock)block
                            failure:(RobotDataFailedBlock)failedBlock;

/**
 *  清空dp未读消息
 *
 *  @param peer        同上
 *  @param dpids       同上
 *  @param block       同上（返回相应id对象，对应ret属性值为0，则清空成功）
 *  @param failedBlock 同上
 *
 *  @return 同上
 */
-(NSNumber *)robotCountDataClear:(NSString *)peer
                           dpIDs:(NSArray <NSNumber *> *)dpids
                         success:(RobotSetDataRspBlock)block
                         failure:(RobotDataFailedBlock)failedBlock;
@end
