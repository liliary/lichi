//
//  DetailOrderviewcontroller.m
//  ZhongTuan
//
//  Created by anddward on 15/4/24.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "DetailOrderviewcontroller.h"
#import "ZTTitleLabel.h"
#import "ZTSessionView.h"
#import "ZTImageLoader.h"
#import "ZTCoverView.h"
#import "orderInfo.h"
@interface DetailOrderviewcontroller()<NetResultProtocol>{
orderInfo*orderdetail;
ZTTitleLabel* _titleView;
ZTSessionView*areaview;
ZTImageLoader *_pic;      //图片
UILabel *_title;        //标题
UILabel *_totolprice;     //总价
UILabel *_quantity;        //数量
UILabel *_dolla;            //价格符号
UILabel*_shuliang ;            //数量
UIView *_topLayout;
ZTSessionView *detail;

UILabel* ordermx;
UILabel* orderbh;
UILabel* orderbhh;
UILabel* orderzt;
UILabel* orderztt;
UILabel *orderfksj;
UILabel *orderfksjj;
UILabel *tel;
UILabel *tell;
UILabel *ordersl;
UILabel* ordersll;
UILabel*orderzj;
UILabel*orderzjj;

}


@end
@implementation DetailOrderviewcontroller
-(void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self initViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES ;
    [self initData];
}
-(void)initData{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_GETMYTMORD] delegate:self cancelIfExist:YES];
    
    [ZTCoverView alertCover];



}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
    [_pic setImageFromUrl:orderdetail.fcppic];
    _title.text=orderdetail.fcpmc;
    _totolprice.text=[orderdetail.ordje stringValue];
    _quantity.text=[orderdetail.ordsl stringValue];
    orderbhh.text=[orderdetail.coid stringValue];
    NSArray*aq=[[NSArray alloc]initWithObjects:@"-1",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    NSArray*zt=[[NSArray alloc]initWithObjects:@"已取消",@"待付款",@"已付款",@"已收货",@"已评价",@"已发货",@"申请退款",@"同意退款",@"已签收",@"已退款",@"退款中", nil];
    
    NSDictionary*dic=[[NSDictionary alloc]initWithObjects:zt forKeys:aq];
    
    orderztt.text= [dic objectForKey:[orderdetail.ordzt stringValue]];
    
    orderfksjj.text=orderdetail.dateandtime;
    tell.text=orderdetail.tel;
    ordersll.text=[orderdetail.ordsl stringValue];
    orderzjj.text=[orderdetail.ordje stringValue];
    [ZTCoverView dissmiss];

}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_GETMYTMORD]]) {
        [params addEntriesFromDictionary:@{ NET_ARG_DETAIL_ORDNO:[NSString stringWithFormat:@"%@",self.oederdetail]}];

    }
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
NSLog(@"detail%@detail",result);
    NSArray *orderaaaaaaas = [(NSArray*)result jsonParseToArrayWithType:[orderInfo class]];
    NSLog(@"detail%@detail",orderaaaaaaas);
    
        orderdetail=[orderInfo new];
   orderdetail=orderaaaaaaas[0];
   
  
}
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"订单详情"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

-(void)initViews{
_topLayout = (UIView*)self.topLayoutGuide;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self initHeadView];
    //[self.view addSubview:_waitListView];
    [self.view addSubViews:@[areaview,detail]];
    
}
-(void)initHeadView{
areaview=[ZTSessionView new];
    _pic = [ZTImageLoader new];
    _title = [[UILabel alloc] init];
    [_title setFont:[UIFont systemFontOfSize:12.0]];
    [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    _title.text=@"。。。。。。。。玩命加载中。。。。。。。。";
    _totolprice= [[UILabel alloc] init];
    [_totolprice setFont:[UIFont systemFontOfSize:12.0]];
    [_totolprice setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    _totolprice.text=@"100000";
    _dolla = [[UILabel alloc] init];
    [_dolla setText:@"￥"];
    [_dolla  setFont:[UIFont systemFontOfSize:13.0]];
    [_dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _shuliang = [[UILabel alloc] init];
    [_shuliang setText:@"数量: "];
    [_shuliang  setFont:[UIFont systemFontOfSize:10.0]];
    [_shuliang setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
   
    _quantity = [[UILabel alloc] init];
    [_quantity setFont:[UIFont systemFontOfSize:9.6]];
    [_quantity setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
     _quantity.text=@"1000000";
    [areaview addSubViews:@[_pic,_title, _dolla, _totolprice,_shuliang,_quantity]];
    //布局areaview中各个控件
    [[[[_pic setRectWidth:75.0] setRectHeight:73.5] setRectMarginTop:7.5] setRectMarginLeft:7.5];
    [[[[_title fitSize] setRectOnRightSideOfView:_pic] addRectX:15.0] setRectMarginTop:15.0];
    [[[[_dolla fitSize] setRectOnRightSideOfView:_pic] addRectX:15.0] setRectMarginTop:40.0];
    [[[_totolprice fitSize] setRectOnRightSideOfView:_dolla]setRectMarginTop:40.0];
    //[[[ _shuliang fitSize] setRectMarginTop:40.0] setRectMarginRight:80.0];
   [[[[_shuliang fitSize]setRectOnRightSideOfView:_totolprice]addRectX:60]setRectMarginTop:40.0];
    [[[_quantity fitSize] setRectMarginTop:40.0] setRectOnRightSideOfView:_shuliang];
    //[areaview.subviews[0] setBackgroundColor:[UIColor clearColor]];
     [areaview.subviews[0] setBackgroundColor:[UIColor grayColor]];
    
    
     detail=[ZTSessionView new];
   
    ordermx= [[UILabel alloc] init];
    [ordermx setFont:[UIFont systemFontOfSize:12.0]];
    [ordermx setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    ordermx.text=@"产品明细";
    orderbh = [[UILabel alloc] init];
    [orderbh setText:@"订单编号"];
    [orderbh  setFont:[UIFont systemFontOfSize:13.0]];
    [orderbh setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    orderbhh = [[UILabel alloc] init];
    [orderbhh setText:@"12345678"];
    [orderbhh  setFont:[UIFont systemFontOfSize:13.0]];
    [orderbhh setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    orderzt = [[UILabel alloc] init];
    [orderzt setText:@"订单状态"];
    [orderzt  setFont:[UIFont systemFontOfSize:13.0]];
    [orderzt setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    orderztt = [[UILabel alloc] init];
    [orderztt setText:@"申请退款核查"];
    [orderztt  setFont:[UIFont systemFontOfSize:13.0]];
    [orderztt setTextColor:[UIColor colorWithHexTransparent:0xff333333]];

    orderfksj = [[UILabel alloc] init];
    [orderfksj setText:@"付款时间"];
    [orderfksj  setFont:[UIFont systemFontOfSize:13.0]];
    [orderfksj setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    orderfksjj = [[UILabel alloc] init];
    [orderfksjj setText:@"2015-04-14 12:23:56"];
    [orderfksjj setFont:[UIFont systemFontOfSize:13.0]];
    [orderfksjj setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    tel = [[UILabel alloc] init];
    [tel setText:@"联系电话"];
    [tel  setFont:[UIFont systemFontOfSize:13.0]];
    [tel setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    tell = [[UILabel alloc] init];
    [tell setText:@"15622785198"];
    [tell setFont:[UIFont systemFontOfSize:13.0]];
    [tell setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    ordersl = [[UILabel alloc] init];
    [ordersl setText:@"购买数量"];
    [ordersl  setFont:[UIFont systemFontOfSize:13.0]];
    [ordersl setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    ordersll = [[UILabel alloc] init];
    [ordersll setText:@"155555"];
    [ordersll setFont:[UIFont systemFontOfSize:13.0]];
    [ordersll setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    orderzj = [[UILabel alloc] init];
    [orderzj setText:@"金额"];
    [orderzj  setFont:[UIFont systemFontOfSize:13.0]];
    [orderzj setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    orderzjj = [[UILabel alloc] init];
    [orderzjj setText:@"8518888"];
    [orderzjj setFont:[UIFont systemFontOfSize:13.0]];
    [orderzjj setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
  
   
    [detail addSubViews:@[ordermx,orderbh, orderbhh, orderfksj,orderfksjj,orderzt,orderztt,orderzj,orderzjj,ordersl,ordersll,tel,tell]];
    //布局detail中各个控件
    [[[[ordermx fitSize] setRectHeight:30] setRectMarginTop:7.5] setRectMarginLeft:7.5];
    
    [[[[[orderbh fitSize] setRectHeight:30]setRectMarginLeft:15] setRectBelowOfView:ordermx]addRectY:5.0];
    [[[[orderbhh fitSize] setRectOnRightSideOfView:orderbh] addRectX:180.0]setRectMarginTop:50] ;
    
    [[[[[orderzt fitSize] setRectBelowOfView:orderbh]addRectY:5.0]setRectHeight:30]setRectMarginLeft:15];
   [[[[orderztt fitSize]setRectOnRightSideOfView:orderzt]setRectMarginTop:85]addRectX:180.0];
   
    [[[[[orderfksj fitSize] setRectBelowOfView:orderzt]addRectY:5.0]setRectHeight:30]setRectMarginLeft:15];
    [[[[orderfksjj fitSize]setRectOnRightSideOfView:orderfksj]setRectMarginTop:120]addRectX:120.0];

   
    [[[[[tel fitSize] setRectBelowOfView:orderfksj]addRectY:5.0]setRectHeight:30]setRectMarginLeft:15];
    [[[[tell fitSize]setRectOnRightSideOfView:tel]setRectMarginTop:155]addRectX:160.0];
   
    [[[[[ordersl fitSize] setRectBelowOfView:tel]addRectY:5.0]setRectHeight:30]setRectMarginLeft:15];
   [ [[[ordersll fitSize]setRectOnRightSideOfView:ordersl]setRectMarginTop:190]addRectX:180.0];
    
    [[[[[orderzj fitSize] setRectBelowOfView:ordersl]addRectY:5.0]setRectHeight:30]setRectMarginLeft:15];
    [[[[orderzjj fitSize]setRectOnRightSideOfView:orderzj]setRectMarginTop:225]addRectX:200.0];
   
    [detail.subviews[0] setBackgroundColor:[UIColor clearColor]];
   // [detail.subviews[0] setBackgroundColor:[UIColor grayColor]];
 

    
}
-(void)viewDidLayoutSubviews{
    
    // 顶部栏
    [[[areaview wrapContents]setScreenWidth]setRectBelowOfView:_topLayout];
    [[[[detail wrapContents]setScreenWidth]setRectBelowOfView:areaview]addRectY:20.0];
    
    
}

@end
