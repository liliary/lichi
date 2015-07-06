//
//  TestViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/1/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"
#import "ZTCoverView.h"
#import "ZTTiView.h"
#import "ZTTitleLabel.h"
#import "ZTIconLabel.h"
#import "ZTStarBar.h"
#import "ZTItemButton.h"
#import "ZTCheckButton.h"
#import "UIView+ZTFundationAddiction.h"
#import "ZTChoiceItem.h"

@interface TestViewController (){
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    // TODO: 测试sizetofit 的作用
    [super viewDidLoad];
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor redColor];
//    [[[v setScreenWidth] setRectHeight:20.0] addRectY:200.0];
    UILabel *lbb = [UILabel new];
    lbb.text = @"jaojfojejoajioefji";
    [lbb sizeToFit];
    [v addSubview:lbb];
    [self.view addSubview:v];
}

-(void)viewDidLayoutSubviews{
}

@end
