
//
//  SKM3U8FilePraseManager.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKM3U8FilePraseManager.h"
#import "SKM3U8PlayListModel.h"
#import "SKSingleDownLoadModel.h"

@implementation SKM3U8FilePraseManager


- (void)praseUrl:(NSString *)url {
    // test 测试本地m3u8文件
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"1528970575352"
//                                                          ofType:@"m3u8"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
    
    
     //判断是否是HTTP连接如果不是就返回解析失败
    if (!([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"])) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(praseM3U8FileFailed:)]) {
            [self.delegate praseM3U8FileFailed:self];
        }
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        //解析出M3U8
        NSError *error = nil;
        NSStringEncoding encoding;
        //注意这一步是耗时操作，要在子线程中进行
        NSLog(@"解析开始%@",[SKM3U8FilePraseManager currentTimeStr]);
        NSString *m3u8Str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url] usedEncoding:&encoding error:&error];
        //    m3u8Str = htmlCont;
        NSLog(@"解析完成%@",[SKM3U8FilePraseManager currentTimeStr]);
        self.originM3U8Str = m3u8Str;
        if (m3u8Str == nil) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(praseM3U8FileFailed:)]) {
                [self.delegate praseM3U8FileFailed:self];
            }
            return;
        }
        //解析TS文件
        NSRange segmentRange = [m3u8Str rangeOfString:@"#EXTINF:"];
        if (segmentRange.location == NSNotFound) {
            //M3U8里没有TS文件
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(praseM3U8FileFailed:)]) {
                
                [self.delegate praseM3U8FileFailed:self];
                
            }
            return;
        }
        
        if (self.singleTSFileArray.count > 0) {
            [self.singleTSFileArray removeAllObjects];
        }
        //逐个解析TS文件，并存储
        while (segmentRange.location != NSNotFound) {
            //声明一个model存储TS文件链接和时长的model
            SKSingleDownLoadModel *model = [[SKSingleDownLoadModel alloc] init];
            //读取TS片段时长
            NSLog(@"原始m3u8Str====%@",m3u8Str);
            NSRange commaRange = [m3u8Str rangeOfString:@","];
            NSString* value = [m3u8Str substringWithRange:NSMakeRange(segmentRange.location + [@"#EXTINF:" length], commaRange.location -(segmentRange.location + [@"#EXTINF:" length]))];
            model.duration = [value integerValue];
            //截取M3U8
            m3u8Str = [m3u8Str substringFromIndex:commaRange.location];
            //获取TS下载链接,这需要根据具体的M3U8获取链接，可以根据自己公司的需求
            NSRange linkRangeBegin = [m3u8Str rangeOfString:@","];
            NSRange linkRangeEnd = [m3u8Str rangeOfString:@"#EXTINF:"];
            if (linkRangeEnd.location != NSNotFound) {
                NSString* linkUrl = [m3u8Str substringWithRange:NSMakeRange(linkRangeBegin.location + 2, linkRangeEnd.location-2-1)];
                model.locationUrl = linkUrl;
                [self.singleTSFileArray addObject:model];
                m3u8Str = [m3u8Str substringFromIndex:linkRangeEnd.location];
                segmentRange = [m3u8Str rangeOfString:@"#EXTINF:"];
            }else {
                NSString *endLength = @"#EXT-X-ENDLIST";
                NSRange linkRangeEnd = [m3u8Str rangeOfString:endLength];
                if (linkRangeEnd.location != NSNotFound) {
                    model.locationUrl = [m3u8Str substringWithRange:NSMakeRange(linkRangeBegin.location +2,linkRangeEnd.location-2-1)];
                    [self.singleTSFileArray addObject:model];
                    segmentRange = [m3u8Str rangeOfString:@"#EXTINF:"];
                }
            }
            
        }
        //已经获取了所有TS片段，继续打包数据
        [self.playList setTsFileArray:self.singleTSFileArray];
        // 这里的uuid可以为资源或者视频id
        self.playList.uuid = @"999934344";
        dispatch_async(dispatch_get_main_queue(), ^{
            //到此数据TS解析成功，通过代理发送成功消息
            if (self.delegate && [self.delegate respondsToSelector:@selector(praseM3U8FileSuccess:)]) {
                [self.delegate praseM3U8FileSuccess:self];
            }
        });
       
    });
}

- (SKM3U8PlayListModel *)playList {
    if (!_playList) {
        _playList = [[SKM3U8PlayListModel alloc]init];
    }
    return _playList;
}
- (NSMutableArray *)singleTSFileArray {
    if (!_singleTSFileArray) {
        _singleTSFileArray = [NSMutableArray array];
    }
    return _singleTSFileArray;
}

//获取当前时间
+ (NSString *)currentTimeStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS "];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

@end
