//
//  MyCollectionViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ZTTitleLabel.h"
#import "CollectTableViewCell.h"
#import "ZTCoverView.h"
#import "Collectmodel.h"
#import "SaleProduct.h"
@interface MyCollectionViewController()<UITableViewDelegate,UITableViewDataSource,NetResultProtocol>{
    ZTTitleLabel* _titleView;
    UITableView*collecttableviewlist;
    NSMutableArray*collectarry;
}
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
         }

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"我的收藏"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
   }

-(void)initViews{
// 设置默认背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
      [self initCollectTableview];
    [self.view addSubview:collecttableviewlist];
}
-(void)initCollectTableview{
 collecttableviewlist=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
 collecttableviewlist.showsHorizontalScrollIndicator=NO;
 collecttableviewlist.showsHorizontalScrollIndicator=NO;
 collecttableviewlist.delegate=self;
 collecttableviewlist.dataSource=self;
 collecttableviewlist.backgroundColor=[UIColor clearColor];
 collecttableviewlist.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
 [collecttableviewlist registerClass:[CollectTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma tableview dalegata

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
return 91;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
CollectTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell=[[CollectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    long row=[indexPath row];

Collectmodel*temai=collectarry[row];
[cell.pic setImageFromUrl:temai.picurl];


cell.title.text=temai.title;

cell.totolprice.text=[NSString stringWithFormat:@"￥%@",temai.dj];
    cell.indicatorRightPadding = 15.0;
return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
return collectarry.count;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    long row=[indexPath row];
  SaleProduct *con = [SaleProduct new];
    Collectmodel*temai =collectarry[row];
    con.pid=temai.lbid;
    [self.navigationController pushViewController:con animated:YES];
}
-(void)initData{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETMYFAV] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];

}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
[ZTCoverView dissmiss];
    [ collecttableviewlist reloadData];

}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETMYFAV]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ORDZT_UFLB:@"cpmx-tm",
                                           NET_ARG_ORDZT_PAGE:[NSString stringWithFormat:@"%d",0]}];
    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{

    NSArray *orderaaaaaaas = [(NSArray*)result jsonParseToArrayWithType:[Collectmodel class]];
    
    collectarry=[NSMutableArray array];
    [collectarry removeAllObjects];
    [collectarry addObjectsFromArray:orderaaaaaaas];
    NSLog(@"coccccc%@",result);
 
}
@end
