//
//  SKBeautyENWordCell.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKBeautyENWordCell.h"
#import "SKBeautyENWordModel.h"

static NSString *const cellIdentifier = @"SKBeautyENWordCellIdentifier";

@interface SKBeautyENWordCell ()

@property (nonatomic, strong) UILabel *englishLabel;

@property (nonatomic, strong) UILabel *chineseLabel;

@property (nonatomic, strong) SKBeautyENWordModel *contentModel;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation SKBeautyENWordCell



+ (instancetype)cellWithTableView:(UITableView *)tableview{
    
    SKBeautyENWordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SKBeautyENWordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kCommonRGBColor(244, 245, 248);
        [self setupViews];
        
    }
    return self;
}


- (void)setModel:(SKBeautyENWordModel *)model {
    _model = model;
    self.contentModel = model;
    [self setupData];
    [self setupLayout];

}

- (void)setupViews {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.englishLabel];
    [self.bgView addSubview:self.chineseLabel];
}
- (void)setFrame:(CGRect)frame {
    CGRect newFrame = frame;
    newFrame.size.height -= 10;
    [super setFrame:newFrame];
}

- (void)setupData {
    
    [self.englishLabel setText:self.contentModel.english];
    [self.chineseLabel setText:self.contentModel.chinese];

}
- (void)setupLayout {
    
    
    [self.englishLabel sizeToFit];
    [self.englishLabel setFrame:CGRectMake(5, 15, Device_WIDTH - 30, CGRectGetHeight(self.englishLabel.bounds))];
    [self.chineseLabel sizeToFit];
    [self.chineseLabel setFrame:CGRectMake(5, CGRectGetMaxY(self.englishLabel.frame)+15, Device_WIDTH - 30, CGRectGetHeight(self.chineseLabel.bounds))];
    self.bgView.frame = CGRectMake(10, 10, Device_WIDTH-20, CGRectGetMaxY(self.chineseLabel.frame)+10);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UILabel *)englishLabel {
    if (!_englishLabel) {
        _englishLabel = [[UILabel alloc]init];
        [_englishLabel setFrame:CGRectMake(15, 15, Device_WIDTH - 30, 0)];
        _englishLabel.textColor = kCommonRGBColor(170,170,170);
        _englishLabel.font = [UIFont fontWithName:@"SnellRoundhand-Black" size:20];
        _englishLabel.numberOfLines = 0;
    }
    return _englishLabel;
}

- (UILabel *)chineseLabel {
    if (!_chineseLabel) {
        _chineseLabel = [[UILabel alloc]init];
        [_chineseLabel setFrame:CGRectMake(15, 15, Device_WIDTH - 30, 0)];
        _chineseLabel.textColor = kCommonRGBColor(170,170,170);
        _chineseLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        _chineseLabel.numberOfLines = 0;

    }
    return _chineseLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 2.0f;
        _bgView.clipsToBounds = YES;
        _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BeautyENWordBgImage"]];
    }
    return _bgView;
}
@end
