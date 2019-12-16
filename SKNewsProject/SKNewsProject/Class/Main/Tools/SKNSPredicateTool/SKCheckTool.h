//
//  SKCheckTool.h
//  NSPredicateDemo
//
//  Created by shavekevin on 16/4/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKCheckTool : NSObject

/**
 *  判断输入的密码是否合法
 *
 *  @param password password
 *  @param num      num
 *
 *  @return valid or not
 */
+ (BOOL)isValidatePassWrod:(NSString *)password num:(int)num;

/**
 *  判断邮箱是否合法
 *  checkout email valid or not
 *
 *   email
 *
 *  @return  valid or not
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  判断手机号是否合法
 *  checkout phonenumber valid or not
 *
 *  @param mobile phonenumber
 *
 *  @return  valid or not
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;


/**
 *  判断字符串是否为空
 *
 *  @param string targetStr
 *
 *  @return empty or not
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  判断是否汉字与英文
 *
 *  @param str targetStr
 *
 *  @return targetStr
 */
+(BOOL)checkIsChineseAndEnglish:(NSString *)str;

/**
 *  判断是否数字与英文
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkIsNumberAndIsEnglist:(NSString *)str;

/**
 *  实现输入框的抖动效果
 *
 * 
 */
+ (void) lockAnimationForView:(UIView*)view;

/**
 *  输入的用户名或密码长度的限制
 *
 *  @param string 用户名
 *  @param num    密码
 *
 *  @return YES OR  NO
 */
+ (BOOL) isLengthString:(NSString *)string strType:(NSInteger)num;

/**
 *  判断输入的文字长度是否在一定范围之内
 *
 *  @param string <#string description#>
 *  @param length <#length description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isValidString:(NSString *)string withLength:(NSInteger)length;
/**
 *  RGBColorString  to UIColor
 *
 *  @param inColorString UIColor
 *
 *  @return UIColor
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

/**
 *  判断是否是中文
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isChinese:(NSString *)str;
/**
 *  判断是否是英文
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isEnglish:(NSString *)str;
/**
 *  判断是否是数字
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isNumber:(NSString *)str;
/**
 *  取得运营商
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCarrierCode;

/**
 *  查询占用的空间大小
 *
 *  @param subPath <#subPath description#>
 *
 *  @return <#return value description#>
 */
+(long long)spaceefPath:(NSString * )subPath;

/**
 *  查询占用的空间大小
 *
 *  @param subPath <#subPath description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)usedSpaceAndfreeSpaceSubsefPath:(NSString * )subPath;
/**
 *  清除下载的缓存
 *
 *  @param allFilePath <#allFilePath description#>
 */
+(void)deleteDirectoryAllFilePath:(NSString *)allFilePath;

+ (NSString *)getFileSizeString:(NSString *)size;

+ (BOOL)CheckIsMy:(NSString *)LogCustomerId isOther:(NSString *)LogTempId;

/**
 *   限制输入的长度
 *
 *  @param textCount    <#textCount description#>
 *  @param maxtextCount <#maxtextCount description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)canChangeText:(NSString *)textCount maxTextCount:(NSInteger)maxtextCount;
/**
 *  计算输入的内容长度
 *
 *  @param textCount    <#textCount description#>
 *  @param maxtextCount <#maxtextCount description#>
 *
 *  @return <#return value description#>
 */
+ (NSInteger)canChangeText:(NSString *)textCount maxNumberCount:(NSInteger)maxtextCount;
/**
 *  <#Description#>
 *
 *  @param textCount <#textCount description#>
 *
 *  @return <#return value description#>
 */
+ (NSInteger)canChangeText:(NSString *)textCount;

/**
 *  限制字符串的长度
 *
 *  @param textCount    <#textCount description#>
 *  @param maxtextCount <#maxtextCount description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)canNumberText:(NSString *)textCount maxTextCount:(NSInteger)maxtextCount;
/**
 *
 * 计算输入的内容长度
 *  @param textCount    <#textCount description#>
 *  @param maxtextCount <#maxtextCount description#>
 *
 *  @return <#return value description#>
 */
+ (NSInteger)canNumberText:(NSString *)textCount maxNumberCount:(NSInteger)maxtextCount;
/**
 *  <#Description#>
 *
 *  @param textCount <#textCount description#>
 *
 *  @return <#return value description#>
 */
+ (NSInteger)canNumberText:(NSString *)textCount;
/**
 *  结束时间是否大于开始时间
 *  compare begintime with endtime
 *
 *  @param startDate  statrtime
 *  @param endDate endtime
 *
 *  @return yes or no
 */

+ (BOOL)compareStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate;
/**
 *  一般用于证件照中用*来替代一些数字
 *  replace  number with  " * "
 *
 *  @param voucherNumber  number or  other sympol
 *
 *  @return  *
 */
+(NSString *)voucherNumberStr:(NSString *)voucherNumber;


/**
 *  字符串替换
 *
 *  @param string taregtstring
 *
 *  @return replace  string with unique string
 */
+ (NSString *)replaceUniqeChars:(NSString *)string;

/**
 *  判断是否允许使用照相机  或相册
 *
 *  @return 返回YES or NO
 */
+(BOOL)checkPhoto;

/**
 *  总的缓存大小
 *
 *  @return 返回字符串
 */
+ (NSString *)spaceTotalCache;

/**
 *  手机剩余空间
 *
 *  @return 返回字符串
 */
+ (NSString *)freeDiskSpaceInBytes;

/**
 *  是否有足够的空间
 *  has enough free space or not
 *  @return YES or  NO
 */

+ (BOOL)hasEnoughFreeSpace;
/**
 *  避免icloud备份
 *
 *  @param filePathString <#BOOL description#>
 *
 *  @return <#return value description#>
 */

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString;
/**
 *  <#Description#>
 *
 *  @param textCount <#textCount description#>
 *  @param index     <#index description#>
 *
 *  @return <#return value description#>
 */

+ (NSString *)getStringWithString:(NSString *)textCount InRange:(NSInteger)index ;

@end
