//
//  MenuCell.m
//  SKPopverListView
//
//  Created by shavekevin on 15/12/24.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#import "MenuCell.h"
#import "MenuListItem.h"
static CGFloat const kDefaultHeight = 20.0f;
static CGFloat const kDefaultLeftPadding = 10.0f;
static CGFloat const kDefaultYPadding = 12.0f;
static CGFloat const kSeperatePadding = 2.0f;
static CGFloat const kDefaulPadding = 1.0f;

@interface MenuCell()

@property(nonatomic, strong) UIImageView *imageViews;
@property(nonatomic, strong) UILabel *titles;

@end

@implementation MenuCell


- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
    }
    return  self;
}
- (void)renderCell:(MenuListItem *)item{
    
    CGRect rect = CGRectMake(kDefaultLeftPadding, kDefaultYPadding, kDefaultHeight, kDefaultHeight);
    self.imageViews.frame = rect;
    self.imageViews.image = item.image;
    self.titles.frame  = CGRectMake(rect.origin.x + rect.size.width + kDefaultYPadding, kSeperatePadding , self.bounds.size.height - (kSeperatePadding *2), self.bounds.size.height - (kSeperatePadding * 2));
    self.titles.text = item.title;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - kDefaulPadding, CGRectGetWidth(self.bounds), kDefaulPadding)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view];
    
}
#pragma mark  - lazy loading -
- (UIImageView *)imageViews {
    if (!_imageViews) {
        
        _imageViews = [[UIImageView alloc]init];
                if ([_imageViews isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_imageViews];
        }
    }
    return _imageViews;
}

- (UILabel *)titles {
    
    if (!_titles) {
        _titles = [[UILabel alloc]init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        _titles.textAlignment = NSTextAlignmentCenter;
        _titles.font = font;
        [_titles setTextColor:UIColorFromRGB(0x333333)];
        if ([_titles isDescendantOfView:self.contentView] == NO) {
            [self.contentView addSubview:_titles];
        }
    }
    return _titles;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
