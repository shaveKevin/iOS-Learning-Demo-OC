//
//  ViewController.m
//  SKLoopScrollView
//
//  Created by shavekevin on 16/7/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SKLoopScrollView.h"
#import "SKLoopModel.h"

@interface ViewController ()

@property (nonatomic, strong)SKLoopScrollView *lunboView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lunboView = [[SKLoopScrollView alloc] init];
//    self.lunboView.frame = CGRectMake(0, 0,CGRectGetWidth([UIScreen mainScreen].bounds), 175);
    
    self.lunboView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_lunboView];
    [self.lunboView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(225);
    }];
    NSArray *imageArray =@[
                           @"http://img3.100bt.com/upload/ttq/20130429/1367242811256_middle.jpg",
                           @"http://img2.100bt.com/upload/ttq/20130115/1358222586398.jpg",
                           @"http://a.hiphotos.baidu.com/zhidao/pic/item/a686c9177f3e670919999ac538c79f3df8dc556b.jpg",
                           @"http://img3.yxlady.com/mt/UploadFiles_5729/20151217/20151217182644542.jpg",
                           @"http://joymepic.joyme.com/article/uploads/allimg/201504/1428994992862419.jpeg",
                           @"http://img0.178.com/acg1/201311/177297514851/177298188475.jpg",
                           @"http://www.aiyingli.com/wp-content/uploads/2015/09/%E4%BA%8C%E6%AC%A1%E5%85%83.jpg",
                           @"http://www.yxzr.com/ueditor/php/upload/image/20151228/1451285658280053.png"
                           ];
    NSMutableArray *modalImageArray =  [NSMutableArray array];
    for (NSInteger i = 0 ; i < imageArray.count; i ++) {
        SKLoopModel *model = [SKLoopModel new];
        model.stringLunBoAttUrl = imageArray[i];
        [modalImageArray addObject:model];
    }
    self.lunboView.arrayModal = modalImageArray;
    [self loadLunBoView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  加载轮播广告位视图
 */

#pragma mark 轮播图
- (void)loadLunBoView
{
    [self.lunboView start];
    self.lunboView.mClickItemBlock = ^(SKLoopModel * lm ){
        
    };
     
}

@end
