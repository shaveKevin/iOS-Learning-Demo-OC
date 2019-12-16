//
//  SKDateFormatter.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKDateFormatter.h"

@implementation SKDateFormatter

+ (id)sharedDateManager {
    
    @synchronized(self) {
        static NSDateFormatter * sharedCMDateFormatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedCMDateFormatter = [[NSDateFormatter alloc] init];
            sharedCMDateFormatter.timeZone = [NSTimeZone systemTimeZone];
        });
        return sharedCMDateFormatter;
    }
}

@end
