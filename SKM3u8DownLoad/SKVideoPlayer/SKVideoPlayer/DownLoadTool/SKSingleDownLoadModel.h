//
//  SKSingleDownLoadModel.h
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//
// ts 文件的model(用于构造本地m3u8用)
#import <Foundation/Foundation.h>

@interface SKSingleDownLoadModel : NSObject

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, copy) NSString *locationUrl;

@property (nonatomic, assign) NSInteger index;

@end
