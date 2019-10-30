//
//  SKM3U8FileDecodeTool.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKM3U8FileDecodeTool.h"
#import "SKM3U8FilePraseManager.h"
#import "SKVideoDownloader.h"
#import "SKSingleDownLoadModel.h"


@interface SKM3U8FileDecodeTool ()
<SKM3U8FilePraseDelegate,
SKVideoDownloaderDelegate
>

@property (nonatomic, strong) SKM3U8FilePraseManager *m3U8FilePraseManager;

@property (nonatomic,strong) SKVideoDownloader *downLoader;

//播放链接
@property (copy, nonatomic) NSString *playUrl;

//定时解码的定时器
@property (strong, nonatomic) NSTimer *decodeTimer;

//标记第一次是否已经创建多M3U8
@property (assign, nonatomic) BOOL isM3U8;

@end

@implementation SKM3U8FileDecodeTool

- (instancetype)init {
    if (self = [super init]) {
        //
    }
    return  self;
}

- (void)decodeM3U8Url:(NSString *)url {
    [self.m3U8FilePraseManager praseUrl:url];
    self.playUrl = url;
    self.isM3U8 = NO;
}
- (void)praseM3U8FileFailed:(SKM3U8FilePraseManager *)handler {
    if (self.delegate && [self.delegate respondsToSelector:@selector(m3u8FileDecodeFail)]) {
        [self.delegate m3u8FileDecodeFail];
    }
    NSLog(@"解析M3u8文件失败");

}

- (void)praseM3U8FileSuccess:(SKM3U8FilePraseManager *)handler {
    // 解析成功 开始下载
    NSLog(@"解析成功 开始下载");
    if (self.totalTSFileArray.count) {
        [self.totalTSFileArray removeAllObjects];
    }
    [self.totalTSFileArray addObjectsFromArray:handler.playList.tsFileArray];
    
    self.downLoader.playList = handler.playList;
    self.downLoader.originM3U8Url = handler.originM3U8Str;
    [self.downLoader startDownLoadVideo];
    // 这里没有边下 边播 所里这里不需要用
//    //解析成功后开启定时器，定时解析和请求播放数据
//    [self openDecodeTimer];
    
}

- (void)suspendDownLoad {
    [self.downLoader pauseDownLoadVideo];
}
- (void)continueDownLoad {
    [self.downLoader continueDownLoadVideo];
}
- (void)videoDownLoadFailed:(SKVideoDownloader *)videoDownLoader {
    if (self.delegate && [self.delegate respondsToSelector:@selector(m3u8FileDecodeFail)]) {
        [self.delegate m3u8FileDecodeFail];
    }

}

- (void)videoDownLoadSuccess:(SKVideoDownloader *)videoDownLoader {
    if (self.delegate && [self.delegate respondsToSelector:@selector(m3u8FileDecodeSuccess)]) {
        [self.delegate m3u8FileDecodeSuccess];
    }
 
}

- (void)videoDownLoadProgress:(CGFloat)downLoadProgress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(downLoadProgress:)]) {
        [self.delegate downLoadProgress:downLoadProgress];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(downLoadSuccess)]) {
        if (self.downLoader.totalDownLoadcount == self.downLoader.downloadArray.count) {
            [self.delegate downLoadSuccess];
        }
    }
}
#pragma mark - 循环解码
- (void)circleDecode {
    [self.m3U8FilePraseManager praseUrl:self.playUrl];
}

#pragma mark - 开启循环解码定时器
- (void)openDecodeTimer {
    if (_decodeTimer == nil) {
        NSLog(@"循环解码定时器已经开启");
        //分析定时器的循环时间，这里取一个M3U8时间的一半
        __block NSTimeInterval time = 0;
        [self.downLoader.playList.tsFileArray enumerateObjectsUsingBlock:^(SKSingleDownLoadModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            time += obj.duration;
        }];
        
        time /= self.downLoader.playList.tsFileArray.count;
        _decodeTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(circleDecode) userInfo:nil repeats:YES];
    } else {
        return;
    }
}

- (SKVideoDownloader *)downLoader {
    if (!_downLoader) {
        _downLoader = [[SKVideoDownloader alloc]init];
        _downLoader.delegate = self;
    }
    return _downLoader;
}
- (SKM3U8FilePraseManager *)m3U8FilePraseManager {
    if (!_m3U8FilePraseManager) {
        _m3U8FilePraseManager = [[SKM3U8FilePraseManager alloc]init];
        _m3U8FilePraseManager.delegate = self;
        
    }
    return _m3U8FilePraseManager;
}

- (NSMutableArray *)totalTSFileArray {
    if (!_totalTSFileArray) {
        _totalTSFileArray = [NSMutableArray array];
    }
    return _totalTSFileArray;
}
@end
