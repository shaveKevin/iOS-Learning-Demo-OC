//
//  SKSingleDownloader.h
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//
// 单个ts文件下载器

#import <Foundation/Foundation.h>


/**
 单个视频下载状态的枚举

 - eSingleVideoDownLoadFailed: 下载失败
 - eSingleVideoDownLoading: 下载中
 - eSingleVideoDownLoadSuccess: 下载成功
 */
typedef NS_ENUM(NSInteger, SKSingleVideoDownLoadStatus){
    eSingleVideoDownLoadFailed = 1,
    eSingleVideoDownLoading = 2,
    eSingleVideoDownLoadSuccess = 3,


};

@class SKSingleDownloader;
@protocol SKSingleTSFileDownLoadDelegate<NSObject>
@optional
/**
 file download success

 @param downloader single ts file download
 */
- (void)singleTSFileDownLoadSuccess:(SKSingleDownloader *)downloader;

/**
 file download success
 
 @param downloader single ts file download
 */
- (void)singleTSFileDownLoadFailed:(SKSingleDownloader *)downloader;

/**
 exists file downlaod

 @param downloader just for caluale progress
 */
- (void)singleTSFileDownLoadExists:(SKSingleDownloader *)downloader;


/**
 download progress

 @param downloader downloader
 @param totalUnitCount total
 @param completedUnitCount download
 */
- (void)singleTSFileDownLoad:(SKSingleDownloader *)downloader TotalUnitCount:(int64_t)totalUnitCount completedUnitCount:(int64_t)completedUnitCount;

@end

@interface SKSingleDownloader : NSObject

/**
 target fileName
 */
@property (nonatomic, copy) NSString *fileName;

/**
 destination filePath
 */
@property (nonatomic, copy) NSString *filePath;

/**
 downLoadUrl
 */
@property (nonatomic, copy) NSString *downLoadUrl;
/**
 file durtion
 */
@property (nonatomic, assign) NSInteger durtion;
/**
 download current index
 */
@property (nonatomic, assign) NSInteger index;

/**
 资源下载状态
 */
@property (nonatomic, assign) SKSingleVideoDownLoadStatus downLoadStatus;


/**
 init

 @param url download url
 @param filePath downloadPath
 @param fileName downloadFileName
 @param duration file duration
 @param index download index
 @return downloader self
 */
- (instancetype)initWithUrl:(NSString *)url filePath:(NSString *)filePath fileName:(NSString *)fileName duration:(NSInteger)duration index:(NSInteger)index;

/**
 download status delegate
 */
@property (nonatomic, weak) id <SKSingleTSFileDownLoadDelegate> delegate;

@property (nonatomic, assign) int64_t completedUnitCount;

/**
 start download
 */
- (void)start;

/**
  stop pause then download
 */
- (void)continueDownLoad;

/**
 suspend download
 */
- (void)suspend;

@end
