//
//  FirstVC.m
//  SKPopverListView
//
//  Created by shavekevin on 15/12/24.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#import "FirstVC.h"
#import "PopverListView.h"
#import "SKPopveMenuConfig.h"
static CGFloat const kDefaultWidth = 30.0f;
static CGFloat const kDefaultLeftPadding = 0.0f;
static CGFloat const kDefaultHeight = 44.0f;

@interface FirstVC ()

@property (nonatomic, strong) PopverListView *popverListView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end


@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithData];
    [self showTabBarItem];
    self.title = firstVCtitleStr;
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark  - initWithData
- (void)initWithData {
    
    _titleArray = [[NSMutableArray alloc]initWithCapacity:0];
    _imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    [_titleArray addObjectsFromArray:@[@"第一个",@"第二个",@"第三个"]];
    [_imageArray addObjectsFromArray:@[@"FirstPage",@"SecondPage",@"ThirdPage"]];
    
}

#pragma mark -菜单
//弹出菜单
-(void)showTabBarItem{
    
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setTitle:@"左" forState:UIControlStateNormal];
    leftBarButton.backgroundColor = [UIColor orangeColor];
    leftBarButton.frame = CGRectMake(kDefaultLeftPadding, kDefaultLeftPadding, kDefaultWidth, kDefaultWidth);
    [leftBarButton addTarget:self action:@selector(setPopoverListMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
    self.navigationItem.rightBarButtonItems = @[leftBarButtonItem];
}
//使用方法  创建一个实例变量 初始化的时候 给 titlle 和image 进行赋值 然后设置frame  然后show 就可以了
-(void)setPopoverListMenu{
    
    __weak __typeof(self)weakSelf = self;
    _popverListView = [[PopverListView alloc]initWithTitleArray:_titleArray imageArray:_imageArray];
    _popverListView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 200,70 , 195,_titleArray.count *kDefaultHeight);
    _popverListView.selectRowAtIndex = ^(MenuListItem *item){
        [weakSelf pushMenuItems:item];
    };
    [_popverListView showMenuItem];
    
}

- (void)pushMenuItems:(MenuListItem *)item {
    
    switch (item.selectIndex) {
        case 0:{
            NSLog(@"第一");
        }
            break;
        case 1: {
            NSLog(@"第二");

        }
            break;
        case 2: {
            NSLog(@"第三");
        }
            break;
        default:
            break;
    }
    
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
