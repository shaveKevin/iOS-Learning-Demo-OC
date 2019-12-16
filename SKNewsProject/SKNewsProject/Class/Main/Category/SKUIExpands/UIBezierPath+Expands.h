//
//  UIBezierPath+Expands.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/1/6.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Expands)
+ (UIBezierPath *)sk_bezierPathWithRoundedRect:(CGRect)rect cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius lineWidth:(CGFloat)lineWidth;
@end
