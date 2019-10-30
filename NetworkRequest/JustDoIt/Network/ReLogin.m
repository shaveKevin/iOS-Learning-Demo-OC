//
//  ReLogin.m
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "ReLogin.h"

@implementation ReLogin
{
    void(^block_result)(BOOL result);

}
-(void)reloginResult:(void (^)(BOOL result))result{
    block_result = [result copy];
    [self relogin];
}
-(void)relogin{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //执行登陆操作
    });
}
@end
