//
//  CommentProudentviewcontroller.m
//  ZhongTuan
//
//  Created by anddward on 15/4/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CommentProudentviewcontroller.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
@interface CommentProudentviewcontroller()<NetResultProtocol>{
ZTTitleLabel*_titleView;

}
@end

@implementation CommentProudentviewcontroller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self initViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
     self.navigationController.navigationBar.hidden = NO;
    [self initData];
    
}
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"评价详情"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;


}
-(void)initViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
   // [self initTableView];
    //[self.view addSubview:_waitListView];
   
}
-(void)initData{

    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMRECM] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];

}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMRECM]]){
        [ZTCoverView dissmiss];}
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMRECM]]) {
        [params addEntriesFromDictionary:@{NET_ARG_SHOPID_GETTMRECM:[NSString stringWithFormat:@"%@",self.shopid],NET_ARG_CPID_GETTMRECM:[NSString stringWithFormat:@"%@",self.tmid],NET_ARG_PAGE_GETTMRECM:@"1",
                                                                   }];
    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMRECM]]) {
        NSLog(@"com%@com",result);
        [ZTCoverView dissmiss];
    }
}
@end
