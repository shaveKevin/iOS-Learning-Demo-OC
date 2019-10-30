//
//  SKVideoDownloader.h
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKM3U8PlayListModel.h"
#import <UIKit/UIKit.h>
/**
 文件下载管理并组装下载后的文件为本地m3u8 执行下载操作(总的下载操作-对单个下载器做操作)
 */
@class SKVideoDownloader;

@protocol SKVideoDownloaderDelegate<NSObject>

/**
 download success

 @param videoDownLoader download
 */
- (void)videoDownLoadSuccess:(SKVideoDownloader *)videoDownLoader;

/**
 download failed

 @param videoDownLoader downlod
 */
- (void)videoDownLoadFailed:(SKVideoDownloader *)videoDownLoader;

/**
 download progress

 @param downLoadProgress downLoadProgress
 */
- (void)videoDownLoadProgress:(CGFloat)downLoadProgress;

@end

@interface SKVideoDownloader : NSObject

/**
 Model
 */
@property (nonatomic, strong) SKM3U8PlayListModel *playList;

@property (nonatomic, copy) NSString *originM3U8Url;

- (void)startDownLoadVideo;

- (void)pauseDownLoadVideo;

- (void)continueDownLoadVideo;

/**
 需要下载的数组(所有下载器的集合)
 */
@property (nonatomic, strong) NSMutableArray *downloadArray;

@property (nonatomic, weak) id <SKVideoDownloaderDelegate> delegate;
/**
 总共下载的数组
 */
@property (nonatomic, assign) NSInteger totalDownLoadcount;


/**
 create local m3u8 file
 */
- (void)createLocalM3U8File;

@end
