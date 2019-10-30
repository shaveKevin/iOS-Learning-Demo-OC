//
//  MenuListItem.h
//  SKPopverListView
//
//  Created by shavekevin on 15/12/24.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MenuListItem : NSObject
/**
 *  this is a model  class  这是一个model类
 *
 *  @param title   标题
 *  @param image   图片
 *
 *  @param selectIndex  当前item 的index
 */
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)UIImage *image;
@property(nonatomic, assign)NSInteger selectIndex;

@end
