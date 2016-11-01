//
//  DataPointModel.h
//  JFGSDK
//
//  Created by 杨利 on 16/7/6.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPointSeg : NSObject

@property (nonatomic,assign)uint64_t msgId;
@property (nonatomic,assign)int64_t version;//数据产生对应时间戳
@property (nonatomic,strong)NSData *value;//使用msgpack打包后的数据

@end


@interface DataPointIDVerRetSeg : NSObject

@property (nonatomic,assign)uint64_t msgId;
@property (nonatomic,assign)int64_t version;//数据产生对应时间戳
@property (nonatomic,assign)int ret;

@end

@interface DataPointIDVerSeg : NSObject

@property (nonatomic,assign)uint64_t msgId;
@property (nonatomic,assign)int64_t version;// 数据产生对应时间戳

@end

@interface DataPointCountSeg : NSObject

@property (nonatomic,assign)uint64_t msgId;
@property (nonatomic,assign)int count;

@end