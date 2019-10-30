//
//  ViewController.m
//  AllTextLabel
//
//  Created by shavekevin on 16/7/18.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "YYText.h"
#import "SVGKit.h"
#import "SKUILabel.h"
@interface ViewController ()
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) SKUILabel *contentLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str =  @"Live this moment with a smile. It brings cheers. Life only comes around once. So make sure you're spending it the right way, with the right onesTo the world you may be one person, but to one person you may be the world. No man or woman is worth your tears, and the one who is, won't make you cry. Never frown, even when you are sad, because you never know who is falling in love with your smile.We met at the wrong time, but separated at the right time. The most urgent is to take the most beautiful scenery; the deepest wound was the most real emotions.";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:str];
    ///  设置行间距
    attri.yy_lineSpacing = 0.0f;
    self.label.attributedText = attri;
    self.label.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds)- 20;
    self.label.font = [UIFont systemFontOfSize:20];
    self.label.textColor = [UIColor orangeColor];
    self.label.numberOfLines = 3;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [self addSeeMoreButton];
    UIImageView *image = [[UIImageView alloc]init];
    SVGKImage *imageCS = [SVGKImage imageNamed:@"最热"];
    image.image = imageCS.UIImage;
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
    }];
    
    NSString *contentStr =  @"豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。";
    [self.view addSubview:self.contentLabel];
    [self.contentLabel setText:contentStr andlineSpace:5.0f andWordSpace:5.0f];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);

    }];

}

- (SKUILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [SKUILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor redColor];
    }
    return  _contentLabel;
}
- (void)addSeeMoreButton {
    __weak typeof(self) _self = self;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        YYLabel *label = _self.label;
        label.numberOfLines = 0;
    };
    [text yy_setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"全文"]];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"全文"]];
    text.yy_font = _label.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
    _label.truncationToken = truncationToken;
}

- (YYLabel *)label {
    if (!_label) {
        _label = [YYLabel new];
        [self.view addSubview:_label];
    }
    return _label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
