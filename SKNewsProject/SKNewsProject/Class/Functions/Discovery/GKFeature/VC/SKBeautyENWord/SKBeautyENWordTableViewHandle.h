//
//  SKBeautyENWordTableViewHandle.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/14.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKBeautyENWordModel;
@protocol BeautyENWordTableViewHandleDelegate <NSObject>
/* **/
- (void)tableViewDidSelect:(NSIndexPath *)indexPath;

@end
@interface SKBeautyENWordTableViewHandle : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray<SKBeautyENWordModel *> *items;

@property (nonatomic, weak) id <BeautyENWordTableViewHandleDelegate> delegate;

@end

