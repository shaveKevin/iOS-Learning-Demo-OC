//
//  SKOnlinePlayVC.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/20.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "SKOnlinePlayVC.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
static NSString *const videoUrl =  @"https://vpro01.allinmd.cn/36db11bf703bc87ff80368c52a04bc2b.m3u8";

@interface SKOnlinePlayVC ()

@property (nonatomic, strong) AVPlayer * player;

@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic,strong) UIButton *playButton;

@property (nonatomic, strong) UIButton *pauseButton;

@end

@implementation SKOnlinePlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth([UIScreen mainScreen].bounds),  200)];
    videoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:videoView];
    [videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.height.mas_equalTo(200);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [videoView  addGestureRecognizer:tap];
    // Do any additional setup after loading the view, typically from a nib.
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoUrl]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self addObserverToPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = videoView.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [videoView.layer addSublayer:self.playerLayer];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
        make.top.equalTo(videoView.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
        make.centerX.equalTo(videoView.mas_centerX).offset(-20-40);
    }];
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).offset(40);
        make.top.mas_equalTo(self.playButton.mas_top);
        make.size.mas_equalTo(self.playButton);
    }];
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
        self.playButton.userInteractionEnabled = YES;
        self.pauseButton.userInteractionEnabled = NO;
        NSLog(@"此时为暂停/或者停止,点击后为播放");
        [self.player play];
        self.playButton.userInteractionEnabled = NO;
        self.pauseButton.userInteractionEnabled = YES;
    }else {
        self.playButton.userInteractionEnabled = NO;
        self.pauseButton.userInteractionEnabled = YES;
        NSLog(@"此时为播放中，点击后为暂停");
        [self.player pause];
        self.playButton.userInteractionEnabled = YES;
        self.pauseButton.userInteractionEnabled = NO;
    }
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
    
    if (self.player) {
        [self.player pause];
    }
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_playButton setBackgroundColor:[UIColor blueColor]];
        [_playButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_playButton];
    }
    return _playButton;
}
- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_pauseButton setBackgroundColor:[UIColor blueColor]];
        [_pauseButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_pauseButton];
    }
    return _pauseButton;
}

@end
