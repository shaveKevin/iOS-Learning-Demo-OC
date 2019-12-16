//
//  SKJSONDicTransition.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKJSONDicTransition : NSObject

/**
 string to dict

 @param dict dict
 @return string
 */
+ (NSString *)dictToJson:(NSDictionary *)dict;

/**
 json to dict

 @param json json
 @return dict
 */
+ (NSDictionary *)jsonToDict:(NSString *)json;

@end
