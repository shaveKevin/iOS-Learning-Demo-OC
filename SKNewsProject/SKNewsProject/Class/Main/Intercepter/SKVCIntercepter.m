//
//  SKVCIntercepter.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKVCIntercepter.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
@implementation SKVCIntercepter

/**
 * + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵”
 */
+ (void)load {
    
    [super load];
//    [SKVCIntercepter sharedInstance];
}

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static SKVCIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SKVCIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //在这里做好方法拦截,原生函数执行完后再执行这里
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewWillAppear:animated viewController:[aspectInfo instance]];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewWillDisappear:animated viewController:[aspectInfo instance]];
        } error:NULL];
    }
    return self;
}

#pragma mark - fake methods
- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController {
    
    //1.你可以使用这个方法进行打日志，初始化基础业务相关的内容
//    debugLog(@"[%@ viewWillAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
    
    // 友盟统计之类的
}

- (void)viewWillDisappear:(BOOL)animated viewController:(UIViewController *)viewController {
    
    //1.你可以使用这个方法进行打日志，初始化基础业务相关的内容
//    debugLog(@"[%@ viewWillAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
    
}


@end
