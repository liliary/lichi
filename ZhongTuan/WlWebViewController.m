//
//  WlWebViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/20.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "WlWebViewController.h"

@interface WlWebViewController (){
UIButton*_backBtn;

}

@end

@implementation WlWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWebView];
    [self initTopBar];
}
-(void)setWebView{

UIWebView*webview=[[UIWebView alloc]initWithFrame:self.view.bounds];
[self.view addSubview:webview];
NSURL*url=[NSURL URLWithString:self.UrlString];
NSURLRequest*request=[NSURLRequest requestWithURL:url];
[webview loadRequest:request];

}
-(void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];
self.navigationController.navigationBar.hidden=NO;
}
-(void)initTopBar{

self.navigationItem.title=@"物流信息";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
