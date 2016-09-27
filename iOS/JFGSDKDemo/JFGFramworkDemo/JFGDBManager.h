//
//  JFGDBManager.h
//  FMDBTest
//
//  Created by 杨利 on 16/7/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "FMDTManager.h"
#import "DataPoints.h"
@interface JFGDBManager : FMDTManager

@property (nonatomic, strong, readonly) FMDTContext *dataPoint;

@end
