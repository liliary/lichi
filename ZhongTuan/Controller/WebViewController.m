//
//  WebViewController.m
//  ZhongTuan
//
//  Created by apple on 15/4/11.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController (){
    UIButton * _backBtn;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setWebView];
    [self initTopBar];
    
}

/**
 *  添加网页View
 */
- (void)setWebView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

/**
 初始化顶部栏
 */
-(void)initTopBar{
    self.navigationItem.title = @"图文详情";
    
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
