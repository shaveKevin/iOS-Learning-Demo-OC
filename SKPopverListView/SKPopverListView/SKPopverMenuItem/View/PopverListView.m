//
//  PopverListView.m
//  SKPopverListView
//
//  Created by shavekevin on 15/12/24.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//



#import "PopverListView.h"
#import "MenuCell.h"

static CGFloat const kDefaultPadding = 0;
static CGFloat const kDefaultTime = 0.0f;
static CGFloat const kDefaultTime1 = 0.1f;
static CGFloat const kDefaultTime2 = 0.2f;
static CGFloat const kDefaultTime3 = 0.3f;
static CGFloat const kDefaultTime4 = 0.08f;
static CGFloat const kDefaultTime5 = 1.05f;
static CGFloat const kDefaultCellHeight = 44.0f;
static CGFloat const kArrowHeight = 10.f;
static CGFloat const kDefaultNavHeight = 64.0f;
static CGFloat const kcornerRadius = 2.0f;
static  NSString *cellIdentifier = @"MenuCell";

@interface PopverListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *menuItems;
@property (nonatomic) CGRect rect;

@property (nonatomic, strong) UIView *handerView;
@property (nonatomic, strong) UIButton *belowHandlerView;
@property (nonatomic, strong) UIButton *upHandlerView;

@property(nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) UIColor *borderColor;

@end

@implementation PopverListView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderColor = RGB(0, 0, 0);
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.tableview.frame = self.bounds;
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray {
    
    if (self = [super init]) {
        
        _titleArray = [[NSMutableArray alloc]initWithCapacity:0];
        _imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        _menuItems = [[NSMutableArray alloc]initWithCapacity:0];
        [_titleArray addObjectsFromArray:titleArray];
        [_imageArray addObjectsFromArray:imageArray];
        [self setMenuItemContents];
        self.borderColor = RGB(0, 0, 0);
        self.tableview.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kcornerRadius;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setMenuItemContents {

    for (NSInteger i = 0 ; i < _titleArray.count; i ++) {
        MenuListItem *item = [[MenuListItem alloc]init];
        item.title = _titleArray[i];
        NSString *imag = _imageArray[i];
        item.image = [UIImage imageNamed:imag];
        item.selectIndex = i;
        [_menuItems addObject:item];
    }
    
}
#pragma mark  -  show Or Dismiss menuItem
//show
-(void)showMenuItem {
    
    [self showMenuItem:YES];
    
}

- (void)showMenuItem:(BOOL)animate {
    //根据顺序添加
    self.handerView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //window 大的视图
    [_handerView setBackgroundColor:[UIColor clearColor]];
    //黑色背景
    _belowHandlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = CGRectMake(kDefaultPadding, kDefaultNavHeight , CGRectGetWidth([UIScreen mainScreen].bounds) , CGRectGetHeight([UIScreen mainScreen].bounds) - kDefaultNavHeight);
    [_belowHandlerView setFrame:rect];
    [_belowHandlerView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.2]];
    [_belowHandlerView addTarget:self action:@selector(dismissMenuItem) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:_belowHandlerView];
    //window 大的button
    self.upHandlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upHandlerView setFrame:CGRectMake(kDefaultPadding, kDefaultPadding, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    [_upHandlerView setBackgroundColor:[UIColor clearColor]];
    [_upHandlerView addTarget:self action:@selector(dismissMenuItem) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:_upHandlerView];
    [_handerView addSubview:self];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_handerView];
    //加动画
    if (animate) {
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeScale(kDefaultTime1, kDefaultTime1);
        [UIView animateWithDuration:kDefaultTime2 delay:kDefaultTime options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(kDefaultTime5, kDefaultTime5);
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:kDefaultTime4 delay:kDefaultTime options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:nil];
            
        }];
    }
    
}
// dismiss
-(void)dismissMenuItem {
    
    [self dismissMenuItem:NO];
}

-(void)dismissMenuItem:(BOOL)animate {
    
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:kDefaultTime3 animations:^{
        
        self.transform = CGAffineTransformMakeScale(kDefaultTime1, kDefaultTime1);
        self.alpha = kDefaultTime;
        
        
    } completion:^(BOOL finished) {
        
        [_handerView removeFromSuperview];
        
    }];
    
}

#pragma mark - UITableView  datasource & delegate -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    
    return _menuItems.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return kDefaultCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MenuListItem *item = [_menuItems objectAtIndex:indexPath.row];
    [cell renderCell:item];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuListItem *item = [_menuItems objectAtIndex:indexPath.row];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(item);
    }
    
    [self dismissMenuItem:YES];
    
}
#pragma mark  - drawrect
- (void)drawRect:(CGRect)rect
{
    [self.borderColor set]; //设置线条颜色
    CGRect frame = CGRectMake(kDefaultPadding, kDefaultPadding, self.bounds.size.width, self.bounds.size.height - kArrowHeight);
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(xMin, yMin)];//左上角
    [popoverPath addLineToPoint:CGPointMake(xMax, yMin)];//右上角
    [popoverPath addLineToPoint:CGPointMake(xMax, yMax)];//右下角
    [popoverPath addLineToPoint:CGPointMake(xMin, yMax)];//左下角
    //填充颜色
    [RGB(0, 0, 0) setFill];
    [popoverPath fill];
    [popoverPath closePath];
    [popoverPath stroke];
}
#pragma  mark  - lazy loading -

- (UITableView *)tableview {
    
    if (!_tableview ) {
        _tableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[MenuCell class] forCellReuseIdentifier:cellIdentifier];
        [self addSubview:_tableview];
    }
    return _tableview;
}
@end
