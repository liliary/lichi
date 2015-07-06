//
//  MysuggestViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/18.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "MysuggestViewController.h"
#import "ZTTitleLabel.h"
#import "ZTTextContentView.h"
#import "ZTCoverView.h"
@interface MysuggestViewController ()<NetResultProtocol>{
ZTTitleLabel *titleview;
ZTTextContentView*content;
UIView*topview;
UIButton*suggestbtn;
}
@end

@implementation MysuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self initView];
    
}
-(void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}
-(void)initTitleBar{
titleview=[[ZTTitleLabel alloc]initWithTitle:@"客户反馈"];
[titleview fitSize];
self.navigationItem.titleView=titleview;
}
-(void)initView{
self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
content=[[ZTTextContentView alloc]init];
content.topBorder=YES;
content.rightBorder=YES;
content.leftBorder=YES;
content.bottomBorder=YES;
//content.backgroundColor=[UIColor redColor];
topview=(UIView*)self.topLayoutGuide;
NSLog(@"%@gggg",topview);


UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapNonInput:)];
    [self.view addGestureRecognizer:tapGeture];
    
suggestbtn=[[UIButton alloc]init];
suggestbtn.backgroundColor=[UIColor redColor];
suggestbtn.layer.cornerRadius=15;
[suggestbtn setTitle:@"提交建议" forState: UIControlStateNormal];
    [suggestbtn addTarget:self action:@selector(Tapsuggest:) forControlEvents:UIControlEventTouchUpInside];
topview.backgroundColor=[UIColor blueColor];
[self.view addSubViews:@[content,topview,suggestbtn]];


}
-(void)viewDidLayoutSubviews
{

  CGFloat with=self.view.bounds.size.width;
  
[[[[content setRectMarginLeft:(with-240)/2]setRectWidth:240] heightToEndWithPadding:210]setRectMarginTop:150];
//setRectBelowOfView:topview]addRectY:20];
//[[[[content setRectWidth:300]heightToEndWithPadding:120]setRectBelowOfView:topview]addRectY:20];
[[[[[suggestbtn setRectWidth:80]setRectHeight:30]setRectCenterHorizentail] setRectBelowOfView:content]addRectY:20];
}
#pragma mark click
-(void)didTapNonInput:(UITapGestureRecognizer*)tapGesture{
    [content resignFirstResponder];
    }
-(void)Tapsuggest:(UIButton*)sender{
[[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_FEEDBACK] delegate:self cancelIfExist:YES];
[ZTCoverView alertCover];
}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
[ZTCoverView dissmiss];
[self.navigationController popViewControllerAnimated:YES];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
alertShow(errmsg);
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_FEEDBACK]]) {
        [params addEntriesFromDictionary:@{NET_ARG_FEEDBACK:[NSString stringWithFormat:@"%@", content.text] ,}];
    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
[ZTCoverView dissmiss];
NSLog(@"gggggg%@",result);
}

@end
