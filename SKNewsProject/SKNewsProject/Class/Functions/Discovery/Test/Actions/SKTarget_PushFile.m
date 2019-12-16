//
//  SKTarget_PushFile.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKTarget_PushFile.h"
#import "SKTestVC.h"
@implementation SKTarget_PushFile
- (UIViewController *)action_nativePushFileViewController:(NSDictionary *)params{
    SKTestVC *viewController = [[SKTestVC alloc] init];
    return viewController;
}
@end
