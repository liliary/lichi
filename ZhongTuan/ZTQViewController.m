//
//  ZTQViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTQViewController.h"
#import "ZTTitleLabel.h"

@interface ZTQViewController (){
    ZTTitleLabel* _titleView;
}
@end

@implementation ZTQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self initViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"中团券"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}
-(void)initViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
}
@end
