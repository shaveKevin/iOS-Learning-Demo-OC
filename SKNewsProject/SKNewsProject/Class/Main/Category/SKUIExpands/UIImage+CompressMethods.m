//
//  UIImage+CompressMethods.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "UIImage+CompressMethods.h"

@implementation UIImage (CompressMethods)
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize {
    
    //根据image的宽高比，从新设置新高度
    newSize.height = image.size.height * (newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

+ (NSData *)getImageDataWithFilePath:(NSString *)filePath {
    
    NSData* data = nil;
    if(filePath) {
        //1.根据路径得到image
        UIImage *oriImage = [UIImage imageWithContentsOfFile:filePath];
        //2.压缩原文件
        UIImage *finalImage = [UIImage imageWithImageSimple:oriImage scaledToSize:CGSizeMake(300, 300)];
        //3.判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(finalImage)) {
            //3.1返回为png图像。
            data = UIImagePNGRepresentation(finalImage);
        }else {
            //3.2返回为JPEG图像。
            data = UIImageJPEGRepresentation(finalImage, 1.0);
        }
    }
    return data;
}

+ (NSData *)getImageDataWithImage:(UIImage *)oriImage {
    
    NSData* data = nil;
    if(oriImage) {
        //2.压缩原文件
        UIImage *finalImage = [UIImage imageWithImageSimple:oriImage scaledToSize:CGSizeMake(300, 300)];
        //3.判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(finalImage)) {
            //3.1返回为png图像。
            data = UIImagePNGRepresentation(finalImage);
        }else {
            //3.2返回为JPEG图像。
            data = UIImageJPEGRepresentation(finalImage, 1.0);
        }
    }
    return data;
}
@end
