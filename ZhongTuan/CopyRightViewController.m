//
//  CopyRightViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
// TODO: 掌握ios 文字内容排版方面的知识

#import "CopyRightViewController.h"
#import "ZTSessionTitle.h"
#import "ZTContentLabel.h"
#import "ZTTitleLabel.h"
#import "ZTTextContentView.h"

@interface CopyRightViewController(){
    ZTTitleLabel *_titleView;
    UIView *_topLayout;
    
    ZTSessionTitle *_aboutTitle;
    ZTSessionTitle *_contactTitle;
    ZTTextContentView *_aboutContent;
    ZTTextContentView *_contactContent;
}
@end

@implementation CopyRightViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTitleBar];
    [self buildViews];
}

#pragma mark - buildViews

-(void)buildViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    
    _aboutTitle = [[ZTSessionTitle alloc] initWithTitle:@"有关中团网的版权声明:"];
    _aboutTitle.titleInsets = UIEdgeInsetsMake(0, 10.0, 0, 0);
    _aboutTitle.font = [UIFont systemFontOfSize:14.0];
    _aboutTitle.textColor = [UIColor colorWithHex:0x313131];
    _aboutTitle.topBorder = YES;
    _aboutTitle.backgroundColor = [UIColor whiteColor];
    _aboutTitle.borderWidth = 1.0;
    
    _contactTitle = [[ZTSessionTitle alloc] initWithTitle:@"联系方式:"];
    _contactTitle.titleInsets = UIEdgeInsetsMake(0, 10.0, 0, 0);
    _contactTitle.font = [UIFont systemFontOfSize:14.0];
    _contactTitle.textColor = [UIColor colorWithHex:0x313131];
    _contactTitle.backgroundColor = [UIColor whiteColor];
    _contactTitle.topBorder = YES;
    _contactTitle.borderWidth = 1.0;
    
    _aboutContent = [ZTTextContentView new];
    _aboutContent.text = @"中团APP是由中团公司开发出得一款团购APP,所有解释\n权归本公司所有.";
    _aboutContent.textContainerInset = UIEdgeInsetsMake(10, 30.0, 10, 30.0);
    _aboutContent.editable = NO;
    _aboutContent.scrollEnabled = NO;
    _aboutContent.font = [UIFont systemFontOfSize:10.0];
    _aboutContent.textColor = [UIColor colorWithHex:0x656565];
    _aboutContent.topBorder = YES;
    _aboutContent.bottomBorder = YES;
    _aboutContent.borderWidth = 0.5;
    
    _contactContent = [ZTTextContentView new];
    _contactContent.text = @"深圳中团科技有限公司广州分公司\n\n地址: 广州\n\n电话: 020-85584512\n\n传真: 020-85584512\n\n电子邮箱: 2496926991@qq.com\n\n网址: www.teambuy.com.cn";
    _contactContent.contentInset = UIEdgeInsetsMake(0, 30.0, 0, 30.0);
    _contactContent.scrollEnabled = NO;
    _contactContent.editable = NO;
    _contactContent.font = [UIFont systemFontOfSize:10.0];
    _contactContent.textColor = [UIColor colorWithHex:0x656565];
    _contactContent.topBorder = YES;
    _contactContent.bottomBorder = YES;
    _contactContent.borderWidth = 0.5;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.view addSubViews:@[_aboutTitle,_contactTitle,_aboutContent,_contactContent]];
}

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"版权声明"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

#pragma mark - layout views

-(void)viewDidLayoutSubviews{
    [[[[[_aboutTitle fitSize] setScreenWidth] setRectBelowOfView:_topLayout] addRectY:9.0] setRectHeight:35.0];
    [[[_aboutContent fitSize] setScreenWidth] setRectBelowOfView:_aboutTitle];
    [[[[[_contactTitle fitSize] setScreenWidth] setRectBelowOfView:_aboutContent] addRectY:9.0] setRectHeight:35.0];
    [[[_contactContent fitSize] setScreenWidth] setRectBelowOfView:_contactTitle];
}

@end
