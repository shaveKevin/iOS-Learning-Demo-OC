//
//  SKLoopScrollView.m
//  SKLoopScrollView
//
//  Created by shavekevin on 16/7/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKLoopScrollView.h"
#import "Masonry.h"
#import "SKLoopModel.h"
#import "SKLoopScrollCell.h"

@interface SKLoopScrollView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>
@property (nonatomic,strong) UICollectionView *mCollectView;
@property (nonatomic,strong) UIPageControl *mPageControl;
@property (nonatomic,strong) NSTimer *mTimer;
@property (nonatomic,assign) BOOL fisrtLoad;
@property (nonatomic,assign) BOOL isDraging;

@end

@implementation SKLoopScrollView
- (void)dealloc
{
    [self stopTimer];
    _mClickItemBlock = nil;
    _mCollectView.delegate = nil;
    _mCollectView.dataSource = nil;
}

#pragma mark 辅助

- (instancetype)init
{
    if(self = [super init])
    {
        if([self.mCollectView isDescendantOfView:self] == NO){
            [self addSubview:_mCollectView];
        }
        [self.mCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        if([self.mPageControl isDescendantOfView:self] == NO){
            [self addSubview:self.mPageControl];
        }
        [self.mPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(self.mas_width);
        }];
    }
    return self;
}

- (void)stopTimer
{
    if(_mTimer)
    {
        [_mTimer invalidate];
        _mTimer = nil;
    }
}

- (NSTimer *)mTimer
{
    [self stopTimer];
    if(_mTimer == nil){
        _mTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                   target:self selector:@selector(timeLoopImg)
                                                 userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_mTimer forMode:NSRunLoopCommonModes];
    }
    return _mTimer;
}

- (void)loopImg
{
    NSInteger curWidth = CGRectGetWidth(self.bounds);
    NSInteger curIndex = fabs((self.mCollectView.contentOffset.x + curWidth / 2.0) / curWidth);

    if(curIndex == _arrayModal.count + 1) {curIndex = 1;}
    else if (curIndex == 0 && _arrayModal.count == 1) {curIndex = 0;}
    else if (curIndex == 0 && _arrayModal.count > 1) {curIndex = _arrayModal.count;}
    else if (curIndex == 0 && _arrayModal.count > 1) {curIndex = 1;}

    self.mCollectView.contentOffset = CGPointMake(curIndex * curWidth, 0);
    self.mPageControl.currentPage = curIndex - 1 ? curIndex - 1 : 0;
}

- (void)timeLoopImg
{
    if(_isDraging) return;
    
    self.mPageControl.numberOfPages = _arrayModal.count;
    
    NSInteger curWidth = CGRectGetWidth(self.bounds);
    NSInteger curHeight = CGRectGetHeight(self.bounds);
    if(curWidth == 0) {curWidth = CGRectGetWidth([UIScreen mainScreen].bounds);}
    if(curHeight == 0) {curHeight = 135;}
    
    if(_arrayModal.count > 1 && _fisrtLoad) {
        self.mCollectView.contentSize = CGSizeMake(curWidth * (2 + _arrayModal.count), curHeight);
        [self.mCollectView setContentOffset: CGPointMake(curWidth, 0) animated:NO];
        self.mPageControl.currentPage = 0;
        _fisrtLoad = NO;
    }
    else if (_arrayModal.count == 1){
        
        self.mCollectView.contentSize = CGSizeMake(curWidth * (_arrayModal.count), curHeight);
        [self.mCollectView setContentOffset: CGPointMake(0, 0) animated:NO];
        self.mPageControl.currentPage = 0;
        self.mPageControl.hidden = YES;
    }
    else{
        __block NSInteger curIndex = fabs((self.mCollectView.contentOffset.x + curWidth / 2.0) / curWidth + 0.5);
        [self.mCollectView setContentOffset: CGPointMake(curIndex * curWidth, 0) animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(curIndex == _arrayModal.count + 1) {curIndex = 1;}
            else if (curIndex == 0 && _arrayModal.count == 1) {curIndex = 0;}
            else if (curIndex == 0 && _arrayModal.count > 1) {curIndex = 1;}
            [self.mCollectView setContentOffset: CGPointMake(curIndex * curWidth, 0) animated:NO];
            self.mPageControl.currentPage = curIndex - 1 ? curIndex - 1 : 0;
        });
    }
}

- (void)setArrayModal:(NSArray *)arrayModal
{
    _arrayModal = arrayModal;
    
    _fisrtLoad = YES;
    [self timeLoopImg];

    [self.mCollectView reloadData];
}

- (void)start
{
    [self mTimer];
}

#pragma mark UI
- (UICollectionView *)mCollectView
{
    if(_mCollectView == nil){
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _mCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _mCollectView.delegate = self;
        _mCollectView.dataSource = self;
        _mCollectView.pagingEnabled = YES;
    }
    return _mCollectView;
}

- (UIPageControl *)mPageControl{
    if(_mPageControl == nil){
        _mPageControl = [[UIPageControl alloc] init];
        _mPageControl.backgroundColor = [UIColor clearColor];
    }
    return _mPageControl;
}

#pragma mark scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loopImg];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDraging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isDraging = NO;
    });
}

#pragma mark UICollectionView delegate & dataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if(_arrayModal.count == 0) return 0;
    else if (_arrayModal.count == 1) return 1;
    return _arrayModal.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * loopCellId = @"loopCellId";
    [collectionView registerClass:[SKLoopScrollCell class]
       forCellWithReuseIdentifier:loopCellId];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor  whiteColor];
    SKLoopScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:loopCellId forIndexPath:indexPath];

    if(_arrayModal.count == 1){
        SKLoopModel * modal = _arrayModal[0];
        cell.modal = modal;
    }
    else if (_arrayModal.count > 1 && indexPath.row == 0){
        SKLoopModel * modal = _arrayModal[_arrayModal.count - 1];
        cell.modal = modal;
    }
    else if (_arrayModal.count > 1 && indexPath.row == _arrayModal.count + 1){
        SKLoopModel * modal = _arrayModal[0];
        cell.modal = modal;
    }
    else if (_arrayModal.count > 1){
        SKLoopModel * modal = _arrayModal[indexPath.row - 1];
        cell.modal = modal;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_mClickItemBlock){
        SKLoopModel * modal = nil;
        if(_arrayModal.count == 1){
            modal = _arrayModal[0];
        }
        else if (_arrayModal.count > 1 && indexPath.row == 0){
            modal = _arrayModal[_arrayModal.count - 1];
        }
        else if (_arrayModal.count > 1 && indexPath.row == _arrayModal.count + 1){
            modal = _arrayModal[0];
        }
        else if (_arrayModal.count > 1){
            modal = _arrayModal[indexPath.row - 1];
        }
        _mClickItemBlock(modal);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), collectionView.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), self.mCollectView.bounds.size.height);
}

@end
