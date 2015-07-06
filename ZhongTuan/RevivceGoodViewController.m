//
//  RevivceGoodViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/18.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "RevivceGoodViewController.h"
#import "ZTTitleLabel.h"
#import "RevivceGoodTableViewCell.h"
#import "DetailOrderviewcontroller.h"
#import "ZTCoverView.h"
#import "orderInfo.h"
#import "ZTIconButton.h"
#import "WlWebViewController.h"
@interface RevivceGoodViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
ZTTitleLabel*titlelabel;
UITableView*RevivceGoodListView;
NSMutableArray*RevivceGoodarr;
UIView*topview;
}

@end

@implementation RevivceGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initTitleLabel];
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated
{
[super viewWillAppear:animated];
self.navigationController.navigationBar.hidden=NO;
self.tabBarController.tabBar.hidden=YES;
 [self initData];
}
-(void)initTitleLabel{
titlelabel=[[ZTTitleLabel alloc]initWithTitle:@"已收货"];
[titlelabel fitSize];
self.navigationItem.titleView=titlelabel;

}
-(void)initView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self initTableView];
    [self.view addSubview:RevivceGoodListView];

}
-(void)initTableView{
topview=(UIView*)self.topLayoutGuide;
RevivceGoodListView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
RevivceGoodListView.showsHorizontalScrollIndicator=NO;
RevivceGoodListView.showsVerticalScrollIndicator=NO;
RevivceGoodListView.dataSource=self;
RevivceGoodListView.delegate=self;
RevivceGoodListView.backgroundColor=[UIColor clearColor];
RevivceGoodListView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

[RevivceGoodListView registerClass:[RevivceGoodTableViewCell class] forCellReuseIdentifier:@"cell"];

}
-(void)viewDidLayoutSubviews
{
[[[RevivceGoodListView setScreenWidth]setRectBelowOfView:topview]heightToEndWithPadding:0.0];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{return 140.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ RevivceGoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (!cell) {
        cell = [[RevivceGoodTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];//会放入到队列中的
    }
    cell.tagg=@"qqq";

    long row=[indexPath row];
    orderInfo __block*info = RevivceGoodarr[row];
    NSLog(@"sa%@sa",RevivceGoodarr[row]);
    
    cell.delivercom.text=@"中团快运";
    cell.ordernumber.text=@"123456789";
    cell.state.text=@"卖家已发货";
    cell.title.text=@"新款之总和超你比";
    cell.totolprice.text=@"123";
    cell.quantity.text=@"6";
    cell.delivernumber.text=@"987654321";
    
    
    cell.delivernumber.text=info.logno;
    cell.delivercom.text=info.logco;
    cell.ordernumber.text=info.ordno ;
    [cell.pic setImageFromUrl:info.fcppic];
    cell.title.text=info.fcpmc;
    cell.totolprice.text=[info.ordje stringValue];
    cell.quantity.text=[info.ordsl stringValue];


    cell.actionBlock = ^{
        NSLog(@" chakanwuliu");
        WlWebViewController*wuliu=[[WlWebViewController alloc]init];
        // webVc.urlStr = [NSString stringWithFormat:@"http://app.teambuy.com.cn/webc/m/tmlog/id/%d",];
        wuliu.UrlString = [NSString stringWithFormat:@"http://app.teambuy.com.cn/webc/m/tmlog/id/%@",info.logid];
        [self.navigationController pushViewController:wuliu animated:YES];
        
    };

    cell.aactionBlock = ^{
     NSLog(@"go home for pingjia");
             };
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return RevivceGoodarr.count;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//   long row=[indexPath row];
//  DetailOrderviewcontroller *con = [DetailOrderviewcontroller new];
//  orderInfo*orderinfo =RevivceGoodarr[row];
//   con.oederdetail=orderinfo.ordno;
// [self.navigationController pushViewController:con animated:YES];
//}




-(void)initData{

    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];
}

#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
[ZTCoverView dissmiss];
[RevivceGoodListView reloadData];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
alertShow(errmsg);
[ZTCoverView dissmiss];

}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[NSNumber numberWithInt:2]}];
    }

}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]])
    {
        NSArray *orderaaaaaaas = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
        
        RevivceGoodarr=[NSMutableArray array];
        [RevivceGoodarr removeAllObjects];
        [RevivceGoodarr addObjectsFromArray:orderaaaaaaas];
        
        NSLog(@"dai%@daishouhuo",RevivceGoodarr);}


}

@end
