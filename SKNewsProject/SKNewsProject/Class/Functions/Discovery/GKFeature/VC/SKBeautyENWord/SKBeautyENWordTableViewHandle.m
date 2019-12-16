//
//  SKBeautyENWordTableViewHandle.m
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKBeautyENWordTableViewHandle.h"
#import "SKBeautyENWordCell.h"
#import "SKBeautyENWordModel.h"
@implementation SKBeautyENWordTableViewHandle

#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.items.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kCommonRGBColor(246, 247, 249);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKBeautyENWordModel *model = self.items[indexPath.row];
    return model.cellHeight+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKBeautyENWordCell *cell = [SKBeautyENWordCell cellWithTableView:tableView];
    cell.model = self.items[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewDidSelect:)]) {
        [self.delegate tableViewDidSelect:indexPath];
    }
}

@end
