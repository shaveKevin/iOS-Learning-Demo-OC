//
//  UIImage+Expands.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/1/6.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Expands)
+ (UIImage *)sk_imageWithStrokeColor:(UIColor *)strokeColor size:(CGSize)size path:(UIBezierPath *)path addClip:(BOOL)addClip;
+ (UIImage *)skui_imageWithColor:(UIColor *)color;
+ (UIImage *)skui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)skui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius;

/**
 生成当前vc的view

 @param view curreentView
 @return UIImage
 */
+ (UIImage *)sk_imageWithView:(UIView *)view;
/**
 对传进来的 `UIView` 截图，生成一个 `UIImage` 并返回
 
 @param view         要截图的 `UIView`
 @param afterUpdates 是否要在界面更新完成后才截图
 
 @return `UIView` 的截图
 */
+ (UIImage *)sk_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates;

@end

