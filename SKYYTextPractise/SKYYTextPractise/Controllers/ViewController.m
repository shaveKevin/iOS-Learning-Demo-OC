//
//  ViewController.m
//  SKYYTextPractise
//
//  Created by shavekevin on 16/6/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ViewController.h"
/// 解析html 的类库.
#import "TFHpple.h"
///  富文本
#import "YYText.h"
///   masonry布局
#import "Masonry.h"

#import "Entity.h"
#import "SKRangeModel.h"

//  show  alert
#import "LGAlertView.h"

/// 转化html代码为可识别的字符串
#import "NSString+HTML.h"

/// 加载svg 的图片

#import "UIImage+SVG.h"

@interface ViewController ()
///  源字符串
@property (nonatomic, copy) NSString *tempStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"    解析标签     ";
    //  设置坐标从0 开始计算
    self.navigationController.navigationBar.translucent = NO;
    [self yyLabelExample];
    [self svgViewExample];
}
- (void)yyLabelExample {
    YYLabel *label = [YYLabel new];
    label.textAlignment = NSTextAlignmentLeft;
    //label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth =  CGRectGetWidth([UIScreen mainScreen].bounds);
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    NSMutableAttributedString *attStr = [self str];
    attStr.yy_font = [UIFont systemFontOfSize:20];
    label.attributedText = attStr;
}
- (void)svgViewExample{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.image = [UIImage imageWithSVGNamed:@"最热" targetSize:CGSizeMake(100, 100) fillColor:[UIColor redColor]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];

}
- (NSMutableAttributedString *)str {
    
    _tempStr = @"北京事儿 @王岩<a href=test>@王岩 </a>想跑：5月20日晚，中国人民大学一名刚上大一的男生向另一男生表白，<a href=256>@里啊啊 </a>摆了个心形的蜡烛，两人站在里面热烈拥吻。。。好浪漫啊，祝幸福.<a href=1990>@北京站 </a>【坐地铁 逛北京】世界最大玻璃观景平台——位于北京市平谷区的石林峡景区的钛合金飞碟玻璃观景台，采用独特设计原理，<a href=678>@北京地铁 </a>将钛合金、合金钢、拉索和防弹玻璃相结合，重量只是传统钢结构的50%，强度却超过其两倍。“平台”距市区较远，除了自驾，也可乘地铁15号线至俸伯换乘公交前往。<a href=1419532934039>@Krunoslav Margi&#263; </a> <a href=1419532920781>@fangjingwu </a> <a href=1419532989395>@Luiz Alberto Chanam? </a> <a href=1419532911714>@Yao Hongchun </a> <a href=1419532951396>@Prof. Vinay Saraph </a> <a href=1419532909170>@maqinliang </a> <a href=1419532919916>@wenxuejian </a> <a href=1419532934039>@Krunoslav Margi&#263; </a> <a href=1419532942796>@James W. Ogilvie </a> <a href=1419532930654>@qindating </a> <a href=1419532909431>@yong </a> <a href=1419532916635>@Renguo XIE </a> <a href=1449819750702>@ShaveKevin </a> <a href=1419532909811>@wangqiang </a> <a href=1451271967030>@田Ÿ˜ 	‘€@¥@^_^&¥¥ </a>";

    _tempStr = [_tempStr stringByDecodingHTMLEntities];
    NSArray *arrays = [_tempStr componentsSeparatedByString:@"</a>"];
    NSMutableArray *beginingArray = [NSMutableArray array];
    NSMutableArray *replaceArray = [NSMutableArray array];
    NSMutableArray *urlArray = [NSMutableArray array];
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString *tempStr1 = _tempStr;
    NSData *htmlData = [tempStr1 dataUsingEncoding:NSUTF8StringEncoding];
    //使用第三方（TFHpple）将html类型的数据转换为TFHpple类型
    TFHpple * doc = [TFHpple hppleWithHTMLData:htmlData];
    NSArray *array = [doc searchWithXPathQuery:@"//a"];
    for (NSInteger i = 0 ; i < array.count; i ++) {
        TFHppleElement * element = [array objectAtIndex:i];
        NSString *result = [[element.raw stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        //  解析标签容错
        result = [result  stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        [beginingArray addObject:result];
        [replaceArray addObject:element.text];
        Entity *entry = [[Entity alloc]init];
        entry.message = element.text;
        entry.testID = [element objectForKey:@"href"];
        [urlArray addObject:entry];
    }
    for (NSInteger i = 0; i < replaceArray.count; i ++) {
        NSString *beginStr = beginingArray[i];
        NSString *replaceStr = replaceArray[i];
        NSLog(@"---beginStr---%@",beginStr);
        NSLog(@"---replaceStr----%@",replaceStr);

        _tempStr = [_tempStr stringByReplacingOccurrencesOfString:beginStr withString:replaceStr];
    }
    NSString *totalStr = @"";
    NSString *tempStr = @"";
    // 找到rangearray 然后就可以添加事件了
    for (NSInteger i = 0 ; i < arrays.count - 1; i ++) {
        NSString *str = arrays[i];
        str =  [str substringToIndex:str.length];
        NSString *beginStr = beginingArray[i];
        beginStr = [beginStr substringToIndex:beginStr.length-4];
        NSString *replaceStr = replaceArray[i];
        if (i == 0) {
            NSRange range = [str rangeOfString:beginStr];
            SKRangeModel *model = [SKRangeModel new];
            model.strLenth = replaceStr.length;
            model.strLocation = range.location;
            [rangeArray addObject:model];
        }
        else {
            NSRange range = [totalStr rangeOfString:beginStr];
            SKRangeModel *model = [SKRangeModel new];
            model.strLenth = replaceStr.length;
            model.strLocation = range.location;
            [rangeArray addObject:model];
        }
        
        str = [str stringByReplacingOccurrencesOfString:beginStr withString:replaceStr];
        tempStr = [tempStr stringByAppendingString:str];
        totalStr = tempStr;
        if (i < arrays.count-1) {
            NSInteger num = i +1;
            totalStr = [totalStr stringByAppendingString:arrays[num]];
        }
        if (i == (arrays.count -2)) {
            NSString *gogogo = arrays[arrays.count -1];
            totalStr = [totalStr stringByAppendingString:gogogo];
            tempStr = [tempStr stringByAppendingString:gogogo];
        }
        
        NSLog(@"----  i is  %ld    totalStr  is   %@",(long)i,totalStr);
        
        NSLog(@"----  i is  %ld    tempStr  is   %@",(long)i,tempStr);
    }
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:tempStr];
        //设置字体大小
        one.yy_font = [UIFont boldSystemFontOfSize:15];
        // 设置整体的字体颜色
        one.yy_color = [UIColor orangeColor];
        // 设置指定位置字符串的颜色
       // [one yy_setColor:[UIColor redColor] range:NSMakeRange(0, 4)];// attribuateStrRangeColor
        /// 2. or you can use the convenience method
        for (NSInteger i = 0; i < rangeArray.count; i ++) {
            SKRangeModel *model = rangeArray[i];
            NSRange range = NSMakeRange(model.strLocation , model.strLenth);
            [one yy_setTextHighlightRange:range
                                    color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                    Entity *en = urlArray[i];
                                    [self showMessage:en.testID];
                                    
                                }];
        }
        
        [text appendAttributedString:one];
    }
    return text;
    
}
- (void)showMessage:(NSString *)msg {
    
    [[[LGAlertView alloc] initWithTitle:@"ID"
                                message:msg
                                  style:LGAlertViewStyleAlert
                           buttonTitles:nil
                      cancelButtonTitle:@"取消"
                 destructiveButtonTitle:@"确定"
                          actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                              NSLog(@"actionHandler, %@, %lu", title, (long unsigned)index);
                          }
                          cancelHandler:^(LGAlertView *alertView) {
                              NSLog(@"cancelHandler");
                          }
                     destructiveHandler:^(LGAlertView *alertView) {
                         NSLog(@"destructiveHandler");
                     }] showAnimated:YES completionHandler:nil];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
