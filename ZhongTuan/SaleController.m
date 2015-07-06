//
//  SaleController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-4.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//
//  TODO:添加页面切换的网络取消
//  TODO:添加加载更多底部栏

#import "SaleController.h"
#import "RegisterViewController.h"
#import "ZTButtonGridView.h"
#import "ZTButtonCell.h"
#import "ZTTitleLabel.h"
#import "SaleCell.h"
#import "TeMaiProduct.h"
#import "SaleProduct.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "Girlclothes.h"
#import "dalei.h"
#import "ZTCoverView.h"
#import "BigCatagrayViewController.h"
#import "TapView.h"
#import "CXpro.h"
#import "Adesview.h"
#import "LargeListViewController.h"
#import "SaleProduct.h"
#import "StoreViewController.h"

@interface SaleController ()<NetResultProtocol,ZTButtonGridViewDelegate,UIScrollViewDelegate>{
    /// header view
    ZTButtonGridView *_cateGoryButton;  //分类按钮
    UIView *_sessionBanner;             //爆款特卖banner
    UILabel *_sessionTitle;
    UIRefreshControl *_refresh;
    NSMutableArray*leibie;
     UIScrollView *scrollview;
   UIPageControl*pagecontrol;
    UIView*ad;
    UIView *add;
    UIView *addd;
    TapView*zsa;
    TapView*zsb;
    TapView*zsc;
    TapView*zsd;
    Adesview*ceshi;
    /// data
    NSDictionary *_category_source;
    NSMutableArray *_TM_ProductList;
    CXpro*zsaa;
    CXpro*zsbb;
    CXpro*zscc;
    CXpro*zsdd;
    //NSArray* zspadda;
    /// refresh
    CXpro*topa;
    
       NSMutableArray *cxzaddarray;
     NSMutableArray *zspadarray;
      NSMutableArray *topadarray;
    BOOL isAutoRefresh;
    
}
@property (nonatomic,assign)int currentPage;

@end

@implementation SaleController

- (int)currentPage{
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}
-(instancetype)init{
    UICollectionViewFlowLayout *mlayout = [[UICollectionViewFlowLayout alloc] init];
    [mlayout setMinimumLineSpacing:10.0];
    [mlayout setMinimumInteritemSpacing:8.0];
    [mlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [mlayout setSectionInset:UIEdgeInsetsMake(7.5, 7.5, 0, 7.5)];
    [mlayout setItemSize:CGSizeMake(148.5,223)];
    
    self = [super initWithCollectionViewLayout:mlayout];
    if (self) {
        self.collectionView.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
        [self.collectionView registerClass:[SaleCell class] forCellWithReuseIdentifier:@"cell"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self initCollectionView];
    [self buildHeaderViewone];
    [self buildHeaderViewtwo];
    [self buildHeaderViewthird];
    [self buildHeaderViewfour];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self dragDownRefreshIfNeed];
}

#pragma mark - build views

/**
    初始化collection View
 */
-(void)initCollectionView{
    _refresh = [UIRefreshControl new];
    _refresh.tintColor = [UIColor purpleColor];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手加载数据" attributes:@{}];
    [_refresh addTarget:self action:@selector(didRefresh:) forControlEvents:UIControlEventValueChanged];
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
//    [self.collectionView addSubview:_refresh];
    [self.collectionView addHeaderWithTarget:self action:@selector(didRefresh:)];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMore)];

}
/**
    初始化标题栏
 */
-(void)initTitleBar{
    ZTTitleLabel *titleView = [[ZTTitleLabel alloc] initWithTitle:@"中团特卖"];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"sale_search"] forState:UIControlStateNormal];
    UIButton*fendalei=[UIButton buttonWithType:UIButtonTypeCustom];
    [fendalei setBackgroundImage:[UIImage imageNamed:@"noceehualan"] forState:UIControlStateNormal];
    
        [fendalei setBackgroundImage:[UIImage imageNamed:@"chehualan"] forState:UIControlStateHighlighted ];
    [fendalei fitSize];

    [titleView fitSize];
    [searchButton fitSize];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:fendalei];
    [fendalei addTarget:self action:@selector(jump:) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.titleView = titleView;
}
//跳转分类页面
-(void)jump:(UIButton*)sender{
BigCatagrayViewController*vc=[[BigCatagrayViewController alloc]init];
[self.navigationController pushViewController:vc animated:YES];


}
/**
    构建头部
 */
-(void)buildHeaderViewone{
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    
     scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
     scrollview.pagingEnabled = YES;
     scrollview.bounces = NO;
     scrollview.showsHorizontalScrollIndicator = NO;
     scrollview.showsVerticalScrollIndicator = NO;
//    for (int i=0; i<topadarray.count; i++) {
//        self.toppic=[ZTImageLoader new];
//     CXpro*topa=topadarray[i];
//             dispatch_async(dispatch_get_main_queue(), ^{
//         [self.toppic setImageFromUrl:topa.picurl];});
//        NSLog(@"sos%@",self.toppic);
//        CGRect frame=CGRectZero;
//        frame.origin.x=i*scrollview.frame.size.width;
//        frame.origin.y=0;
//        frame.size=scrollview.frame.size;
//        self.toppic.frame=frame;
//        [scrollview addSubview:self.toppic];
//        UIButton*button=[[UIButton alloc]initWithFrame:frame];
//        button.tag=i;
//        button.backgroundColor=[UIColor blueColor];
//        [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [scrollview addSubview:button];
//        
//    }
//    // 设置重要属性
//    
//    scrollview.contentSize=CGSizeMake(scrollview.frame.size.width*topadarray.count, scrollview.frame.size.height);
//    [self.collectionView addSubview: scrollview];
//    
//    scrollview.pagingEnabled=YES;
//    scrollview.delegate=self;
//    
//    UIPageControl*pagecontroll=[[UIPageControl alloc]init];
//    self.pagecontrol=pagecontroll;
//    pagecontroll.frame=CGRectMake(0,scrollview.frame.size.height-10,  scrollview.frame.size.width, 20);
//    pagecontroll.numberOfPages=[topadarray count];
//    pagecontroll.pageIndicatorTintColor=[UIColor blackColor];
//    pagecontroll.currentPageIndicatorTintColor=[UIColor redColor];
//    
//    [self.view addSubview:pagecontroll];
    
//    ad=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
//    UIImageView *guangao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner1"]];
//    [ad addSubview:guangao];
    
}
-(void)buildHeaderViewtwo{
   _cateGoryButton = [[ZTButtonGridView alloc] initWithIcons:_category_source cell:@"ZTButtonCell" column:4 rowSpace:0.0 columnSpace:0.0 edgeSpace:0.0];
   _cateGoryButton.tag=@"0";
    _cateGoryButton.bottomBorder = YES;
    _cateGoryButton.borderWidth = 1.0;
    _cateGoryButton.ztButtonViewDelegate=self;
   }
-(void)buildHeaderViewthird{
    zsa=[[TapView alloc]initWithFrame:CGRectMake(0, 186, 156, 166)];
    zsa.tagg=@"zsa";
    //zsa.pic.userInteractionEnabled=YES;
   zsa.backgroundColor=[UIColor redColor];

    [zsa setTarget:self trigger:@selector(zsaJump:)];
    NSLog(@"caocao%@",zsa);
    zsb=[[TapView alloc]init];
        [zsb setTarget:self trigger:@selector(zsaJump:)];
 zsb.tagg=@"zsb";
    zsc=[[TapView alloc]init];
    [zsc setTarget:self trigger:@selector(zsaJump:)];
     zsc.tagg=@"zsc";
    zsd=[[TapView alloc]init];
    [zsd setTarget:self trigger:@selector(zsaJump:)];
     zsd.tagg=@"zsd";
}
-(void)buildHeaderViewfour{
    _sessionBanner = [[UIView alloc] initWithFrame:CGRectZero];
    _sessionBanner.backgroundColor = [UIColor redColor];

    _sessionTitle = [UILabel new];
    _sessionTitle.text = @"『精选爆款』团到就是赚到";
    _sessionTitle.font = [UIFont systemFontOfSize:14.0];
    _sessionTitle.textColor = [UIColor whiteColor];
    _sessionTitle.backgroundColor = [UIColor colorWithHex:0xFF4955];

}
#pragma mark - collectionView delegate
/**
    头部size
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320, 392);
}

/**
    session 数量
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0;
}

/**
    session 中包含cell 数量
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_TM_ProductList count];
}

/**
    init Cell
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeMaiProduct *tmProduct = _TM_ProductList[row];
    
    SaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"ewq%@",tmProduct.picurl);
    [cell.pic setImageFromUrl:tmProduct.picurl];
    cell.title.text = tmProduct.title;
    cell.price.text = [NSString stringWithFormat:@"￥%@",tmProduct.tmdj];
    cell.del_price.attributedText = [[NSString stringWithFormat:@"￥%@",tmProduct.dj0] addStriket];
    NSLog(@"%@shopid%@",tmProduct.shopid,tmProduct.tmid);
       [cell setNeedsLayout];
    return cell;
}

/**
    头部View 处理
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
   
    [header addSubViews:@[scrollview,_cateGoryButton,zsa,zsb,zsc,zsd,_sessionTitle]];
    
    [[[[_cateGoryButton setScreenWidth]setRectHeight:76] setRectBelowOfView:scrollview]addRectY:5.0];
    //[[[[[zsa fitSize] setRectBelowOfView:_cateGoryButton]addRectY:5]setRectHeight:166]setRectMarginLeft:0.0];
   
    [[[[[[zsb setRectWidth:161] setRectHeight:83] setRectBelowOfView:_cateGoryButton]addRectY:5]setRectOnRightSideOfView:zsa]addRectX:2];
   [[[[[[zsc  setRectWidth:82] setRectHeight:82]setRectOnRightSideOfView:zsa]addRectX:2] setRectBelowOfView:zsb]addRectY:1];
    [[[[[[zsd setRectWidth:82] setRectHeight:82]setRectOnRightSideOfView:zsc]addRectX:1] setRectBelowOfView:zsb]addRectY:1];
    
    
            [[[[_sessionTitle setScreenWidth] setRectHeight:32.0] setRectBelowOfView:zsa] addRectY:2.0];
    return header;
}

/**
    cell 点击
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeMaiProduct *product = _TM_ProductList[row];
    SaleProduct *con = [SaleProduct new];
    con.pid = product.tmid;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - Event status
/**
    处理请求成功后结果
 */
-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]]){
NSLog(@"fanhuitemaishangpingshuju%@",result);
    NSArray *tm_products = [(NSArray*)result jsonParseToArrayWithType:[TeMaiProduct class]];
    NSLog(@"save%@save",tm_products);
    
  [[ZTDataCenter sharedInstance] clearAllProductsForType:CKEY_TE_MAI];
 
  [[ZTDataCenter sharedInstance] saveProducts:tm_products forType:CKEY_TE_MAI];
        if (self.currentPage==0) {
            [_TM_ProductList removeAllObjects];
        }
 [_TM_ProductList addObjectsFromArray:[[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:10 orderBy:@"tmid" asic:NO type:CKEY_TE_MAI]];
 NSLog(@"kongma%d",self.currentPage);
    }

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETAPPADY]]) {
    
    NSDictionary*advv=[result objectForKey:@"adv"];
    NSArray*cxzadd=[advv objectForKey:@"cxzad"];
     cxzaddarray=[NSMutableArray array];
        for (int i=0; i<cxzadd.count; i++) {
        NSArray*cxzaddshuzu=[NSArray new];
           cxzaddshuzu=cxzadd[i];
         CXpro*cxpro=[CXpro new];
         cxpro.picurl=cxzaddshuzu[0];
         cxpro.gowhere=cxzaddshuzu[1];
         cxpro.gotocontent=cxzaddshuzu[2];
         cxpro.name=cxzaddshuzu[3];
       
      [cxzaddarray addObject:cxpro];
            
        }
        NSLog(@"yuanshu%@",cxzaddarray);
    
    NSArray*topadd=[advv objectForKey:@"topad"];
        topadarray=[NSMutableArray array];
        for (int i=0; i<topadd.count; i++) {
            NSArray*cxzaddshuzu=[NSArray new];
            cxzaddshuzu=topadd[i];
            CXpro*cxpro=[CXpro new];
            cxpro.picurl=cxzaddshuzu[0];
            cxpro.gowhere=cxzaddshuzu[1];
            cxpro.gotocontent=cxzaddshuzu[2];
            cxpro.name=cxzaddshuzu[3];
            
            [topadarray addObject:cxpro];
            
        }
        NSLog(@"yuanshu%@",topadarray);
        
    NSArray*zspadd=[advv objectForKey:@"zspad"];
        zspadarray=[NSMutableArray array];
        for (int i=0; i<zspadd.count; i++) {
            NSArray*cxzaddshuzu=[NSArray new];
            cxzaddshuzu=zspadd[i];
            CXpro*cxpro=[CXpro new];
            cxpro.picurl=cxzaddshuzu[0];
            cxpro.gowhere=cxzaddshuzu[1];
            cxpro.gotocontent=cxzaddshuzu[2];
            cxpro.name=cxzaddshuzu[3];
            
            [zspadarray addObject:cxpro];
            
        }
        NSLog(@"yuanshu%@",zspadarray);
    
   
   CXpro*cxa =cxzaddarray[0];
    CXpro*cxb=cxzaddarray[1];
     CXpro*cxc=cxzaddarray[2];
      CXpro*cxd=cxzaddarray[3];
    
     NSArray*cxadurls=@[cxa.picurl,cxb.picurl,cxc.picurl,cxd.picurl];
     NSLog(@"%@",cxadurls);
     NSArray*cxadwenzi=@[cxa.name,cxb.name,cxc.name,cxd.name];
     NSLog(@"%@",cxadwenzi);
        _category_source=@{
                           @"icons":cxadurls,
                           @"titles":cxadwenzi,
                           };
     
        
        [self buildHeaderViewtwo];
//促销ad中的四个对象
     zsaa =zspadarray[0];
        zsbb=zspadarray[1];
        zscc=zspadarray[2];
       zsdd=zspadarray[3];
        

NSLog(@"zsaaaaa%@",zsaa.picurl);
    // [zsa.pic setImageFromUrl:zsaa.picurl];
     //   [zsa Icons:zsaa.picurl];
        NSLog(@"zsakaokao%@",zsa);
        

        
//             zsb=[ zsb initWithIcons:zsbb.picurl];
        // zsb.tagg=@"zsb";
//        NSLog(@"urlurllll%@",zsbb.picurl);
//     [zsb setTarget:self trigger:@selector(zsaJump:)];

        //[zsb.pic setImageFromUrl:zsbb.picurl];
              /// NSLog(@"zsbkaokao%@",zsb);
//       zsc=[zsc initWithIcons:zscc.picurl];
       // [zsc.pic setImageFromUrl:zscc.picurl];
        
//        NSLog(@"urlurllll%@",zscc.picurl);
//        [zsc setTarget:self trigger:@selector(zsaJump:)];
//
//       zsd=[zsd initWithIcons:zsdd.picurl];
       //[zsd.pic setImageFromUrl:zsdd.picurl];
        
//        NSLog(@"urlurllll%@",zsdd.picurl);
//        [zsd setTarget:self trigger:@selector(zsaJump:)];
//
       
        //[self.collectionView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        [zsa.pic setImageFromUrl:zsaa.picurl];
        [zsb.pic setImageFromUrl:zsbb.picurl];
            [zsc.pic setImageFromUrl:zscc.picurl];
         [zsd.pic setImageFromUrl:zsdd.picurl];
            [self.collectionView reloadData];
        });

        NSMutableArray*topaurl=[NSMutableArray array];
        NSMutableArray*toppica=[NSMutableArray array];
        
    

        for (int i=0; i<topadarray.count; i++) {
            self.toppic=[ZTImageLoader new];
            topa=topadarray[i];
            
//       dispatch_async(dispatch_get_main_queue(), ^{
//          NSLog(@"hahahahha");
//           [self.toppic setImageFromUrl:topa.picurl];});
//            NSLog(@"sos%@",self.toppic);
//            
            
            
            CGRect frame=CGRectZero;
            frame.origin.x=i*scrollview.frame.size.width;
            frame.origin.y=0;
            frame.size=scrollview.frame.size;
            self.toppic.frame=frame;
            [scrollview addSubview:self.toppic];
            UIButton*button=[[UIButton alloc]initWithFrame:frame];
            button.tag=i;
          //  button.backgroundColor=[UIColor blueColor];
            [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview addSubview:button];
            
            [toppica addObject:self.toppic];
            [topaurl addObject:topa.picurl];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0; i<topadarray.count; i++) {
                [toppica[i] setImageFromUrl:topaurl[i]];
            }
        
        });
        // 设置重要属性
        
        scrollview.contentSize=CGSizeMake(scrollview.frame.size.width*topadarray.count, scrollview.frame.size.height);
        [self.view addSubview: scrollview];
        
        scrollview.pagingEnabled=YES;
        scrollview.delegate=self;
        
        pagecontrol=[[UIPageControl alloc]init];
       
       // pagecontrol.frame=CGRectMake(0,scrollview.frame.size.height-20,  scrollview.frame.size.width, 20);
       pagecontrol.frame=CGRectMake(0, scrollview.frame.size.height-20, 320, 20);
        pagecontrol.numberOfPages=[topadarray count];
        pagecontrol.pageIndicatorTintColor=[UIColor blackColor];
        //这里有问题 红黑
        pagecontrol.currentPageIndicatorTintColor=[UIColor redColor];
        
        [self.collectionView addSubview:pagecontrol];




         }
    
}
-(void)onclick:(UIButton*)bt{

  for (int i=0; i<topadarray.count; i++) {
      if (bt.tag==i) {
          CXpro*topaa=topadarray[i];
          NSLog(@"ssssssss%@  %@",topaa.gowhere,topaa.gotocontent);

          if ([topaa.gowhere isEqualToString:@"tmshop"]) {
              StoreViewController*shop=[[StoreViewController alloc]init];
              NSArray*topshop=[NSArray array];
              topshop =[topaa.gotocontent componentsSeparatedByString:@"|"];
              shop.shopidd=topshop[1];
              NSLog(@"aiwoshi%@",shop.shopidd);
              [self.navigationController pushViewController:shop animated:YES];}
              if ([topaa.gowhere isEqualToString:@"largelist"]) {
              NSLog(@"qunimalargelist");
                  LargeListViewController*largevc=[[LargeListViewController alloc]init];
                  largevc.adds=topaa;

                  [self.navigationController pushViewController:largevc animated:YES];
                  
              }
          if ([topaa.gowhere isEqualToString:@"tmitem"]) {
              SaleProduct*vc=[[SaleProduct alloc]init];
                                NSArray*saleid=[NSArray array];
                                saleid =[topaa.gotocontent componentsSeparatedByString:@"|"];
                                vc.pid=saleid[1];
               [self.navigationController pushViewController:vc animated:YES];
          }
              

          }
      }
  }

#pragma click thing
-(void)zsaJump:(TapView*)sender{
SaleProduct*vc=[[SaleProduct alloc]init];
    if ([sender.tagg isEqual: @"zsa"]) {
   NSArray*zsatmid=[NSArray array];
  zsatmid =[zsaa.gotocontent componentsSeparatedByString:@"|"];
   vc.pid=zsatmid[1];
      }
    if ([sender.tagg isEqualToString:@"zsb"]) {
        NSArray*zsbtmid=[NSArray array];
        zsbtmid =[zsbb.gotocontent componentsSeparatedByString:@"|"];
        vc.pid=zsbtmid[1];
    }
    if ([sender.tagg isEqualToString:@"zsc"]) {
        NSArray*zsctmid=[NSArray array];
        zsctmid =[zscc.gotocontent componentsSeparatedByString:@"|"];
               vc.pid=zsctmid[1];
    }if ([sender.tagg isEqualToString:@"zsd"]) {
        NSArray*zsdtmid=[NSArray array];
        zsdtmid =[zsdd.gotocontent componentsSeparatedByString:@"|"];
    
        vc.pid=zsdtmid[1];
    }
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)didTapCollectionAtIndex:(NSIndexPath*)index{
    
    CXpro *cx=cxzaddarray[index.row];
    LargeListViewController*vc=[[LargeListViewController alloc]init];
    vc.adds=cx;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    NSLog(@"首页哦hah%ld",(long)index.row);
    // [_ztButtonViewDelegate didTapCollectionAtIndex:indexPath];
}


/**
    请求失败
 */
-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]]){
    [_refresh endRefreshing];
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手加载数据" attributes:@{}];
    if ([errmsg isEqualToString:@"特卖商品已经完毕"]) {
        [MBProgressHUD showError:@"商品已经全部加载" toView:nil];
    }
    }
 [ZTCoverView dissmiss];
}

/**
    请求成功
 */
-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]]){
    [_refresh endRefreshing];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手加载数据" attributes:@{}];
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
        [self.collectionView reloadData];}
    
    else{NSLog(@"dalei%@",result);}
    [ZTCoverView dissmiss];
}

/**
 *  设置请求参数
 */
-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]])
    {[params addEntriesFromDictionary:
     @{
       NET_ARG_TEMAI_PAGE:[NSString stringWithFormat:@"%d",self.currentPage],
       }];}
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETAPPADY]]) {
        [params addEntriesFromDictionary:
         @{
           NET_ARG_PAGEA:[NSString stringWithFormat:@"%@",@"tmindex"],
           }];
        
    }
    
}

#pragma mark - 加载更多

/**
 下拉刷新触发
 */
-(void)didRefresh:(UIRefreshControl*)sender{
    //    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"数据加载中...." attributes:@{}];
       self.currentPage = 0;
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
}



/**
    上拉刷新触发
 */
- (void)loadMore{
    self.currentPage++;
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
}

/**
    列表滚动监听
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (isAutoRefresh && scrollView.contentOffset.y< -90) {
        isAutoRefresh = NO;
        [_refresh beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1500000000), dispatch_get_main_queue(), ^{
        //first stall app
        NSLog(@"firstfirst");
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
        });
    }
    
    else{
            CGPoint offset=scrollview.contentOffset;
            if (offset.x<=0) {
                offset.x=0;
                scrollview.contentOffset=offset;
            }
            NSInteger index=round(offset.x/scrollview.frame.size.width);
            pagecontrol.currentPage=index;
        
    
    }
}

#pragma mark - helpers

-(void)initData{
  
    _TM_ProductList = [NSMutableArray arrayWithArray:[[ZTDataCenter sharedInstance]
            getProductsFromPage:1 pageSize:10 offSet:0 count:-1 orderBy:@"tmid" asic:NO type:CKEY_TE_MAI]];
            NSLog(@"huancun%@huancun",_TM_ProductList);
    
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETAPPADY] delegate:self cancelIfExist:YES ];
    NSLog(@"alter");
        [ZTCoverView alertCover];
        

}

/**
    内容为空,触发自动下拉
 */
-(void)dragDownRefreshIfNeed{
    if (_TM_ProductList.count == 0) {
        isAutoRefresh = YES;
        [UIView animateWithDuration:1.0 animations:^{
            [self.collectionView setContentOffset:CGPointMake(0, -160) animated:NO];
        }];
    }
}
@end
