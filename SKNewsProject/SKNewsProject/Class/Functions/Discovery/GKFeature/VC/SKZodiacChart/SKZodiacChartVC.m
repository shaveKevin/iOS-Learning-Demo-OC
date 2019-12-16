//
//  SKZodiacChartVC.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/15.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKZodiacChartVC.h"

#import "SKZodiacChartView.h"

#import "SKZodiacChartRequest.h"
#import "SKZodiacChartModel.h"
#import "SKZodiacChartResult.h"

@interface SKZodiacChartVC ()

@property (nonatomic, strong) SKZodiacChartView *zodiacChartView;

@property (nonatomic, strong) SKZodiacChartRequest *zodiacChartRequest;

@property (nonatomic, strong) SKZodiacChartModel *zodiacChartModel;

@property (nonatomic, strong) UIScrollView *mainScrollview;
@end

@implementation SKZodiacChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.zodiacChartView];
//    [self.zodiacChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    
    [self.view addSubview:self.mainScrollview];
    self.mainScrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ZodiacChartBg"]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.zodiacChartRequest startCompletionBlockWithProgress:^(NSProgress *progress) {
            //
    } success:^(SKNetworkBaseRequest *request) {
        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        SKZodiacChartRequest *betRequest = (SKZodiacChartRequest *)request;
        
        SKZodiacChartResult *result = (SKZodiacChartResult *)betRequest.result;
        [self dealwithZodiacChartModel:result];
    } failure:^(SKNetworkBaseRequest *request) {
        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

- (void)dealwithZodiacChartModel:(SKZodiacChartResult *)result {
    self.zodiacChartModel = result.model;
    
    UILabel *label = [[UILabel alloc]init];
    
    for (NSInteger i = 0; i <result.showapi_res_body.count; i ++) {
        //
        NSArray *contentArray = [[[result.showapi_res_body allValues] reverseObjectEnumerator] allObjects];
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.numberOfLines = 0;
        contentLabel.text = [NSString stringWithFormat:@"%@",contentArray[i]];
        contentLabel.frame = CGRectMake(10, 0, Device_WIDTH-20, 0);
        [contentLabel sizeToFit];
        if (i == 0) {
            contentLabel.frame = CGRectMake(10, 0, Device_WIDTH-20, CGRectGetHeight(contentLabel.frame));
            label.frame = contentLabel.frame;
        }else {
            
            contentLabel.frame = CGRectMake(10, CGRectGetMaxY(label.frame), Device_WIDTH-20, CGRectGetHeight(contentLabel.frame));
            label.frame = contentLabel.frame;
        }
        [self.mainScrollview addSubview:contentLabel];
        if (i == result.showapi_res_body.count-1) {
            _mainScrollview.contentSize = CGSizeMake(Device_WIDTH, CGRectGetMaxY(contentLabel.frame));
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SKZodiacChartView *)zodiacChartView {
    if (!_zodiacChartView) {
        _zodiacChartView = [[SKZodiacChartView alloc]init];
    }
    return _zodiacChartView;
}

- (SKZodiacChartRequest *)zodiacChartRequest {
    
    if (!_zodiacChartRequest) {
        _zodiacChartRequest = [[SKZodiacChartRequest alloc]init];
    }
    return _zodiacChartRequest;
}
- (UIScrollView *)mainScrollview {
    if (!_mainScrollview) {
        _mainScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Device_WIDTH, Device_HEIGH-64)];
        _mainScrollview.scrollEnabled = YES;
        _mainScrollview.contentSize = CGSizeMake(Device_WIDTH, Device_HEIGH);
    }
    return _mainScrollview;
}

@end
