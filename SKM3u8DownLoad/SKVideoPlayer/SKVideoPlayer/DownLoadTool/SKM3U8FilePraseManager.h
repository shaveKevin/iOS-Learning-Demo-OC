//
//  SKM3U8FilePraseManager.h
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

// 解析m3u8文件 只是解析并未下载(解析完成之后触发下载器)
#import <Foundation/Foundation.h>
@class SKM3U8PlayListModel;
@class SKM3U8FilePraseManager;
@protocol SKM3U8FilePraseDelegate<NSObject>

/**
 * 解析M3U8链接成功
 */
- (void)praseM3U8FileSuccess:(SKM3U8FilePraseManager *)handler;

/**
 * 解析M3U8链接失败
 */
- (void)praseM3U8FileFailed:(SKM3U8FilePraseManager *)handler;

@end

@interface SKM3U8FilePraseManager : NSObject

- (void)praseUrl:(NSString *)url;

@property (nonatomic, weak) id <SKM3U8FilePraseDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *singleTSFileArray;

@property (nonatomic, strong) SKM3U8PlayListModel *playList;

@property (nonatomic, copy) NSString *originM3U8Str;


@end
