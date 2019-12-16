//
//  UIButton+ExpandHitPosition.m
//  UIButtonEdgeInset
//
//  Created by shavekevin on 2017/6/12.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "UIButton+ExpandHitPosition.h"
#import <objc/runtime.h>

@implementation UIButton (ExpandHitPosition)

void SKSwizzleMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SKSwizzleMethod([self class], @selector(pointInside:withEvent:), @selector(sk_pointInside:withEvent:));
    });
}

- (UIEdgeInsets)hitEdgeInsets {
    NSValue* value = objc_getAssociatedObject(self, _cmd);
    UIEdgeInsets insets = UIEdgeInsetsZero;
    [value getValue:&insets];
    return insets;
}

- (void)setHitEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue* value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(hitEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sk_pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    UIEdgeInsets insets = self.hitEdgeInsets;
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return [self sk_pointInside:point withEvent:event];
    } else {
        CGRect hitBounds = UIEdgeInsetsInsetRect(self.bounds, insets);
        return CGRectContainsPoint(hitBounds, point);
    }
}

@end
