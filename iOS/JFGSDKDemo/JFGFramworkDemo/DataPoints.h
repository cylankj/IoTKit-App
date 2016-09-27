//
//  DataPoints.h
//  FMDBTest
//
//  Created by 杨利 on 16/7/5.
//  Copyright © 2016年 yangli. All rights reserved.
//


#import "FMDTObject.h"

@interface DataPoints : FMDTObject

@property (nonatomic,assign)int msgID;

@property (nonatomic,assign)int64_t timeStamp;

@property (nonatomic,strong)id values;

@end
