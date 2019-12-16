//
//  SKYYResult.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKYYResult.h"

@implementation SKYYResult

- (NSDictionary *)showapi_res_body {
    
    if ([[self.resultDic valueForKey:@"showapi_res_body"] isKindOfClass:[NSDictionary class]]) {
        return [self.resultDic valueForKey:@"showapi_res_body"];
    }
    return nil;
}

- (NSString *)showapi_res_code {
    return [self.resultDic valueForKey:@"showapi_res_code"];

}
-(NSString *)showapi_res_error {
    return [self.resultDic valueForKey:@"showapi_res_error"];

}
@end
