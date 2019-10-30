//
//  PopverListView.h
//  SKPopverListView
//
//  Created by shavekevin on 15/12/24.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuListItem.h"

@interface PopverListView : UIView
/**
 *  initialization
 *
 *  @param titleArray titleArray   with  titleArray  you can set titleArray which  will present  right side
 *  @param imageArray imageArray   the imagearray  can show us the sort of  MenuListItem  which you present
 *
 *  @return self
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;
/**
 *
 *  when  call this  method    menu  item  will show
 *  animation will show
 */
-(void)showMenuItem;
/**
 *  dismiss MenuItem with animaiton default NO when  you  need  animation  please  choose -(void)dismiss:(BOOL)animate   method instead
 *
 *  @param  animation default is NO
 */
-(void)dismissMenuItem;
/**
 *  dismiss MenuItem  with animaiton default  is NO
 *
 *  @param animated  if you want  animaion you can use this method
 */
-(void)dismissMenuItem:(BOOL)animate;
/**
 *  block which you can  call the method  if you want to do something   with passValues
 *  @param   pass MenuListItem
 *
 */
@property (nonatomic, copy) void (^selectRowAtIndex)(MenuListItem *item);

@end
