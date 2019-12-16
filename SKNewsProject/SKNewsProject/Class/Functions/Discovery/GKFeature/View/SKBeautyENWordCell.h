//
//  SKBeautyENWordCell.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKBeautyENWordModel;
@interface SKBeautyENWordCell : UITableViewCell


@property (nonatomic, strong) SKBeautyENWordModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;


@end
