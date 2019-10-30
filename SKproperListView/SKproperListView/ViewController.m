//
//  ViewController.m
//  SKproperListView
//
//  Created by shaveKevin on 15/7/7.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "ViewController.h"
#import "UIPopoverListView.h"
#import "PopListTableViewCell.h"


@interface ViewController ()<UIPopoverListViewDataSource,UIPopoverListViewDelegate>
@property (nonatomic ,strong) NSArray *classArray;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _classArray = @[@"123",@"xxxxx",@"weweeww",@"123123152"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)settingButtonPressAction:(id)sender {
    
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    if(self.classArray.count<4)
    {
        yHeight = (272.0f - 60*(4 - self.classArray.count));
        
    }
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.allowDismissByTouch = 2;//点列表边上不允许消失
    poplistview.delegate = self;
    poplistview.datasource = self;
    //poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:@"选择"];
    [poplistview show];

}
#pragma mark - UIPopoverListViewDataSource
- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ClassZonePopoverListViewcell";
    PopListTableViewCell *cell = [[PopListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                             reuseIdentifier:identifier] ;
    
    NSUInteger row = indexPath.row;
   // NSDictionary * dict = self.classArray[row];
    cell.redDotLabel.hidden = YES;
    cell.textLabel.text = self.classArray[row];
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return self.classArray.count;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %lu", __func__, indexPath.row);
    NSInteger index = indexPath.row;
//    self.Forward_unit_id = self.classArray[index][@"unit_id"];
//    self.Forward_unit_name = self.classArray[index][@"unit_name"];
//    self.qid = [self.classZoneInfoRequestFunc getQidForUnit_id:_Forward_unit_id];
//    chooseClassFinished = YES;
    
    //设置默认相册
//    [self setDefaultAlbumWithQid:self.qid];
    _contentLabel.text = _classArray[index];
    
}
- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
@end
