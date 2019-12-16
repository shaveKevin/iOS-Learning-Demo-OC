//
//  SKDispatcherManager.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKDispatcherManager.h"
#import "SKJSONDicTransition.h"
#import "SKUINavigationController.h"

@implementation SKDispatcherManager

typedef NS_ENUM (NSUInteger, DispatchTransformType) {
    DispatchTransformTypePush = 0,//ViewController push进来
    DispatchTransformTypePresent = 1,//ViewController present进来
    DispatchTransformTypeNo = 2,//只是执行Native某个操作，而没有UI动作
    DispatchTransformTypeDefault = DispatchTransformTypePush
};

+ (id)dispatcherFromRemote:(NSString *)json parent:(id)parent completion:(void (^)(NSDictionary *))completion {
    
    id result = nil;
    if (json) {
        NSDictionary *dic = [SKJSONDicTransition jsonToDict:json];
        if (dic) {
            NSInteger transformType = ((NSString *)dic[kDispatcherTransformType]).integerValue;
            switch (transformType) {
                case DispatchTransformTypePush:
                    [self dispatcherWithPush:json parent:parent completion:completion];
                    break;
                case DispatchTransformTypePresent:
                    [self dispatcherWithPresent:json parent:parent completion:completion];
                    break;
                case DispatchTransformTypeNo:
                    result = [self dispatcherWithNo:json completion:completion];
                    break;
                    
                default:
                    [self dispatcherWithPush:json parent:parent completion:completion];
                    break;
            }
        }
    }
    return result;
}

+ (void)dispatcherWithPush:(NSString *)json parent:(id)parent completion:(void (^)(NSDictionary *))completion {
    
    if (parent && json) {
        UIViewController *targetVC = [[SKDispatcher sharedInstance] performActionWithJson:json completion:completion];
        if (targetVC && [targetVC isKindOfClass:[UIViewController class]]) {
            [(SKUINavigationController *)parent pushViewController:targetVC animated:YES];
        }
    }
}

+ (void)dispatcherWithPresent:(NSString *)json parent:(id)parent completion:(void (^)(NSDictionary *))completion{
    
    if (parent && json) {
        UIViewController *targetVC = [[SKDispatcher sharedInstance] performActionWithJson:json completion:completion];
        if (targetVC && [targetVC isKindOfClass:[UIViewController class]]) {
            [(UIViewController *)parent presentViewController:targetVC animated:YES completion:nil];
        }
    }
}

+ (id)dispatcherWithNo:(NSString *)json completion:(void (^)(NSDictionary *))completion {
    
    id result = nil;
    if (json) {
        result = [[SKDispatcher sharedInstance] performActionWithJson:json completion:completion];
    }
    return result;
}

@end
