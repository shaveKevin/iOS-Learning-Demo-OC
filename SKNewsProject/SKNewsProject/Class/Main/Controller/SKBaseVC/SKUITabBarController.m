//
//  SKUITabBarController.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKUITabBarController.h"
#import "SKUINavigationController.h"
#import "SKHomePageVC.h"
#import "SKMyHomePageVC.h"
#import "SKDiscoveryVC.h"
@interface SKUITabBarController ()

@end

@implementation SKUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SKHomePageVC *homepageVC = [[SKHomePageVC alloc]init];
    SKDiscoveryVC *discoveryVC = [[SKDiscoveryVC alloc]init];
    SKMyHomePageVC *myHomePageVC = [[SKMyHomePageVC alloc]init];

    // 设置tab bar背景
    self.viewControllers = @[[self addChildVc:homepageVC title:@"主页" imageName:@"Tabbar_HomePage" selectedImageName:@"Tabbar_HomePage_Selected"], [self addChildVc:discoveryVC title:@"发现" imageName:@"Tabbar_Discovery" selectedImageName:@"Tabbar_Discovery_Selected"], [self addChildVc:myHomePageVC title:@"我的" imageName:@"Tabbar_My" selectedImageName:@"Tabbar_My_Selected"]];
//    self.tabBar.opaque = YES;
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark – private function
/**
 添加一个子控制器
 
 @param childVc           子控制对象
 @param title             标题
 @param imageName         正常图标
 @param selectedImageName 选中图标
 */
- (SKUINavigationController *)addChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置正常图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置选中时的图标
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 声明这张图片用原图(别渲染)
    if (kIOS7) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    // 设置tabbar字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kCommonRGBColor(115,133,158), NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:kCommonRGBColor(8, 153, 230),NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil]forState:UIControlStateSelected];
    // 添加为tabbar控制器的子控制器
    SKUINavigationController *navgationNC = [[SKUINavigationController alloc] initWithRootViewController:childVc];
    //设置标题
    navgationNC.tabBarItem.title = title;
    //添加子控制器到tabbar
    return navgationNC;
    
}
#pragma mark – UITabBarControllerDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
}

#pragma mark – overload
/**
 这里返回哪个值，就看你想支持那几个方向了。这里必须和后面plist文件里面的一致
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [(UINavigationController *)self.selectedViewController topViewController].supportedInterfaceOrientations;;
}

/**
 是否支持转屏
 */
- (BOOL)shouldAutorotate {
    
    return [(UINavigationController *)self.selectedViewController topViewController].shouldAutorotate;
}


@end
