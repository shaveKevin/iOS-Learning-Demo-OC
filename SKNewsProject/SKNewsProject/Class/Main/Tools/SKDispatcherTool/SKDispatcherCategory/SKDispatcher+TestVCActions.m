//
//  SKDispatcher+TestVCActions.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKDispatcher+TestVCActions.h"

//Target name
NSString * const kDispatcherTargetPushFile = @"PushFile";
//Action name
NSString * const kDispatcherActionNativePushFileViewController = @"nativePushFileViewController";

@implementation SKDispatcher (TestVCActions)



- (UIViewController *)dispatcher_viewControllerForPushFile:(NSDictionary *)params {
    
    //1.创建HomepageViewController
    UIViewController *viewController = [self performTarget:kDispatcherTargetPushFile
                                                    action:kDispatcherActionNativePushFileViewController
                                                    params:params];
    //2.交付view controller，由外界选择是push还是present
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
        //3.这里处理异常场景，具体如何处理取决于产品，这里返回空白controller
    } else {
        return [[UIViewController alloc] init];
    }
}
@end
