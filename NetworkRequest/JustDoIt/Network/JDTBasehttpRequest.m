//
//  JDTBasehttpRequest.m
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "JDTBasehttpRequest.h"
#import "ReLogin.h"
NSUInteger g_timeoutInterval = 30;  //超时时间,秒
@implementation JDTBasehttpRequest{
    //是否需要重新登陆
    ReLogin *m_login;
    NSInteger m_postFlag;
    
    NSString *m_url;
    id m_parameter;
    id m_responseObject;
    AFHTTPRequestOperation *m_operation;
    
    void(^block_success)(AFHTTPRequestOperation *operation, id responseObject);
    void(^block_failure)(AFHTTPRequestOperation *operation, NSError *error);
    void(^block_block)(id <AFMultipartFormData> formData);
    BOOL m_needLogin;

}

- (AFHTTPRequestOperationManager *)getManager{
    static AFHTTPRequestOperationManager *g_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_manager = [AFHTTPRequestOperationManager manager];
        g_manager.responseSerializer = [AFHTTPResponseSerializer serializer];    //加上这个是为了让返回的数据是二进制模式
        g_manager.requestSerializer.timeoutInterval = g_timeoutInterval;
        g_manager.operationQueue.maxConcurrentOperationCount = 10;
    });
    
    return g_manager;
}

-(AFHTTPRequestOperation *)redo{
    //
    if (m_postFlag == 1) {
        return [self POST:m_url parameters:m_parameter success:block_success failure:block_failure];
    }
    else {
        return [self POST:m_url parameters:m_parameter constructingBodyWithBlock:block_block success:block_success failure:block_failure];
    }
}
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    m_postFlag = 1;
    NSString *log = [NSString stringWithFormat:@"发送:%@",URLString];
    NSLog(@"%@?%@",log,parameters);
    //    self.requestSerializer.timeoutInterval = g_timeoutInterval;
    [[self getManager].requestSerializer setValue:@"xxxxx" forHTTPHeaderField:@"Referer"];
    return [[self getManager] POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *Return = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (Return == nil || [Return isEqual:[NSNull null]]) {
            //汉字转码
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            Return = [[NSString alloc] initWithData:responseObject encoding:enc];
        }
        NSString *log = [NSString stringWithFormat:@"返回:%@",Return];
        //判断是否需要重新登录
        @try {
           ////
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        NSLog(@"%@",log);
        if(success){
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *log = [NSString stringWithFormat:@"返回错误:"];
        if(error){
            NSString *descripe = error.description;
            log = [log stringByAppendingString:descripe];
        }else{
            log = [log stringByAppendingString:@"未知错误"];
        }
        
        NSLog(@"%@",log);
        if(failure){
            failure(operation,error);
        }
    }];
}



- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    m_postFlag = 2;
    NSString *log = [NSString stringWithFormat:@"发送:%@",URLString];
    NSLog(@"%@?%@",log,parameters);
    [[self getManager].requestSerializer setValue:@"xxxx" forHTTPHeaderField:@"Referer"];

    return [[self getManager] POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *Return = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *log = [NSString stringWithFormat:@"返回:%@",Return];
        NSLog(@"%@",log);
        @try {
           //
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
        if(success){
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *log = [NSString stringWithFormat:@"返回错误:"];
        if(error){
            NSString *descripe = error.description;
            log = [log stringByAppendingString:descripe];
        }else{
            log = [log stringByAppendingString:@"未知错误"];
        }
        
        NSLog(@"%@",log);
        if(failure){
            failure(operation,error);
        }
    }];
}


-(void)relogin{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [m_login reloginResult:^(BOOL result) {
            if (result == NO) {
                block_success(m_operation,m_responseObject);
            }else{
                [self redo];
            }
        }];
    });
}

@end
