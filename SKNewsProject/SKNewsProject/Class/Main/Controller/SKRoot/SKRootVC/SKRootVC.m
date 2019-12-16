//
//  ALRootVC.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/10/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKRootVC.h"
#import "SKUITabBarController.h"
@interface SKRootVC ()

@end

@implementation SKRootVC
- (void)loadView {
    [super loadView];
    [self initFontData];
    
}
// 初始化 字号大小
- (void)initFontData {
    
    if ([[SKUserDefault  valueForKey:@"SettingFont"] integerValue] == 0) {
        [kSKAppDelegate setFontFactor:1.1f];
        [SKUserDefault setObject:[NSString stringWithFormat:@"1.1"]
                          forKey:@"SettingFont"];
        [SKUserDefault synchronize];
    } else {
        CGFloat font =   [[SKUserDefault  valueForKey:@"SettingFont"] floatValue];
        [kSKAppDelegate setFontFactor:font];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTabbarVC];
}

- (void)loadTabbarVC{
    _tabBarVC = [[SKUITabBarController alloc] init];
    _tabBarVC.view.frame = self.view.bounds;
    [self addChildViewController:_tabBarVC];
    [self.view addSubview:_tabBarVC.view];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
