//
//  JDTBaseSectionFunction.m
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "JDTBaseSectionFunction.h"

@implementation JDTBaseSectionFunction
-(id)init{
    if(self = [super init]){
        [self initRequest];
        _reloginCount = 1;
        _needRelogin = YES;
    }
    return self;
}

//生成网络请求
- (void)initRequest
{
    self.requestManager = [[JDTBasehttpRequest alloc]init];
    
    self.requestManager.userInfo = self;
}

@end
