//
//  SKM3U8PlayListModel.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/19.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKM3U8PlayListModel.h"

@interface SKM3U8PlayListModel()

@property (nonatomic, assign) NSInteger length;

@end
@implementation SKM3U8PlayListModel

- (void)setTsFileArray:(NSArray *)tsFileArray  {
    _tsFileArray = tsFileArray;
    _length = tsFileArray.count;
}

@end
