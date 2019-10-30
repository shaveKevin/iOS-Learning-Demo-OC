//
//  MenuCell.h
//  SKPopverListView
//
//  Created by shavekevin on 15/12/24.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuListItem;

@interface MenuCell : UITableViewCell

/**
 *
 *  renderCell: 对cell 的渲染
 *  @param item datasource 数据源
 */
- (void)renderCell:(MenuListItem *)item;
@end
