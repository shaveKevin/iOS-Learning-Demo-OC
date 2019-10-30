//
//  SKDownloader.h
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/27.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  下载状态
 */
typedef NS_ENUM(NSInteger,DownloadStatusType) {
    /**
     *  未被下载
     */
    eDownloadStatusDefault = 0,
    /**
     *  等待下载
     */
    eDownloadStatusWait = 1,
    /**
     *  正在下载
     */
    eDownloadStatusOn = 2,
    /**
     *  暂停下载
     */
    eDownloadStatusPause = 3,
    /**
     *  下载完成
     */
    eDownloadStatusOver = 4,
    /**
     *  下载取消
     */
    eDownloadStatusCancel = 5,
};

@class SKDownloader;
@protocol SKDownloaderDelegate <NSObject>

@optional

- (void)downloaderDidFirstBegin:(SKDownloader *)downloader;
- (void)downloaderDidBeginResume:(SKDownloader *)downloader;
- (void)downloaderDidPause:(SKDownloader *)downloader;
- (void)downloaderDidWait:(SKDownloader *)downloader;
- (void)downloaderDidStop:(SKDownloader *)downloader;

- (void)downloader:(SKDownloader *)downloader didFinishedWithError:(NSError *)error;
- (void)downloader:(SKDownloader *)downloader didFinishDownloadingToPath:(NSString *)destPath;
- (void)downloaderDidFinishedBackEvents:(SKDownloader *)downloader;

- (void)downloader:(SKDownloader *)downloader
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;

/**
 exists file downlaod
 
 @param downloader just for caluale progress
 */
- (void)downloaderTSFileExists:(SKDownloader *)downloader;
@end

@interface SKDownloader : NSObject
<
NSURLSessionDelegate,
NSURLSessionTaskDelegate,
NSURLSessionDownloadDelegate,
NSURLSessionDataDelegate
>
/// 下载会话.
@property (nonatomic,strong) NSURLSession *mSession;
/// 下载任务.
@property (nonatomic,strong) NSURLSessionDownloadTask *downloadTask;
/// sessionId.
@property (nonatomic,copy) NSString *sessionId;
/// 下载地址URL.
@property (nonatomic,copy) NSString *stringDownloadURL;
/// 下载状态.
@property (nonatomic,assign) DownloadStatusType downloadStatusType;
/// 下载资源的标题.
@property (nonatomic,copy) NSString *stringTitle;
/// 下载后目录地址.
@property (nonatomic,copy) NSString *stringDownloadFolderPath;
/// 下载后存储路径.
@property (nonatomic,copy) NSString *stringDownloadPath;
/// 已经下载的数据 断点续传.
@property (nonatomic,strong) NSData *dataDownload;
/// 已经下载的文件大小.
@property (nonatomic,strong) NSNumber *curloadSize;
/// 资源总大小.
@property (copy, nonatomic) NSString *stringTotalSize;
/// 代理.
@property (nonatomic,weak) id<SKDownloaderDelegate> delegate;
/**
 file durtion
 */
@property (nonatomic, assign) NSInteger durtion;
/**
 download current index
 */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *fileName;


/// 初始化.
- (instancetype)initWithSessionId:(NSString *)sessionId downloadUrl:(NSURL *)downloadUrl;

/// 开始下载.
- (void)start;
/// 暂停下载.
- (void)pause:(void (^)(void))complection;
/// 等待下载.
- (void)wait:(void (^)(void))complection;
/// 停止下载.
- (void)stop;

@end
