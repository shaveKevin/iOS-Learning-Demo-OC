//
//  SKBeautyENWordResult.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKBeautyENWordResult.h"
#import "SKBeautyENWordModel.h"

@implementation SKBeautyENWordResult


+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"dataArray" : @"showapi_res_body.data"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"dataArray" : [SKBeautyENWordModel class]
             };
}

@end
