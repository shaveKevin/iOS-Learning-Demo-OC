//
//  NSDate+GetTimeStampMethods.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "NSDate+GetTimeStampMethods.h"
#import "NSString+MD5Methods.h"
@implementation NSDate (GetTimeStampMethods)
/// 获取当前时间 .
+ (NSString *)getCurrentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    return timeStr;
}

+ (NSString *)getTimeStamp {
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    NSString *timeStamp = [NSString stringWithFormat:@"%llu", dTime];
    return timeStamp;
}

+ (NSString *)getTimeRandom {
    int random = arc4random()%100;
    NSString *randomStr = [NSString stringWithFormat:@"%@%d", [self getTimeStamp], random];
    NSString *md5RadomStr = [NSString md5EncryptWithString:randomStr];
    return md5RadomStr;
}

@end
