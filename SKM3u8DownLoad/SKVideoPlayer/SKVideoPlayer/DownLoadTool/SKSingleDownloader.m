//
//  SKSingleDownloader.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKSingleDownloader.h"
#import <AFNetworking.h>
#import "SKHeaderFile.h"

@interface SKSingleDownloader()

@property (strong, nonatomic) AFHTTPRequestSerializer *serializer;

@property (strong, nonatomic) AFURLSessionManager *downLoadSession;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@end

@implementation SKSingleDownloader

- (instancetype)initWithUrl:(NSString *)url filePath:(NSString *)filePath fileName:(NSString *)fileName duration:(NSInteger)duration index:(NSInteger)index {
    
    if (self = [super init]) {
        self.downLoadUrl = url;
        self.fileName = fileName;
        self.filePath = filePath;
        self.durtion = duration;
        self.index = index;
    }
    return self;
}

- (void)start {
    // 先检查一下之前有没有下载过
    if ([self checkCurrentTSFileDownload]) {
        //下载过
//        self.flag = YES;
        self.downLoadStatus = eSingleVideoDownLoadSuccess;
// 已经存在就告诉外面存在
        if (self.delegate && [self.delegate respondsToSelector:@selector(singleTSFileDownLoadExists:)]) {
            [self.delegate singleTSFileDownLoadExists:self];
            return;
        }
    }
    self.downLoadStatus = eSingleVideoDownLoading;
    // 拼接路径得到存储下载文件的路径
    __block NSString *path = [[[kDocPath stringByAppendingString:kVedioListPath] stringByAppendingPathComponent:self.filePath] stringByAppendingPathComponent:self.fileName];
    //这里使用AFN下载,并将数据同时存储到沙盒目录制定的目录中
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.downLoadUrl]];
    __block NSProgress *progress = nil;
    self.downloadTask = [self.downLoadSession downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress = downloadProgress;
//        NSLog(@"正在下载的文件是%@",self.fileName);
        //添加对进度的监听
//        [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //
        NSLog(@"targetPath is ====%@",targetPath);
        
        //在这里告诉AFN数据存储的路径和文件名
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:path isDirectory:NO];
        return documentsDirectoryURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            self.downLoadStatus = eSingleVideoDownLoadFailed;
            if (self.delegate && [self.delegate respondsToSelector:@selector(singleTSFileDownLoadFailed:)]) {
                [self.delegate singleTSFileDownLoadFailed:self];
            }
        }else {
            self.downLoadStatus = eSingleVideoDownLoadSuccess;
            NSLog(@"路径%@保存成功", filePath);
            NSLog(@"下载成功:%@",self.downLoadUrl);
            if (self.delegate && [self.delegate respondsToSelector:@selector(singleTSFileDownLoadSuccess:)]) {
                [self.delegate singleTSFileDownLoadSuccess:self];
            }
//            // 删除已下载的缓存文件
//            NSString *path1111 = [[kDocPath stringByAppendingString:kVedioTempPath] stringByAppendingFormat:@"/%@",self.filePath];
//            [SKSingleDownloader deleteDirectoryAllFilePath:path1111];
        }
//        [progress removeObserver:self forKeyPath:@"completedUnitCount"];
    }];
    //开始下载
    [ self.downloadTask resume];
}
#pragma mark - 检查此文件是否下载过
- (BOOL)checkCurrentTSFileDownload {
    
    //获取缓存路径
    NSString *savePath = [[kDocPath stringByAppendingString:kVedioListPath] stringByAppendingPathComponent:self.filePath];
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

#pragma mark - 监听进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(NSProgress *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"completedUnitCount"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(singleTSFileDownLoad:TotalUnitCount:completedUnitCount:)]) {
            [self.delegate singleTSFileDownLoad:self TotalUnitCount:object.totalUnitCount completedUnitCount:object.completedUnitCount];
        }
    }
}

- (void)suspend {
        if (![self checkCurrentTSFileDownload]) {
        if (self.downloadTask) {
            [self.downloadTask suspend];
            NSLog(@"下载被挂起");
        }
    }
}

- (void)continueDownLoad {
    
    if (![self checkCurrentTSFileDownload]) {
        if (self.downloadTask) {
            [self.downloadTask resume];
            NSLog(@"下载继续");
        }
    }
}

#pragma mark - init

- (AFHTTPRequestSerializer *)serializer {
    if (!_serializer) {
        _serializer = [AFHTTPRequestSerializer serializer];
    }
    return _serializer;
}

- (AFURLSessionManager *)downLoadSession {
    if (!_downLoadSession) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSString *path1111 = [[kDocPath stringByAppendingString:kVedioTempPath] stringByAppendingFormat:@"/%@/%@",self.filePath,self.fileName];
        configuration.URLCache = [[NSURLCache alloc]initWithMemoryCapacity:100000 diskCapacity:10000 diskPath:path1111];
        _downLoadSession = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return _downLoadSession;
}

+ (void)deleteDirectoryAllFilePath:(NSString *)allFilePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray * files = [fileManager subpathsAtPath:allFilePath];
    for (NSString * path in files) {
        
        NSError * error = nil;
        NSString * cachPath = [allFilePath stringByAppendingPathComponent:path];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:cachPath error:&error];//删除
        }
    }
}

@end
