//
//  SettingViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/1/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
// TODO: 未符合设计图,分成两个session

#import "SettingViewController.h"
#import "ZTTitleLabel.h"
#import "ZTRoundButton.h"
#import "SettingCell.h"
#import "GuideViewController.h"
#import "FeedBackViewController.h"
#import "CopyRightViewController.h"
#import "AlterPaswViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    ZTTitleLabel* _titleView;
    UITableView* _settingSheet;
    UIView *_topLayout;
    UIView *_footer;
    ZTRoundButton *_logoutBtn;
    
    CGFloat _itemCellHeigh;
    
    NSArray *_Items;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self buildViiews];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - layoutViews

-(void)viewDidLayoutSubviews{
    [[[_settingSheet setScreenWidth] setRectBelowOfView:_topLayout ] heightToEndWithPadding:0];
}

-(void)layoutFooterView{
    [[_footer setScreenWidth] setRectHeight:100.0];
    [_footer addSubview:_logoutBtn];
    [[[[[_logoutBtn fitSize] setRectMarginTop:25.0] setRectMarginLeft:75.0] widthToEndWithPadding:75.0] setRectHeight:25.0];
}

#pragma mark - buildViews

-(void)buildViiews{
    // topLaout
    _topLayout = (UIView*)self.topLayoutGuide;
    [self initTableView];
    [self.view addSubview:_settingSheet];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
}

-(void)initTableView{
    _settingSheet = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _settingSheet.delegate = self;
    _settingSheet.dataSource = self;
    _settingSheet.backgroundColor = [UIColor clearColor];
    _settingSheet.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initFooterView];
    _settingSheet.tableFooterView = _footer;
    [_settingSheet registerClass:[SettingCell class] forCellReuseIdentifier:@"cell"];
}

-(void)initFooterView{
    _footer = [UIView new];
    _logoutBtn = [[ZTRoundButton alloc] initWithTitle:@"退出登录" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    [_logoutBtn addTarget:self action:@selector(didSelectLogoutBtn) forControlEvents:UIControlEventTouchUpInside];
    [self layoutFooterView];
}

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"设置"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

#pragma mark - tableviews methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secView = [UIView new];
    secView.backgroundColor = [UIColor clearColor];
    return secView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _itemCellHeigh;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _Items.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subItems = _Items[section];
    return subItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *subItems = _Items[section];
    cell.titleLabel.text = subItems[row];
    cell.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    cell.topBorder = YES;
    if (row+1 == subItems.count) {
        cell.bottomBorder = YES;
    }
    cell.borderWidth = 1.0;
    cell.titleLabel.textColor = [UIColor colorWithHex:0x333333];
    cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    switch ([indexPath section]) {
        case 0:
            [self dispatchSettingItem:row];
            break;
        case 1:
            [self dispatchPublicItem:row];
            break;
    }
}

#pragma mark - onClick Events

// 点击修改密码
-(void)didSelectAlterPasswd{
    [self.navigationController pushViewController:[AlterPaswViewController new] animated:YES];
}

// 点击版权声明
-(void)didSelectCopyRight{
    [self.navigationController pushViewController:[CopyRightViewController new] animated:YES];
}

// 点击意见反馈
-(void)didSelectFeedBack{
    [self.navigationController pushViewController:[FeedBackViewController new] animated:YES];
}

//// 点击检查更新
//-(void)didSelectCheckUpdate{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/zhong-tuanapp/id965513198?mt=8"]];
//}

// 点击关于我们
-(void)didSelectAboutUs{
    [self.navigationController presentViewController:[GuideViewController new] animated:YES completion:nil];
}

// 点击退出登录
-(void)didSelectLogoutBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (token) {
    [[ZTDataCenter sharedInstance] logoutUser:self];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
   }

#pragma mark - helpers
-(void)initData{
    _itemCellHeigh = 30.0;
    _Items = @[
        @[@"修改密码",@"意见反馈"],
        @[@"版权声明",@"关于我们"]
    ];
}

-(void)dispatchSettingItem:(NSInteger)row{
    switch (row) {
        case 0:
            [self didSelectAlterPasswd];
            break;
        case 1:
            [self didSelectFeedBack];
            break;
        default:
            break;
    }
}

-(void)dispatchPublicItem:(NSInteger)row{
    switch (row) {
        case 0:
            [self didSelectCopyRight];
            break;
        case 1:
            [self didSelectAboutUs];
            break;
    }
}


@end
