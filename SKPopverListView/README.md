
# SKPopverListView
类似于微信右上角+号弹出view


使用方法：

//创建一个实例变量 初始化的时候 给 titlle 和image 进行赋值 然后设置frame  然后show 就可以了

-(void)setPopoverListMenu  {

    __weak __typeof(self)weakSelf = self;
    _popverListView = [[PopverListView alloc]initWithTitleArray:_titleArray imageArray:_imageArray];
    _popverListView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 200,70 , 195,_titleArray.count *44);
    _popverListView.selectRowAtIndex = ^(MenuListItem *item){
        [weakSelf pushMenuItems:item];
    };
    [_popverListView showMenuItem];
    
}

//然后下面是回调方法

-(void)pushMenuItems:(MenuListItem *)item {

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
