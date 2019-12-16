//
//  NSDate+GetTimeStampMethods.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GetTimeStampMethods)
/**
 * 获取当前时间
 */
+ (NSString *)getCurrentTime;

/**
 *  返回当前时间戳string
 */
+ (NSString *)getTimeStamp;

/**
 *  根据时间戳返回随机数string
 */
+ (NSString *)getTimeRandom;

@end
