//
//  UIImage+Expands.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/1/6.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "UIImage+Expands.h"
#import "UIBezierPath+Expands.h"
#define ScreenScale ([[UIScreen mainScreen] scale])

@implementation UIImage (Expands)

+ (UIImage *)sk_imageWithStrokeColor:(UIColor *)strokeColor size:(CGSize)size path:(UIBezierPath *)path addClip:(BOOL)addClip {
    size = CGSizeMake(flatf(size.width), flatf(size.height));
    [UIImage inspectContextSize:(size)];
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIImage inspectContextIfInvalidatedInDebugMode:context];
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    if (addClip) [path addClip];
    [path stroke];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)skui_imageWithColor:(UIColor *)color {
    return [UIImage skui_imageWithColor:color size:CGSizeMake(4, 4) cornerRadius:0];
}

+ (UIImage *)skui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    size = CGSizeMake(flatf(size.width), flatf(size.height));
    [UIImage inspectContextSize:(size)];
    
    UIImage *resultImage = nil;
    color = color ? color : [UIColor whiteColor];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMakeWithSize(size)  cornerRadius:cornerRadius];
        [path addClip];
        [path fill];
    } else {
        CGContextFillRect(context, CGRectMakeWithSize(size));
    }
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)skui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius {
    size = CGSizeFlatted(size);
    [UIImage inspectContextSize:(size)];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
 [UIImage inspectContextIfInvalidatedInDebugMode:context];
    color = color ? color : [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    UIBezierPath *path = [UIBezierPath sk_bezierPathWithRoundedRect:CGRectMakeWithSize(size) cornerRadiusArray:cornerRadius lineWidth:0];
    [path addClip];
    [path fill];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 NSAssert

 @param size if  size->width || size->height < 0
 */
+ (void)inspectContextSize:(CGSize)size {
    if (size.width < 0 || size.height < 0) {
        NSAssert(NO, @"skUI CGPostError, %@:%d %s, 非法的size：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, NSStringFromCGSize(size), [NSThread callStackSymbols]);
    }
}

/**
 <#Description#>

 @param context <#context description#>
 */
+ (void)inspectContextIfInvalidatedInDebugMode:(CGContextRef)context {
    if (!context) {
        // crash了就找zhoon或者molice
        NSAssert(NO, @"skUI CGPostError, %@:%d %s, 非法的context：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, context, [NSThread callStackSymbols]);
    }

}
/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE float
flatfSpecificScale(float floatValue, float scale) {
    scale = scale == 0 ? ScreenScale : scale;
    CGFloat flattedValue = ceilf(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flatf() 函数。
 */
CG_INLINE float
flatf(float floatValue) {
    return flatfSpecificScale(floatValue, 0);
}

/// 传入size，返回一个x/y为0的CGRect
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

/// 将一个CGSize像素对齐
CG_INLINE CGSize
CGSizeFlatted(CGSize size) {
    return CGSizeMake(flatf(size.width), flatf(size.height));
}

+ (UIImage *)sk_imageWithView:(UIView *)view {
    [UIImage inspectContextSize:(view.frame.size)];
    // 老方式，因为drawViewHierarchyInRect:afterScreenUpdates:有一定的使用条件，有些情况下不一定截得到图，所有这种情况下可以使用老方式。
    // 如果可以用新方式，则建议使用新方式，性能上好很多
    UIImage *resultImage = nil;
    // 第二个参数是不透明度，这里默认设置为YES，不用出来alpha通道的事情，可以提高性能
    // 第三个参数是scale，设置为0的时候，意思是使用屏幕的scale
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIImage inspectContextIfInvalidatedInDebugMode:context];
    [view.layer renderInContext:context];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+ (UIImage *)sk_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates {
    // iOS7截图新方式，性能好会好一点，不过不一定适用，因为这个方法的使用条件是：界面要已经render完，否则截到得图将会是empty。
    // 如果是iOS6调用这个接口，将会使用老的方式。
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIImage *resultImage = nil;
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
        [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) afterScreenUpdates:afterUpdates];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    } else {
        return [self sk_imageWithView:view];
    }
}

@end
