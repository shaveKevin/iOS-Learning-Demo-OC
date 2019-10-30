//
//  SKDownloader.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/27.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKDownloader.h"
#import "NSURLSession+CorrectedResumeData.h"
#import "SKHeaderFile.h"

/// weakSelf.
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

@implementation SKDownloader
- (instancetype)initWithSessionId:(NSString *)sessionId downloadUrl:(NSURL *)downloadUrl {
    
    if(self = [super init]) {
        _stringDownloadURL = [downloadUrl absoluteString];
        _sessionId = sessionId;
        _curloadSize = @0;
    }
    return self;
}

- (void)dealloc {
    
    self.delegate = nil;
}

- (void)start {
    
    
    if ([self checkCurrentTSFileDownload]) {
        self.downloadStatusType = eDownloadStatusOver;
        if (self.delegate && [self.delegate respondsToSelector:@selector(downloaderTSFileExists:)]) {
            [self.delegate downloaderTSFileExists:self];
            return;
        }
    }
    if(!self.mSession)
    {
        self.mSession = [self mediaBackgroundSession];
    }
    
    [self setDownloadStatusType:eDownloadStatusOn];
    
    if(self.dataDownload) {
        
        self.downloadTask = [self.mSession downloadTaskWithCorrectResumeData:self.dataDownload];
        if(self.delegate && [self.delegate respondsToSelector:@selector(downloaderDidBeginResume:)])
        {
            [self.delegate downloaderDidBeginResume:self];
        }
    }  else {
        
        if (_stringDownloadURL) {
            NSString *urlStr = [_stringDownloadURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *downloadURL = [NSURL URLWithString:urlStr];
            self.downloadTask = [self.mSession downloadTaskWithURL:downloadURL];
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(downloaderDidFirstBegin:)])
            {
                [self.delegate downloaderDidFirstBegin:self];
            }
        }
    }
    
    WS(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.downloadTask resume];
    });
}

- (void)pause:(void (^)(void))complection {
    
    [self setDownloadStatusType:eDownloadStatusPause];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(downloaderDidPause:)])
    {
        [self.delegate downloaderDidPause:self];
    }
    
    if(self.downloadTask)
    {
        WS(weakSelf);
        [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.dataDownload = resumeData;
                weakSelf.downloadTask = nil;
                complection();
                if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(downloaderDidPause:)])
                {
                    [weakSelf.delegate downloaderDidPause:weakSelf];
                }
            });
        }];
    }
    
    if(self.mSession)
    {
        [self.mSession invalidateAndCancel];
        self.mSession = nil;
    }
}

- (void)wait:(void (^)(void))complection {
    
    [self setDownloadStatusType:eDownloadStatusWait];
    if(self.delegate && [self.delegate respondsToSelector:@selector(downloaderDidWait:)])
    {
        [self.delegate downloaderDidWait:self];
    }
    
    if(self.downloadTask)
    {
        WS(weakSelf);
        [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.dataDownload = resumeData;
                weakSelf.downloadTask = nil;
                if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(downloaderDidWait:)])
                {
                    [weakSelf.delegate downloaderDidWait:weakSelf];
                }
            });
        }];
        
        if(self.mSession)
        {
            [self.mSession invalidateAndCancel];
            self.mSession = nil;
        }
    }
}

- (void)stop {
    
    [self setDownloadStatusType:eDownloadStatusCancel];
    
    if(self.dataDownload)
    {
        self.downloadTask = [self.mSession downloadTaskWithCorrectResumeData:self.dataDownload];
        WS(weakSelf);
        dispatch_async(dispatch_get_main_queue(), ^{

            [weakSelf.downloadTask cancel];
            weakSelf.downloadTask = nil;
            if(weakSelf.downloadTask)
            {
                [weakSelf.downloadTask cancel];
                weakSelf.downloadTask = nil;
            }
            
            if(weakSelf.mSession)
            {
                [weakSelf.mSession invalidateAndCancel];
                weakSelf.mSession = nil;
            }
            
            if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(downloaderDidStop:)])
            {
                [weakSelf.delegate downloaderDidStop:weakSelf];
            }
        });
    } else {
        
        if(self.downloadTask)
        {
            [self.downloadTask cancel];
            self.downloadTask = nil;
        }
        
        if(self.mSession)
        {
            [self.mSession invalidateAndCancel];
            self.mSession = nil;
        }
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(downloaderDidStop:)])
        {
            [self.delegate downloaderDidStop:self];
        }
    }
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    
    //debugLog(@"Invalid %@",error);
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
    if(self.downloadTask)
    {
        [self.downloadTask cancel];
        self.downloadTask = nil;
    }
    
    if(self.mSession)
    {
        [self.mSession invalidateAndCancel];
        self.mSession = nil;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(downloaderDidFinishedBackEvents:)])
    {
        [self.delegate downloaderDidFinishedBackEvents:self];
    }
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    if(error)
    {
        //debugLog(@"下载error %@",[error description]);
        NSDictionary *userInfo = [error userInfo];
        if(userInfo)
        {
            NSData * data = userInfo[@"NSURLSessionDownloadTaskResumeData"];
            NSNumber * backgroundCancelReason = userInfo[@"NSURLErrorBackgroundTaskCancelledReasonKey"];
            if(data) {
                self.dataDownload = data;
            }
            if(backgroundCancelReason && [backgroundCancelReason integerValue] == 0 && data) {
                // 强制退出
                [self.downloadTask cancel];
                self.downloadTask = nil;
                self.downloadTask = [self.mSession downloadTaskWithCorrectResumeData:data];
                WS(weakSelf);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.downloadTask resume];
                });
                return;
            }
        }
        
        NSString *domainError = [error domain];
        if(domainError && [domainError isEqualToString:NSPOSIXErrorDomain])
        {
            // 缓存数据被删 只能重新下载
            self.dataDownload = nil;
            [self.downloadTask cancel];
            self.downloadTask = nil;
            [self start];
            return;
        }
        else if(domainError && [domainError isEqualToString:NSURLErrorDomain])
        {
            if([error code] == -3003)
            {
                // 复用data出问题 只能重新下载
                self.dataDownload = nil;
                [self.downloadTask cancel];
                self.downloadTask = nil;
                [self start];
                return;
            }
        }
    }
    else
    {
        //debugLog(@"下载成功");
        [self setDownloadStatusType:eDownloadStatusOver];
        if(self.downloadTask == task)
        {
            [self.downloadTask cancel];
            self.downloadTask = nil;
        }
        if(self.mSession == session)
        {
            [self.mSession invalidateAndCancel];
            self.mSession = nil;
        }
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(downloader:didFinishedWithError:)])
    {
        [self.delegate downloader:self didFinishedWithError:error];
    }
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
//    if([[NSFileManager defaultManager] fileExistsAtPath:[kDocPath stringByAppendingString:_stringDownloadFolderPath]] == NO)
//    {
//        [[NSFileManager defaultManager] createDirectoryAtPath:[kDocPath stringByAppendingString:_stringDownloadFolderPath]
//                                  withIntermediateDirectories:YES
//                                                   attributes:nil
//                                                        error:nil];
//        [SKDownloader addSkipBackupAttributeToItemAtPath:[kDocPath stringByAppendingString:_stringDownloadFolderPath]];
//    }
    
    NSString *fileName = [location lastPathComponent];
    NSMutableString *mFileName = [NSMutableString stringWithString:fileName];
    if([mFileName hasSuffix:@".tmp"])
    {
        NSRange rane = [mFileName rangeOfString:@".tmp"];
        if(rane.location != NSNotFound && rane.length)
        {
            _stringDownloadPath = [_stringDownloadFolderPath stringByAppendingPathComponent:mFileName];

//            NSURL *cacheFileURL = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
//                                                                                               NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:_stringDownloadPath]];
            // 拼接路径得到存储下载文件的路径
            __block NSString *path = [[[kDocPath stringByAppendingString:kVedioListPath] stringByAppendingPathComponent:self.stringDownloadFolderPath] stringByAppendingPathComponent:self.fileName];
            NSError *error = nil;
            if ([[NSFileManager defaultManager] moveItemAtURL:location
                                                        toURL:[NSURL URLWithString:path]
                                                        error:&error]) {
                
                if(self.delegate && [self.delegate respondsToSelector:@selector(downloader:didFinishDownloadingToPath:)])
                {
                    [self.delegate downloader:self didFinishDownloadingToPath:_stringDownloadPath];
                }
            }
        }
    }
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    if(totalBytesExpectedToWrite >= self.stringTotalSize.doubleValue)
        self.stringTotalSize = [[NSNumber numberWithDouble:totalBytesExpectedToWrite] stringValue];
    self.curloadSize = [NSNumber numberWithDouble:totalBytesWritten];
    
    if(self.downloadTask == downloadTask) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(downloader:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)])
        {
            [self.delegate downloader:self didWriteData:bytesWritten totalBytesWritten:self.curloadSize.doubleValue totalBytesExpectedToWrite:self.stringTotalSize.doubleValue];
        }
    }
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    if(fileOffset == 0) {
        // 复用data出问题 只能重新下载
        self.dataDownload = nil;
        [self.downloadTask cancel];
        self.downloadTask = nil;
        [self start];
    }
}

#pragma mark
#pragma mark setter & getter

- (NSURLSession *)mediaBackgroundSession {
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:_sessionId];
    NSURLSession * backgroundSession = [NSURLSession sessionWithConfiguration:configuration delegate:self
                                                                delegateQueue:[NSOperationQueue mainQueue]];
    return backgroundSession;
    
}

/// 避免icloud备份
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString {
    
    NSURL * URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
#ifdef DEBUG
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
#endif
    }
    return success;
}


#pragma mark - 检查此文件是否下载过
- (BOOL)checkCurrentTSFileDownload {
    
    //获取缓存路径
    NSString *savePath = [[kDocPath stringByAppendingString:kVedioListPath] stringByAppendingPathComponent:self.stringDownloadFolderPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    __block BOOL isExist = NO;
    //获取缓存路径下的所有的文件名
    NSArray *subFileArray = [fileManager subpathsAtPath:savePath];
    [subFileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //判断是否已经缓存了此文件
        if ([self.fileName isEqualToString:[NSString stringWithFormat:@"%@", obj]]) {
            //已经下载
            isExist = YES;
            *stop = YES;
        } else {
            //不存在
            isExist = NO;
        }
    }];
    return isExist;
}
@end
