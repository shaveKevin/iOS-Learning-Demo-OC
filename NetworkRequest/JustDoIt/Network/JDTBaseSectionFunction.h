//
//  JDTBaseSectionFunction.h
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDTBasehttpRequest.h"
@interface JDTBaseSectionFunction : NSObject
@property (nonatomic, retain) JDTBasehttpRequest * requestManager;//请求管理者
@property (nonatomic, assign)NSInteger reloginCount;
@property (nonatomic, assign)BOOL needRelogin;
@end
