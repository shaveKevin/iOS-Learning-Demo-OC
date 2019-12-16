//
//  SKZodiacChartRequest.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/15.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKZodiacChartRequest.h"
#import "SKZodiacChartResult.h"

static NSString *const zodiacChartAPI = @"http://route.showapi.com/856-1";

@implementation SKZodiacChartRequest



- (id)requestArgument {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:YYAPIID forKey:@"showapi_appid"];
    [dic setValue:YYAPISECRET forKey:@"showapi_sign"];
    NSDateFormatter *fomatter = [SKDateFormatter sharedDateManager];
    [fomatter setDateFormat:@"yyyyMMddHHmmss"];
    [dic setValue:[fomatter stringFromDate:[NSDate date]] forKey:@"showapi_timestamp"];
    //    [dic setValue:@"1" forKey:@"showapi_sign_method"];
    //    [dic setValue:@"1" forKey:@"showapi_res_gzip"];
    // 某天黄历，日期格式yyyyMMdd 20150423 optional
//    [dic setValue:self.searchDate forKey:@"date"];

    return dic;
    
}

/// 数据模型类
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    return [SKZodiacChartResult class];
}

// 接口
- (NSString *)requestUrl {
    return zodiacChartAPI;
}


//// 方法
//- (ALRequestMethod)requestMethod
//{
//    return SKRequestMethodPost;
//}
///// post解析.
//- (ALRequestSerializerType)requestSerializerType
//{
//    return SKRequestSerializerTypeJSON;
//}
// 方法
- (SKRequestMethod)requestMethod {
    return SKRequestMethodGet;
}
@end
