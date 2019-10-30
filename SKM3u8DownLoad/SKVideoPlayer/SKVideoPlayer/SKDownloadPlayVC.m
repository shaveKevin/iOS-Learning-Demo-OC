//
//  SKDownloadPlayVC
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKDownloadPlayVC.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import "SKM3U8FileDecodeTool.h"
#import <JDStatusBarNotification.h>
#import "SKHeaderFile.h"
#import <UIImageView+WebCache.h>

static NSString *const videoUrl =  @"https://vpro01.allinmd.cn/36db11bf703bc87ff80368c52a04bc2b.m3u8";
static NSString *const imageUrl = @"https://img05.allinmd.cn/public1/M00/03/3A/ooYBAFU838-AMyYbAAEm81lAuHY553.png";
@interface SKDownloadPlayVC ()<SKM3U8FileDecodeToolDelegate>

@property (nonatomic, strong) AVPlayer * player;

@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic,strong) UIButton *downLoadButton;

@property (nonatomic,strong) UIButton *playButton;

@property (strong, nonatomic) SKM3U8FileDecodeTool *decodeTool;

@property (nonatomic, strong) JDStatusBarView *statusBar;

@property (nonatomic, strong) UIView *videoView;

@property (nonatomic, strong) UILabel *progressLabel;

@end

@implementation SKDownloadPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    self.videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth([UIScreen mainScreen].bounds),  200)];
    self.videoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.videoView];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.height.mas_equalTo(300);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.videoView  addGestureRecognizer:tap];
    

    [self.downLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoView.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
        make.centerX.equalTo(self.videoView.mas_centerX).offset(-20-40);
    }];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downLoadButton.mas_right).offset(40);
        make.top.mas_equalTo(self.downLoadButton.mas_top);
        make.size.mas_equalTo(self.downLoadButton);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(20);
        make.top.equalTo(self.downLoadButton.mas_bottom).offset(40);
        make.centerX.equalTo(self.videoView.mas_centerX).offset(0);
    }];
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (!error) {
            NSString *saveTo = [[[kDocPath stringByAppendingString:kVedioListPath] stringByAppendingPathComponent:@"999934344"] stringByAppendingPathComponent:@"9999343555.png"];
            NSLog(@"写入成功");
            [data writeToFile:saveTo atomically:YES];
        }
    }];
    
}

- (void)downloadVideo:(id)sender {
    NSLog(@"别动,我要开始下载视频了");
    [self.decodeTool decodeM3U8Url:videoUrl];
}

- (void)m3u8FileDecodeSuccess {
    NSLog(@"这里是以三个为基准的。 其实可以用一个为基准因为不需要边下边播");
    //显示一共下载了多少文件
    NSString *saveTo = [[kDocPath stringByAppendingString:kVedioListPath] stringByAppendingPathComponent:@"999934344"];
    NSFileManager *fm = [NSFileManager defaultManager];
    //路径不存在就创建一个
    BOOL isD = [fm fileExistsAtPath:saveTo];
    if (isD) {
        //存在
        //清空当前的M3U8文件
        NSArray *subFileArray = [fm subpathsAtPath:saveTo];
        NSMutableArray *tsArray = [[NSMutableArray alloc] init];
        [subFileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[NSString stringWithFormat:@"%@", obj] hasSuffix:@".ts"]) {
                NSLog(@"下载的文件是：%@",obj);
                [tsArray addObject:obj];
            }
        }];
        NSLog(@"一共下载了%ld个文件",(long)tsArray.count);
        NSString *progressStr = [NSString stringWithFormat:@"%f",(CGFloat)tsArray.count/self.decodeTool.totalTSFileArray.count];
        NSLog(@"progressStr  is =======%@",progressStr);

    }
}
- (void)m3u8FileDecodeFail {
    NSLog(@"解码失败");

}
- (void)downLoadProgress:(CGFloat)progress {
    NSLog(@"下载进度：%.2f",progress);
    if (progress < 1.000000) {
        self.downLoadButton.userInteractionEnabled = NO;
    }
    self.progressLabel.text = [NSString stringWithFormat:@"下载进度为:%.2f%%",progress*100];
}

- (void)downLoadSuccess {
    NSLog(@"下载完成了啊啊啊啊 啊啊啊啊啊啊");
}
- (void)downLoadFalied {
    NSLog(@"下载失败");
}
#pragma mark - 通知
/**
 *  添加播放器通知
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
}
/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
}

- (void)onTap:(id)sender {
    
    if (self.player.rate == 0) {
        [self.player play];
        NSLog(@"此时为暂停/或者停止,点击后为播放");
    }else {
        [self.player pause];
        NSLog(@"此时为播放中，点击后为暂停");
        
    }
}
- (void)playAction:(id)sender {
    NSLog(@"播放");
    if (!self.player) {
        // 拿到本地的m3u8文件进行播放
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://localhost:9999/999934344/movie.m3u8"]];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self addObserverToPlayerItem:self.playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.videoView.bounds;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.videoView.layer addSublayer:self.playerLayer];
    }else {
        NSLog(@"已存在了");
    }
    [self onTap:nil];
}
/**
 *  给AVPlayerItem添加监控
 *
 *  @param playerItem AVPlayerItem对象
 */
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    AVPlayerItem *playerItem=object;
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            CMTime time = self.player.currentTime;
            NSTimeInterval currentTimeSec = time.value / time.timescale;
            NSLog(@"当前的时间为%f",currentTimeSec);
        }else if (status == AVPlayerStatusFailed){
            NSLog(@"加载失败");
            NSLog(@"%@",self.playerItem.error);
            
        }else {
            NSLog(@"未知");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)dealloc {
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)downLoadButton {
    if (!_downLoadButton) {
        _downLoadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downLoadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_downLoadButton setBackgroundColor:[UIColor blueColor]];
        [self.view addSubview:_downLoadButton];
        [_downLoadButton addTarget:self action:@selector(downloadVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadButton;
}
- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_playButton setBackgroundColor:[UIColor blueColor]];
        [_playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_playButton];
    }
    return _playButton;
}

#pragma mark - getter
- (SKM3U8FileDecodeTool *)decodeTool {
    if (_decodeTool == nil) {
        _decodeTool = [[SKM3U8FileDecodeTool alloc] init];
        _decodeTool.delegate = self;
    }
    return _decodeTool;
}
- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]init];
        _progressLabel.backgroundColor = [UIColor orangeColor];
        _progressLabel.textColor = [UIColor redColor];
        _progressLabel.text = @"下载进度为:0%";
        [self.view addSubview:_progressLabel];
    }
    return _progressLabel;
}
@end

