//
//  GetListFuncation.h
//  JustDoIt
//
//  Created by shaveKevin on 15/9/2.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDTBaseSectionFunction.h"
@protocol ListDelegate <NSObject>
@optional
//获取班级列表回调
-(void)DidGetListResult:(BOOL)result andResultInfo:(NSArray *)resultInfoArray andError:(NSError *)error;
@end


@interface GetListFuncation : JDTBaseSectionFunction<ListDelegate>
@property (nonatomic,weak) id<ListDelegate> delegate;
//获取班级列表
-(void)getList;
@end
