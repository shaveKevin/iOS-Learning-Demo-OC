//
//  SKDispatcher+TestVCActions.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKDispatcher.h"

@interface SKDispatcher (TestVCActions)
- (UIViewController *)dispatcher_viewControllerForPushFile:(NSDictionary *)params;

@end
