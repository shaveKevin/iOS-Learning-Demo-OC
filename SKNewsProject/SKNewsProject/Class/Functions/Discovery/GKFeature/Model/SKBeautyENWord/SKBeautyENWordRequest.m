//
//  SKBeautyENWordRequest.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKBeautyENWordRequest.h"
#import "SKBeautyENWordResult.h"

static NSString *const nesListAPI = @"http://route.showapi.com/1211-1";

@interface SKBeautyENWordRequest ()

@property (nonatomic, strong) SKBeautyENWordRequest *request;
@end

@implementation SKBeautyENWordRequest


- (id)requestArgument {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:YYAPIID forKey:@"showapi_appid"];
    [dic setValue:YYAPISECRET forKey:@"showapi_sign"];
    NSDateFormatter *fomatter = [SKDateFormatter sharedDateManager];
    [fomatter setDateFormat:@"yyyyMMddHHmmss"];
    [dic setValue:[fomatter stringFromDate:[NSDate date]] forKey:@"showapi_timestamp"];
    [dic setValue:@"10" forKey:@"count"];
//    [dic setValue:@"1" forKey:@"showapi_sign_method"];
//    [dic setValue:@"1" forKey:@"showapi_res_gzip"];
    
    return dic;
    
}

/// 数据模型类
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    return [SKBeautyENWordResult class];
}

// 接口
- (NSString *)requestUrl {
    return nesListAPI;
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

- (void)requestBeautyENWord {
    
    if ([self.request  isExecuting]) {
        [self.request stop];
        self.request = nil;
    }
    [self.request startCompletionBlockWithProgress:^(NSProgress *progress) {
        //
    } success:^(SKNetworkBaseRequest *request) {
        //
        SKBeautyENWordRequest *betRequest = (SKBeautyENWordRequest *)request;
        SKBeautyENWordResult *result = (SKBeautyENWordResult *)betRequest.result;
        if (self.beautyENWordRequestDelegate && [self.delegate respondsToSelector:@selector(beautyENWordRequestSuccess:)]) {
            [self.beautyENWordRequestDelegate beautyENWordRequestSuccess:result.dataArray];
        }
       
    } failure:^(SKNetworkBaseRequest *request) {
        if (self.beautyENWordRequestDelegate&&[self.beautyENWordRequestDelegate respondsToSelector:@selector(beautyENWordRequestFailed:)]) {
            [self.beautyENWordRequestDelegate beautyENWordRequestFailed:request.userInfo];
        }
    }];
}

- (SKBeautyENWordRequest *)request {
    if (!_request) {
        _request = [[SKBeautyENWordRequest alloc]init];
    }
    return _request;
}

@end
