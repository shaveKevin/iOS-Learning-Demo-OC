//
//  SKBeautyENWordModel.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKBeautyENWordModel.h"

@interface SKBeautyENWordModel()
@property (nonatomic, strong) UILabel *englishLabel;

@property (nonatomic, strong) UILabel *chineseLabel;

@end
@implementation SKBeautyENWordModel

- (CGFloat)cellHeight {
    
    CGFloat cellHeight = 0;
    [self.englishLabel setText:self.english];
    [self.englishLabel sizeToFit];
    cellHeight += (15+CGRectGetHeight(self.englishLabel.bounds));
    
        [self.chineseLabel setText:self.chinese];
    [self.chineseLabel setText:self.chinese];
    [self.chineseLabel sizeToFit];
    cellHeight += (15+CGRectGetHeight(self.chineseLabel.bounds));
    return cellHeight+10;
}

- (UILabel *)englishLabel {
    if (!_englishLabel) {
        _englishLabel = [[UILabel alloc]init];
        _englishLabel.font = [UIFont fontWithName:@"SnellRoundhand-Black" size:20];
        _englishLabel.numberOfLines = 0;
        [_englishLabel setFrame:CGRectMake(15, 15, Device_WIDTH - 30, 0)];

    }
    return _englishLabel;
}

- (UILabel *)chineseLabel {
    if (!_chineseLabel) {
        _chineseLabel = [[UILabel alloc]init];
        _chineseLabel.numberOfLines = 0;
        _chineseLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        [_chineseLabel setFrame:CGRectMake(15, 15, Device_WIDTH - 30, 0)];

    }
    return _chineseLabel;
}

@end
