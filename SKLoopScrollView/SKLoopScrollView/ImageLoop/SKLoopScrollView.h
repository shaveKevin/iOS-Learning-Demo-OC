//
//  SKLoopScrollView.m
//  SKLoopScrollView
//
//  Created by shavekevin on 16/7/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKLoopModel;

typedef void(^clickItemBlock)(SKLoopModel *);

@interface SKLoopScrollView : UIView

@property (nonatomic, strong) NSArray * arrayModal;
@property (nonatomic, copy) clickItemBlock mClickItemBlock;

- (void)start;

@end
