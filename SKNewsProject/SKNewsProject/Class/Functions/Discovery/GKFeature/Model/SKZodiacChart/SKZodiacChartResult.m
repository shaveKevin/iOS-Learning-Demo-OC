//
//  SKZodiacChartResult.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/15.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKZodiacChartResult.h"
#import "SKZodiacChartModel.h"
@implementation SKZodiacChartResult

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"model" : @"showapi_res_body"
             };
}
@end
