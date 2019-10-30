//
//  JDTBasehttpRequest+GetList.m
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "JDTBasehttpRequest+GetList.h"

@implementation JDTBasehttpRequest (GetList)
- (void)getListwithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    [self POST:@"" parameters:nil success:success failure:failure];
    
    
}
@end
