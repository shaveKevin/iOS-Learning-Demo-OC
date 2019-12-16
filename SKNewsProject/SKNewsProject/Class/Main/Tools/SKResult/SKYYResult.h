//
//  SKYYResult.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKResult.h"

@interface SKYYResult : SKResult

@property (nonatomic, copy) NSDictionary *showapi_res_body;

@property (nonatomic, copy) NSString *showapi_res_error;

@property (nonatomic, copy) NSString *showapi_res_code;

//@property (nonatomic, copy) NSString *ret_message;
//@property (nonatomic, copy) NSString *ret_code;

@end
