//
//  NSString+MD5Methods.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Methods)

/**
 *    @brief    MD5.
 *
 *    @return   返回 value.
 *
 */
- (NSString *)MD5Hash;
/**
 *    @brief    MD5 32位 .
 *
 *    @return   返回 value.
 *
 */
+ (NSString *)md5EncryptWithString:(NSString *)string;
/**
 hmdac+MD5 32位 .

 @param toEncryptStr 目标字符串
 @param keyStr 秘钥
 @return 加密后的str
 */
+ (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr;
@end
