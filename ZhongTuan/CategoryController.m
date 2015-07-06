//
//  CategoryController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-27.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "CategoryController.h"
#import "ZTTitleLabel.h"
#import "ZTDropDownSelected.h"

@interface CategoryController ()<UITableViewDataSource,UITableViewDelegate,ZTDropDownSelectedDelegate>{
    /// navigation bar
    ZTTitleLabel *_titleView;
    
    /// selected view
    ZTDropDownSelected *_selectedView;
    
    /// TableView
    UITableView *_tableView;
    
    /// location bar
    UIView *_locationBar;
    UILabel *_locationLabel;
    UIImageView *_locationIcon;
    
    /// data
    NSArray *data;
}
@end

@implementation CategoryController

- (void)viewDidLoad {
    data = @[@{@"key":@"全部分类",@"val":@[@{@"key":@"美食",@"val":@[@"全部",@"自助餐",@"西餐",@"火锅",@"日韩料理",@"粤菜"]},@{@"key":@"电影",@"val":@[@"全部",@"电影团购",@"在线订座"]},@{@"key":@"娱乐",@"val":@[@"全部",@"KTV",@"桑拿",@"按摩",@"酒吧"]},@{@"key":@"酒店",@"val":@[@"全部",@"小时房",@"经济房",@"四星级",@"公寓"]}]},@{@"key":@"全城",@"val":@[@"越秀区",@"天河区",@"荔湾区",@"番禺区",@"海珠区",@"南沙区"]},@{@"key":@"智能排序",@"val":@[@"根据价格排序",@"根据距离排序",@"根据好评排序"]}];
    [super viewDidLoad];
    [self initView];
    self.automaticallyAdjustsScrollViewInsets = NO;

  

}

#pragma mark - build views

-(void)initView{
    self.tabBarController.tabBar.hidden = YES;
    // 去掉tableView bounces 后的上下空隙
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTitleBar];
    [self initSelectedView];
    [self initTableView];
    [self initLocationBar];
    [self layoutViews];
}

-(void)initTitleBar{
    if (nil == _titleText)_titleText = @"分类";
    _titleView = [[ZTTitleLabel alloc] initWithTitle:_titleText];
    [_titleView sizeToFit];
    self.navigationItem.titleView = _titleView;
}

-(void)initSelectedView{
//    _selectedView = [[ZTDropDownSelected alloc] initWithFrame:CGRectMake(0, 0, 320, 20) withData:data];
    _selectedView.ztdelegate = self;
}

-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)initLocationBar{
    /// location view
    long locationBarHeight = 23.5;
    _locationBar = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-locationBarHeight, self.view.bounds.size.width, locationBarHeight)];
    _locationBar.backgroundColor = [UIColor redColor];

    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = [UIFont systemFontOfSize:12.0];
    locationLabel.textColor = [UIColor blackColor];
    locationLabel.text = @"广州市天河区天荣路-天强小区"; //TODO: 测试文字
    
    UIImageView *locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    /// size
    [locationIcon fitSize];
    [locationLabel fitSize];
//    sizeFitAll(@[locationIcon,locationLabel]);
    [self.view addSubViews:@[locationIcon,locationLabel]];
    
    /// position
    [[locationLabel setRectCenterVertical] setRectMarginLeft:10.0];
    [[locationIcon setRectCenterVertical] setRectMarginRight:10.0];
}

-(void)layoutViews{
//    addViews(self.view, @[_tableView,_locationBar,_selectedView]);
    /// size
    [[_selectedView setRectBelowOfView:self.navigationController.navigationBar] setRectHeight:40.0];
    [[[[_tableView setRectBelowOfView:_selectedView] setRectX:0.0] heightToEndWithPadding:0.0] widthToEndWithPadding:0.0];
    
    
}

#pragma mark - tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 33;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    [cell setBottomBorder:1.0 withColor:[UIColor greenColor]];
    return cell;
}

#pragma mark - ZTDropDownSelected delegate

-(CGSize)sizeForSegment{
    return CGSizeMake(320, 40);
}


@end
