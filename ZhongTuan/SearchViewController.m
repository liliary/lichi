//
//  SearchViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/3.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索界面";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

@end
