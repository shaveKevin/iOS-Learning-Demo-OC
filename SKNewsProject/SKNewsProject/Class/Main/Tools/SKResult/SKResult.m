//
//  SKResult.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKResult.h"
#import "YYModel.h"


@implementation SKResult

/// 解析所有json数据
+ (instancetype)parseTotalJson:(NSDictionary *)jsDic{

    NSDictionary *responseData = jsDic;
    SKResult *result = [[self class] parseSubJson:responseData];
    if(!result) {
        result = [SKResult new];
    }
    return result;
}

/// 解析 json数据
+ (instancetype)parseSubJson:(NSDictionary *)jsDic {
    
    SKResult *result = [[self class] yy_modelWithDictionary:jsDic];
    result.resultDic = jsDic;
    return result;
}
@end
