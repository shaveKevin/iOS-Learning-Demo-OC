//
//  SKResult.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SKResult : NSObject

/*
 * 自动化解析所有json数据
 */
+ (instancetype)parseTotalJson:(NSDictionary *)jsDic;


@property (nonatomic, copy) NSDictionary *resultDic;

@end
