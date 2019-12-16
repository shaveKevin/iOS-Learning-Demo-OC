//
//  SKNetWorkRequest.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKNetWorkRequest.h"
@class SKResult;
@interface SKNetWorkRequest : SKNetworkBaseRequest
///data.
@property (nonatomic, strong) SKResult * result;

/**
 * 是否忽略缓存
 */
@property (nonatomic, assign) BOOL ignoreCache;

/**
 * 重载 数据模型
 */
- (Class)jsonModelClass:(NSDictionary *)dictResult;
/**
 * 重载 缓存数据
 */
- (void)cacheResult;
@end
