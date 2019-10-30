//
//  SKUILabel.h
//  AllTextLabel
//
//  Created by shavekevin on 16/7/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//
/**
 *  @brief UILabel 基类
 *
 *  @param nonatomic 设置行间距和字间距
 *  @param assign    info  可以用来传值
 *
 *  @return UILabel ALUILabel
 */

#import <UIKit/UIKit.h>

@interface SKUILabel : UILabel
/**
 *  @brief info
 */
@property (nonatomic, assign) id info;

/**
 *  @brief 设置行间距
 *
 *  @param text      text
 *  @param lineSpace 行间距
 */
-(void)setText:(NSString *)text andlineSpace:(CGFloat)lineSpace;
/**
 *  @brief 设置行间距和字间距
 *
 *  @param text      文本
 *  @param lineSpace 行间距
 *  @param wordSpace 字间距
 */

-(void)setText:(NSString *)text andlineSpace:(CGFloat)lineSpace andWordSpace:(CGFloat)wordSpace;
/**
 *  @brief 设置副本文行间距和字间距
 *
 *  @param attText     富文本
 *  @param lineSpace   行间距
 *  @param numberSpace 字间距
 */
- (void)setAttText:(NSAttributedString *)attText lineSpace:(CGFloat)lineSpace numberSpace:(CGFloat)numberSpace;


@end
