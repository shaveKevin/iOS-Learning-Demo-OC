//
//  GetListFuncation.m
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//
#import "GetListFuncation.h"
#import "JDTBasehttpRequest+GetList.h"
@implementation GetListFuncation 
-(BOOL)isInit{
    if (self.requestManager == nil) {
        return NO;
    }
    else{
        return YES;
    }
}
-(void)getList {
    if ([self isInit])
    {
        //先看缓存有没有
        NSString *result = @"";
        if (result != nil && [result isEqual:[NSNull null]] == NO) {
            //从数据库中取
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dealSuccessHisList:result];
            });
            
            return;
        }
        __weak GetListFuncation * weakSelf = self;
        [self.requestManager getListwithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSInteger resultCode = [[dict objectForKey:@"resultCode"]integerValue];
            if (resultCode != 1) {
                
               //从数据库中读取
                
            }else{
                
               //从网络中读取
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //从数据库中读取

           [weakSelf readHisListFromDbLongTime];
            
        }];
        
    }
    
}
- (void)dealSuccessHisList:(NSString *)hisList{
    NSError *error;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:[hisList dataUsingEncoding:NSUTF8StringEncoding  ] options:NSJSONReadingMutableContainers error:&error];
    //这个根据实际情况来解析
    //解析成数组
    NSArray *quanList = resultDic[@"quanList"];
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(DidGetListResult:andResultInfo:andError:)]){
        [self.delegate DidGetListResult:YES andResultInfo:quanList andError:error];
    }
}
- (void)readHisListFromDbLongTime {
    
}
@end
