//
//  SKHomePageVC.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKHomePageVC.h"
#import "NSString+MD5Methods.h"

@interface SKHomePageVC ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation SKHomePageVC
- (void)loadView {
    [super loadView];
   self.label= [[UILabel alloc]init];
    self.label.backgroundColor = [UIColor redColor];
    [self.label setTextColor:[UIColor orangeColor]];
    self.label.numberOfLines = 0;
    self.label.font = Font_Hei(14);
    self.label.text = @"这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo这是一个测试的demo";
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(100);
    }];
    UIPinchGestureRecognizer *ping = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pingClick:)];
    [self.view addGestureRecognizer:ping];
}

- (void)pingClick:(UIPinchGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSString *fontNum = [SKUserDefault  objectForKey:@"SettingFont"];
            if (gesture.velocity > 0) {
            
            if ([fontNum isEqualToString:@"1.0"]) {
                fontNum = @"1.1";
            }else if ([fontNum isEqualToString:@"1.1"]){
                fontNum = @"1.2";
            }else if ([fontNum isEqualToString:@"1.2"]){
                fontNum = @"1.3";
            }else if ([fontNum isEqualToString:@"1.3"]){
                fontNum = @"1.4";

            }else{
            }
            
        }else if(gesture.velocity < 0){
            
            if ([fontNum isEqualToString:@"1.4"]) {
                fontNum = @"1.3";
            }else if ([fontNum isEqualToString:@"1.3"]){
                fontNum = @"1.2";
            }else if ([fontNum isEqualToString:@"1.2"]){
                fontNum = @"1.1";
            }else if ([fontNum isEqualToString:@"1.1"]){
                fontNum = @"1.0";
            }else{
            }

        }
        
        [kSKAppDelegate setFontFactor:[fontNum floatValue]];
        [SKUserDefault  setObject:[NSString stringWithFormat:@"%@",fontNum] forKey:@"SettingFont"];
        [SKUserDefault  synchronize];
        // 这里的fontNum 可以直接改成缩放因子
        self.label.font = Font_Hei(14);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"SKNewsProject";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
