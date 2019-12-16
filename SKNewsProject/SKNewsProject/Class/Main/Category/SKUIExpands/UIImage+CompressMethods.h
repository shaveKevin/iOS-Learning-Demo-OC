//
//  UIImage+CompressMethods.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CompressMethods)

/**
 *  修改发图片大小
 *  @param image 原图
 *  @param newSize 修改尺寸
 *  @return 返回修改后的image
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;

/**
 * 根据图片文件路径得到图片data
 */
+ (NSData *)getImageDataWithFilePath:(NSString *)filePath;

/**
 * 根据图片得到图片data
 */
+ (NSData *)getImageDataWithImage:(UIImage *)oriImage;

@end
