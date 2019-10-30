//
//  RootViewController.m
//  Xibbbbbbbbb
//
//  Created by shavekevin on 16/4/15.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "RootViewController.h"
#import "MMPlaceHolder.h"
#import "FirstViewController.h"
@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"xib storyboard 布局视图";
    [self loadLeftButton];
    [self.blackView showPlaceHolder];
    [self.yellowView showPlaceHolder];
    [self.blueView showPlaceHolder];
    [self.redView showPlaceHolder];
}


-(void)loadLeftButton {
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 100, 40);
    [leftButton setBackgroundColor:[UIColor blueColor]];
    [leftButton setTitle:@"点击跳转" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(pushToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.layer.cornerRadius = 2.0f;
    leftButton.clipsToBounds = YES;
    UIBarButtonItem *leftBarButtonItems = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    //解决按钮不靠左 靠右的问题.
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, leftBarButtonItems];
}

- (void)pushToNextVC:(id)sender {
    
    FirstViewController *firstVC = [FirstViewController new];
    [self.navigationController pushViewController:firstVC animated:YES];
    
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
