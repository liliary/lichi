//
//  LargeListViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "LargeListViewController.h"
#import "ZTTitleLabel.h"
#import "LargeListTableViewCell.h"
#import "TeMaiProduct.h"
#import "ZTCoverView.h"
#import "SaleProduct.h"
@interface LargeListViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
ZTTitleLabel*titleview;
UIView* topview;
UITableView*addeslist;
NSArray*array;
NSMutableArray*_CX_ProductList;
}

@end

@implementation LargeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

[self initTitleView];
[self initView];
}
-(void)viewWillAppear:(BOOL)animated
{
           [super viewWillAppear:animated];
        self.tabBarController.tabBar.hidden=YES;
        self.navigationController.navigationBar.hidden=NO;
        [self initdata];
           //[self loaddata];


}
-(void)initTitleView{
    titleview=[[ZTTitleLabel alloc]initWithTitle:@"类目详情"];
    [titleview fitSize];
    self.navigationItem.titleView=titleview;
}
-(void)initView{
    topview=(UIView*)self.topLayoutGuide;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
 [self initTableView];
 [self.view addSubview:addeslist];

}
-(void)initTableView{
addeslist=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
//addeslist=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
addeslist.showsHorizontalScrollIndicator=NO;
addeslist.showsVerticalScrollIndicator=NO;
addeslist.dataSource=self;
addeslist.delegate=self;
addeslist.backgroundColor=[UIColor clearColor];
addeslist.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
[addeslist registerClass:[LargeListTableViewCell class] forCellReuseIdentifier:@"cell"];

}
//-(void)viewDidLayoutSubviews{
//[[[addeslist setScreenWidth]setRectBelowOfView:topview]heightToEndWithPadding:0.0];
//}
#pragma mark tableview data
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

return 400;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
LargeListTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell=[[LargeListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSInteger row = [indexPath row];
    TeMaiProduct *tmProduct = _CX_ProductList[row];
    [cell.toppic setImageFromUrl:tmProduct.picurl];
    NSLog(@"bababa%@",tmProduct.title);
    cell.productInfo.text=tmProduct.title;

    cell.promotionPrice.text=[NSString stringWithFormat:@"￥%@",tmProduct.dj0];
    cell.oneShoot.text=[NSString stringWithFormat:@"￥%@",tmProduct.dj1];
    cell.sale.text=[NSString stringWithFormat:@"销量%@",[tmProduct.sells stringValue]];
    cell.tagg.text=@"特卖";
    cell.topBorder=YES;
    cell.bottomBorder=YES;
    cell.borderWidth=2.0;
    
    [cell setNeedsLayout];
    
    
    
    
return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  TeMaiProduct*p=_CX_ProductList[indexPath.row];
    SaleProduct *controller = [SaleProduct new];
    controller.pid=p.tmid;
   // self.navigationController.navigationBar.topItem.title = @"返回";
    [self.navigationController pushViewController:controller animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
return _CX_ProductList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
-(void)initdata{
 
 
//[_CX_ProductList addObjectsFromArray:[[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:10 orderBy:@"tmid" asic:NO type:CKEY_CXYM]];
//    if (_CX_ProductList.count ==0) {
//   _CX_ProductList=[NSMutableArray array];
//        NSLog(@"zzcontent%@",self.adds.gotocontent);
        array=[self.adds.gotocontent componentsSeparatedByString:@"|"];
        NSLog(@"arrayqqq%@",array[1]);
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
[ZTCoverView alertCover];
    

    

    
}
//-(void)loaddata{
//
//   
//}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
[ZTCoverView dissmiss];
alertShow(errmsg);
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]])
    {[params addEntriesFromDictionary:
      @{
        NET_ARG_TMDLID:[NSString stringWithFormat:@"%@",array[1]],}];}
      }
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{


    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]]){
        NSLog(@"fanhuitemaishangpingshuju%@",result);
        NSArray *tm_products = [(NSArray*)result jsonParseToArrayWithType:[TeMaiProduct class]];
       NSLog(@"nimeiasave%@save",tm_products);
    
        
//         [[ZTDataCenter sharedInstance] clearAllProductsForType:CKEY_CXYM];
//      
//        
//        [[ZTDataCenter sharedInstance] saveProducts:tm_products forType:CKEY_CXYM];
//
//        //_CX_ProductList =[NSMutableArray array];
//        [_CX_ProductList addObjectsFromArray:[[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:10 orderBy:@"tmid" asic:NO type:CKEY_CXYM]];
        
        _CX_ProductList =[NSMutableArray array];
        [_CX_ProductList addObjectsFromArray:tm_products];
        
         NSLog(@"nimeiasave%@save",_CX_ProductList);

            dispatch_async(dispatch_get_main_queue(), ^{
             [addeslist reloadData];
             
        });
       
    }



}

@end
