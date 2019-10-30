//
//  ViewController.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/13.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "ViewController.h"
#import "SKOnlinePlayVC.h"
#import "SKDownloadPlayVC.h"
#import <Masonry/Masonry.h>

static NSString *const cellIdentifier = @"cellIdentifier";

@interface ViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@property (nonatomic, assign) NSInteger seleceIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];

}
- (void)initData {
    
    self.title = @"m3u8视频播放下载Demo";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    self.seleceIndex = 0;
    [self addCellText:@"在线播放" classIdentifier:@"segueForSKOnlinePlayVC"];
    [self addCellText:@"下载播放" classIdentifier:@"segueForSKDownloadPlayVC"];

    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    self.seleceIndex = indexPath.row;
    [self performSegueWithIdentifier:className sender:nil];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)addCellText:(NSString *)title classIdentifier:(NSString *)classIdentifierName {
    [self.titles addObject:title];
    [self.classNames addObject:classIdentifierName];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [UIView new];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _tableView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        UIViewController *vc = [segue destinationViewController];
        vc.title = _titles[self.seleceIndex];
}
@end
