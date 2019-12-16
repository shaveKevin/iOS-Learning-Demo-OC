//
//  SKDispatcher.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKDispatcher.h"
#import "SKJSONDicTransition.h"
NSString * const kDispatcherScheme = @"scheme";
NSString * const kDispatcherTarget = @"target";
NSString * const kDispatcherAction = @"action";
NSString * const kDispatcherTransformType = @"transformType";
NSString * const kDispatcherParams = @"params";

@implementation SKDispatcher

+ (instancetype)sharedInstance {
    
    static SKDispatcher *dispatcher;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatcher = [[SKDispatcher alloc] init];
    });
    return dispatcher;
}

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion {
    
    //1.异常处理
//    if (![url.scheme isEqualToString:kAppName]) {
//#warning 针对远程app调用简单处理了，可根据产品需求进行逻辑处理
//        return @(NO);
//    }
//    
    //2.获取url中的参数，保存到params中
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        //非参数string，count<2
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    //3.出于安全考虑，防止通过远程方式调用本地模块
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    //4.执行相应的action；对URL的路由处理非常简单，取对应的target名字和method名字
    id result = [self performTarget:url.host action:actionName params:params];
    
    //6.根据action执行结果，执行completion block
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performActionWithJson:(NSString *)json completion:(void (^)(NSDictionary *))completion {
//#warning 针对后台远程app调用，异常处理简单返回了@(NO)，但是可根据产品需求进行逻辑处理
    //1.异常处理
    //1.1如果json为nil，则返回nil
    id result = nil;
    if (json) {
        NSDictionary *dic = [SKJSONDicTransition jsonToDict:json];
        
        if (dic) {
            //1.2如果不是本app，则返回nil
//            if (![dic[kDispatcherScheme] isEqualToString:kAppName]) {
//                return result;
//            }
            
            //2.获取target，action，params
            NSString *targetName = dic[kDispatcherTarget];
            NSString *actionName = dic[kDispatcherAction];
            NSDictionary *params = dic[kDispatcherParams];
            
            //3.执行相应的action
            result = [self performTarget:targetName action:actionName params:params];
            
            //4.根据action执行结果，执行completion block
            if (completion) {
                if (result) {
                    completion(@{@"result":result});
                } else {
                    completion(nil);
                }
            }
        }
    }
    
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    
    //1.SKTarget_targetName：target类名；Action_actionName：对应target类中的action方法名
    NSString *targetClassString = [NSString stringWithFormat:@"SKTarget_%@", targetName];
    NSString *actionString = [NSString stringWithFormat:@"action_%@:", actionName];
    
    //2.根据target和对应的action进行处理
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionString);
    //2.1如果找不到对应的target则直接退出
    if (target == nil) {
//#warning 这里是处理无响应请求的地方之一，实际开发过程中可以事先给一个固定的target专门处理这种情况
        return nil;
    }
    //2.2如果存在对应的action，则执行performSelector
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    } else {
        //2.2.1处理无响应请求，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        } else {
            //2.2.2如果notFound都没有的时候，直接return
            return nil;
        }
    }
}


@end
