//


#import "PopListTableViewCell.h"

@implementation PopListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat xWidth = [UIScreen mainScreen].bounds.size.width - 20.0f;
        self.redDotLabel= [[UILabel alloc]initWithFrame:CGRectMake(xWidth - 20, 5, 15, 15)];
        _redDotLabel.backgroundColor = [UIColor redColor];
        _redDotLabel.textColor = [UIColor whiteColor];
        _redDotLabel.layer.cornerRadius = 8;
        _redDotLabel.textAlignment = NSTextAlignmentCenter;
        _redDotLabel.layer.masksToBounds = YES;
        _redDotLabel.font = [UIFont systemFontOfSize:11];
        //_redDotLabel.adjustsFontSizeToFitWidth = YES;
        _redDotLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_redDotLabel];
    }
    return self;
}
-(void)updateLabelSize
{
    
}

@end
