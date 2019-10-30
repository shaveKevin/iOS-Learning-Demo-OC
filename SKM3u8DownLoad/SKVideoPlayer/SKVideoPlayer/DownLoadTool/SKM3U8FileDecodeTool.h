//
//  SKM3U8FileDecodeTool.h
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 m3u8 解码的类 暴露在最外层 解析m3u8文件 交给其他工具进行处理
 */
@protocol SKM3U8FileDecodeToolDelegate <NSObject>
@optional
/**
 解码成功
 */
- (void)m3u8FileDecodeSuccess;

/**
 解码失败
 */
- (void)m3u8FileDecodeFail;

/**
 下载进度

 @param progress 下载进度
 */
- (void)downLoadProgress:(CGFloat)progress;

/**
 下载成功处理
 */
- (void)downLoadSuccess;

@end

@interface SKM3U8FileDecodeTool : NSObject

/**
 解析并开始下载

 @param url m3u8文件url
 */
- (void)decodeM3U8Url:(NSString *)url;

@property (nonatomic, weak) id<SKM3U8FileDecodeToolDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *totalTSFileArray;


- (void)suspendDownLoad;

- (void)continueDownLoad;

@end
