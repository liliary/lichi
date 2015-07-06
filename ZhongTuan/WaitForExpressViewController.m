//
//  WaitForExpressViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "WaitForExpressViewController.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
#import "WaitForExpressCell.h"
#import "orderInfo.h"
#import "DetailOrderviewcontroller.h"
#import "WlWebViewController.h"
@interface WaitForExpressViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
    ZTTitleLabel* _titleView;
    UITableView *_waitListView;
    NSMutableArray*waitarr;
    UIView* _topLayout;
    NSString*dingdan;
}

@end

@implementation WaitForExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self initData];

}
-(void)initData{
    
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];
}
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"待收货"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

-(void)initViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self initTableView];
    [self.view addSubview:_waitListView];
}
-(void)initTableView{
 _topLayout = (UIView*)self.topLayoutGuide;
    _waitListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _waitListView.showsHorizontalScrollIndicator = NO;
    _waitListView.showsVerticalScrollIndicator = NO;
    _waitListView.delegate = self;
    _waitListView.dataSource = self;
    _waitListView.backgroundColor = [UIColor clearColor];
    _waitListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    NSLog(@"qunima");

    
    [_waitListView registerClass:[WaitForExpressCell class] forCellReuseIdentifier:@"cell"];
    
}
-(void)viewDidLayoutSubviews{
    
    [[[_waitListView setScreenWidth] setRectBelowOfView:_topLayout] heightToEndWithPadding:0.0];
    
}

#pragma mark - tableview Delegate
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WaitForExpressCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    long row=[indexPath row];
    orderInfo __block*info = waitarr[row];
    NSLog(@"sa%@sa",waitarr[row]);
    
    
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
        UIAlertView*deleaddress=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认收货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil, nil];
        dingdan=info.ordno;
        NSLog(@"ahah%@",dingdan);
        [deleaddress show];

    };
    return  cell;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
    
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS] delegate:self cancelIfExist:YES];
            
            break;
            
        default:
            NSLog(@"取消1");
            break;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return waitarr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    long row=[indexPath row];
    DetailOrderviewcontroller *con = [DetailOrderviewcontroller new];
    orderInfo*orderinfo =waitarr[row];
    con.oederdetail=orderinfo.ordno;
    [self.navigationController pushViewController:con animated:YES];
    
    
}

#pragma mark - net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
// if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS]])
// {[self initData];
// }
    [ZTCoverView dissmiss];
    [_waitListView reloadData];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
    alertShow(errmsg);
    [ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT:[NSNumber numberWithInt:4]}];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ORDRECGOODS]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDNO_ORDRECGOODS:[NSString stringWithFormat:@"%@",dingdan]}];
    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]])
    {
    NSArray *orderaaaaaaas = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
    
    waitarr=[NSMutableArray array];
    [waitarr removeAllObjects];
    [waitarr addObjectsFromArray:orderaaaaaaas];
    
        NSLog(@"dai%@daishouhuo",waitarr);}

    
}
@end
