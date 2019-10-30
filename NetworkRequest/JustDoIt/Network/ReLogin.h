//
//  ReLogin.h
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReLogin : NSObject
-(void)reloginResult:(void (^)(BOOL result))result;

@end
