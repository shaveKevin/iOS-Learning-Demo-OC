//
//  SKBeautyENWordRequest.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKNetWorkRequest.h"
// 英文优美句子清酒
@class  SKBeautyENWordModel;

@protocol BeautyENWordRequestDelegate <NSObject>
/* request success**/
- (void)beautyENWordRequestSuccess:(NSArray<SKBeautyENWordModel *> *)dataArray;
/// request failed
- (void)beautyENWordRequestFailed:(NSDictionary *)userInfo;

@end
@interface SKBeautyENWordRequest : SKNetWorkRequest

@property (nonatomic, assign) id<BeautyENWordRequestDelegate> beautyENWordRequestDelegate;

- (void)requestBeautyENWord;

@end
