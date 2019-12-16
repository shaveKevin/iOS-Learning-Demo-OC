//
//  SKUINavigationController.m
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKUINavigationController.h"

@interface SKUINavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation SKUINavigationController


#pragma mark – life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark – overload
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //1.增加自定义返回键后，手势返回上一级
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)self;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    if (self.childViewControllers.count >= 1) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:YES];
}

/**
 这里返回哪个值，就看你想支持那几个方向了。这里必须和后面plist文件里面的一致。
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

/**
 是否支持转屏
 */
- (BOOL)shouldAutorotate {
    
    return NO;
}

/**
 Status bar 字体白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

/**
 NO：表示要显示
 YES：将hiden
 */
- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

/**
 左滑返回手势处理 如果是topVC 不支持左滑
 
 @param gestureRecognizer 手势
 
 @return 返回是否支持左滑手势
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
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
