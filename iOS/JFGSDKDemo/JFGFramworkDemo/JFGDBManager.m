//
//  JFGDBManager.m
//  FMDBTest
//
//  Created by 杨利 on 16/7/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "JFGDBManager.h"

@implementation JFGDBManager

-(FMDTContext *)dataPoint
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    path = [path stringByAppendingPathComponent:@"com.dataPoint.db"];
    NSLog(@"%@",path);
    return [self cacheWithClass:[DataPoints class] dbPath:path];
}

@end
