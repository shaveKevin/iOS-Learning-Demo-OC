//
//  SKMacro.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#ifndef SKMacro_h
#define SKMacro_h
#import "SKAppDelegate.h"

//当前系统名称
#define kOSVersion [UIDevice currentDevice].systemName

//是不是模拟器.
#define IS_SIMULATOR        ( [DataManager hardware]==SIMULATOR )
/// 是不是ipad.
#define IS_IPAD (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
///是不是iphone.
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)

#define IS_SCREEN_HEIGHT_EQUAL(SCREEN_HEIGHT_VALUE) (MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width)==SCREEN_HEIGHT_VALUE)
/// 是否是5系列iphone 5 + 5_c + 5_s + SE.
#define IS_IPHONE_5         ( IS_IPHONE && IS_SCREEN_HEIGHT_EQUAL(568.0) )
/// 是否是6 7 系列iPhone 6 + 6_S + 7.
#define IS_IPHONE_6         ( IS_IPHONE && IS_SCREEN_HEIGHT_EQUAL(667.0))
/// 是否是6 7 系列iPhone 6_PLUS + 6_S_PLUS + 7_PLUS.
#define IS_IPHONE_6_PLUS    ( IS_IPHONE && IS_SCREEN_HEIGHT_EQUAL(736.0))
#define kSKAppDelegate   (SKAppDelegate *)[[UIApplication sharedApplication] delegate]


//系统信息 名称和版本
#define kDeviceSystemInfo [NSString stringWithFormat:@"%@%@",kOSVersion,[UIDevice currentDevice].systemVersion]

//是否为iOS7以上版本
#define kIOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//是否为iOS8以上版本
#define kIOS8x ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

//是否为iOS9以上版本
#define kIOS9x ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

//是否为iOS10以上版本
#define kIOS10x ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)

//======================== 屏幕宽高 ========================
#define Device_WIDTH     [UIScreen mainScreen].bounds.size.width
#define Device_HEIGH     [UIScreen mainScreen].bounds.size.height

/// 全栈字体缩放因子.
#define kSKApplicationFontFactor     [kSKAppDelegate FontFactor]

/// 正常缩放字体.
#define Font_Hei(a)           [UIFont systemFontOfSize:(kSKApplicationFontFactor*a)]
#define Font_blodHei(a)             [UIFont boldSystemFontOfSize:(kSKApplicationFontFactor*a)]

//======================== 色值 ========================
/// 通用RGB .
#define kCommonRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/// 通过RGB 可以设置alpha .
#define kCommonRGBAColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#endif /* SKMacro_h */
