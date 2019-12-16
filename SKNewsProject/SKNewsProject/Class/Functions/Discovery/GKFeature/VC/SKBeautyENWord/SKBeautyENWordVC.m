//
//  SKBeautyENWordVC.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/15.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKBeautyENWordVC.h"
#import "SKBeautyENWordRequest.h"
#import "SKBeautyENWordResult.h"
#import "SKBeautyENWordTableViewHandle.h"
#import "SKBeautyENWordModel.h"

@interface SKBeautyENWordVC ()
<BeautyENWordTableViewHandleDelegate>

@property (nonatomic, strong) SKBeautyENWordRequest *beautyENWord;

@property (nonatomic, strong) NSMutableArray<SKBeautyENWordModel *> *dataArray;

@property (nonatomic, strong) SKBeautyENWordTableViewHandle *tableViewHandle;


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SKBeautyENWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"英文语录";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, -49));
    }];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.beautyENWord startCompletionBlockWithProgress:^(NSProgress *progress) {
        //
        
    } success:^(SKNetworkBaseRequest *request) {
        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SKBeautyENWordRequest *betRequest = (SKBeautyENWordRequest *)request;
        SKBeautyENWordResult *result = (SKBeautyENWordResult *)betRequest.result;
        [self dealWithBeautyENWordList:result];
        
    } failure:^(SKNetworkBaseRequest *request) {
        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
    
}

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    
}

- (void)dealWithBeautyENWordList:(SKBeautyENWordResult *)result {
    
    if (result.dataArray && result.dataArray.count) {
        [self.dataArray addObjectsFromArray:result.dataArray];
        self.tableViewHandle.items = self.dataArray;
        [self.tableView reloadData];
    }
    else {
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (SKBeautyENWordRequest *)beautyENWord {
    
    if (!_beautyENWord) {
        _beautyENWord = [[SKBeautyENWordRequest alloc]init];
    }
    return _beautyENWord;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}
- (SKBeautyENWordTableViewHandle *)tableViewHandle {
    if (!_tableViewHandle) {
        _tableViewHandle = [[SKBeautyENWordTableViewHandle alloc]init];
        _tableViewHandle.delegate = self;
    }
    return _tableViewHandle;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorColor = kCommonRGBColor(240, 243, 246);
        _tableView.backgroundColor = kCommonRGBColor(244, 245, 248);
        //        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self.tableViewHandle;
        _tableView.dataSource = self.tableViewHandle;
        
    }
    return _tableView;
}


@end
