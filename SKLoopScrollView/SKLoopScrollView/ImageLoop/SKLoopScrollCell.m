//
//  SKLoopScrollCell.m
//  SKLoopScrollView
//
//  Created by shavekevin on 16/7/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//
#import "SKLoopScrollCell.h"
#import "Masonry.h"
#import "SKLoopModel.h"
#import "YYWebImage.h"
@interface SKLoopScrollCell ()
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation SKLoopScrollCell
- (UIImageView *)imageView {
    if(_imageView == nil){
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return _imageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:_modal.stringLunBoAttUrl] placeholder:nil];

}

- (void)setModal:(SKLoopModel *)modal {
    _modal = modal;
    [self setNeedsLayout];
}

@end
