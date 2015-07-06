//
//  PayedViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "PayedViewController.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
#import "NoPayCell.h"
#import "orderInfo.h"
#import "DetailOrderviewcontroller.h"

@interface PayedViewController ()<NetResultProtocol,UITableViewDataSource,UITableViewDelegate>{
    UIView *_topLayout;
    ZTTitleLabel*_belowtitleview;
    ZTTitleLabel* _titleView;
    UITableView *_nopayListView;
    //paylist
    NSMutableArray *nopaylist;
    //data
    NSMutableArray *_orderarr;
}

@end

@implementation PayedViewController

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

    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"已支付"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}
-(void)initViews{
   // _topLayout = (UIView*)self.topLayoutGuide;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    //self.topview=[[UIView alloc]init];
    //self.topview.backgroundColor=[UIColor clearColor];
    //_belowtitleview = [[ZTTitleLabel alloc] initWithTitle:@"特卖已支付订单"];
    //[_belowtitleview fitSize];
    
    //[self.topview addSubview:_belowtitleview];
    self.navigationItem.titleView = _titleView;
    [self initTableView];
    //[self.view addSubview:self.topview];
    [self.view addSubview:_nopayListView];
    
}
-(void)initTableView{
_nopayListView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
   // _nopayListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _nopayListView.showsHorizontalScrollIndicator = NO;
    _nopayListView.showsVerticalScrollIndicator = NO;
    _nopayListView.delegate = self;
    _nopayListView.dataSource = self;
    _nopayListView.backgroundColor = [UIColor clearColor];
    _nopayListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [_nopayListView registerClass:[NoPayCell class] forCellReuseIdentifier:@"cell"];
    
}
-(void)viewDidLayoutSubviews{
  //  [[[self.topview setScreenWidth] setRectHeight:30.0] setRectBelowOfView:_topLayout];
    
   // [[[_nopayListView setScreenWidth] setRectBelowOfView:self.topview] heightToEndWithPadding:0.0];
}

#pragma mark - tableview Delegate
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    long row=[indexPath row];
    orderInfo *order = _orderarr[row];
    NSLog(@"sa%@sa",_orderarr[row]);
    cell.indicatorRightPadding = 15.0;
    [cell.pic setImageFromUrl:order.fcppic];
    cell.title.text=order.fcpmc;
       cell.totolprice.text=[order.ordje stringValue];
    cell.quantity.text=[order.ordsl stringValue];
    
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _orderarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  long row=[indexPath row];
DetailOrderviewcontroller *con = [DetailOrderviewcontroller new];
  orderInfo*orderinfo =_orderarr[row];
  con.oederdetail=orderinfo.ordno;

    
    [self.navigationController pushViewController:con animated:YES];


}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result
{
    [ZTCoverView dissmiss];
    [_nopayListView reloadData];
    
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
alertShow(errmsg);
 [ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT:@"1,2,3,4,5,6,7,8,9"}];
    }}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    NSLog(@"result%@result",result);
    
    //    NSArray *addresses = [(NSArray*)result jsonParseToArrayWithType:[Address class]];
    //    _address=[NSMutableArray array];
    //    [[ZTDataCenter sharedInstance] saveUserAddresses:addresses];
    //    [_address removeAllObjects];
    //    [_address addObjectsFromArray:addresses];
    //    NSLog(@"111111q%@",addresses);
    //    NSLog(@"111111q%@",_address);}
    //// [_address addObjectsFromArray:[[ZTDataCenter sharedInstance] getUserAddresses]];
    
    NSArray *orderaaaaaaas = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
    
    _orderarr=[NSMutableArray array];
    [_orderarr removeAllObjects];
    [_orderarr addObjectsFromArray:orderaaaaaaas];
    
    
    
}



@end
