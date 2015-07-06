//
//  StoreViewController.m
//  ZhongTuan
//
//  Created by apple on 15/4/11.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "SaleController.h"
#import "StoreViewController.h"
#import "SaleCell.h"
#import "TeMaiProduct.h"
#import "TeMaiProduct.h"
#import "ZTCoverView.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "ZTTitleLabel.h"
#import "SaleProduct.h"
#import "LoginViewController.h"
@interface StoreViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NetResultProtocol>
{  UIButton*collect;
    UICollectionReusableView *_header;
    NSMutableArray*shop_products;
    ZTTitleLabel*shopname;
    UILabel*tel;
    UIButton*telbtn;
    
    }
    @property (nonatomic,assign)int currentPage;
@end

@implementation StoreViewController

static NSString * const reuseIdentifier = @"cell";
- (int)currentPage{
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"qunima%@",self.shopidd);

       [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self initData];

}

/**
 初始化所有界面
 */
-(void)initViews{
 [self initTopBar];
 [self initRecommends];
 [self initHeaderView];
 [self.view addSubViews:@[_shopproducts,_topBar]];
 self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
 self.automaticallyAdjustsScrollViewInsets=NO;
    
}
//**
//初始化顶部栏
-(void)initTopBar{
self.topBar=[UIView new];
_topBar.backgroundColor=[UIColor whiteColor];
shopname=[ZTTitleLabel new];
shopname.text=@".....特卖商铺努力加载中.....";
tel=[UILabel new];
tel.text=@"15622785198";
 tel.font = [UIFont systemFontOfSize:13.0];
 tel.textColor=[UIColor greenColor];
telbtn=[UIButton new];

[telbtn setImage:[UIImage imageNamed: @"icon_phone"] forState:UIControlStateNormal];
//[telbtn setTitle:@"点击拨号:" forState:UIControlStateNormal];
    telbtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    //telnumber.titleLabel.backgroundColor= [UIColor colorWithHex:0xeb5f62];
    telbtn.titleLabel.textColor =  [UIColor colorWithHex:0xeb5f62];
//对电话号码状态显示
    [telbtn addTarget:self action:@selector(callshopboss:) forControlEvents:UIControlEventTouchUpInside];
    
collect=[UIButton new];
[collect setTitle:@"收藏" forState:UIControlStateNormal];
collect.titleLabel.font= [UIFont systemFontOfSize:11.0];
    [collect addTarget:self action:@selector(didTapCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
UIImageView*shop_bj=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shophead_bg-1.png"]];
[_topBar addSubview:shop_bj];
_backBtn=[UIButton new];
[_backBtn setImage:[UIImage imageNamed:@"sale_backbtn_bg"] forState:UIControlStateNormal ];
    [_backBtn addTarget:self action:@selector(didTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addSubViews:@[_backBtn,shopname,collect,tel,telbtn]];
}
/**
 初始化"向你推荐"
 */
-(void)initRecommends{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 6.0;
    layout.minimumInteritemSpacing = 3.0;
    layout.sectionInset = UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(151, 220);
   _shopproducts = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
   _shopproducts.backgroundColor = [UIColor whiteColor];
   _shopproducts.delegate = self;
   _shopproducts.dataSource = self;
   _shopproducts.showsHorizontalScrollIndicator = NO;
   _shopproducts.showsVerticalScrollIndicator = NO;
   _shopproducts.bounces = NO;
    [_shopproducts registerClass:[SaleCell class] forCellWithReuseIdentifier:@"cell"];
    [_shopproducts registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}
-(void)initHeaderView
{ _recommendTitle = [[ZTSessionTitle alloc] initWithTitle:@"热卖商品"];
    _recommendTitle.topBorder = YES;
    _recommendTitle.bottomBorder = YES;
    _recommendTitle.borderWidth = 1.0;
    _recommendTitle.backgroundColor = [UIColor whiteColor];
    _recommendTitle.font = [UIFont systemFontOfSize:14.0];}
#pragma mark - onClick Events
-(void)didTapBackBtn:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
//[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)callshopboss:(UIButton*)bt{

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];


}

#pragma mark - layoutViews
-(void)viewDidLayoutSubviews{
    
    // 顶部栏
    [[_topBar setScreenWidth] setRectHeight:100.0];
    [[[_backBtn fitSize] setRectMarginLeft:15.0] setRectMarginTop:26.0];
    [[[shopname fitSize]setRectMarginTop:40]setCenterOfViewHorizentail:_topBar];
    [[[collect fitSize]setRectMarginTop:50]setRectMarginRight:15];
    [[[telbtn fitSize]setRectMarginBottom:5]setRectMarginRight:120];
    [[[[tel fitSize]setRectOnRightSideOfView:telbtn]addRectX:3] setRectMarginBottom:3];
    [[[_recommendTitle setScreenWidth] setRectHeight:32.0]setRectBelowOfView:_topBar];
    
   // [[[[_recommendTitle setScreenWidth] setRectHeight:32.0] setRectBelowOfView:_topBar] addRectY:10.0];
    [[_shopproducts setScreenWidth]heightToEndWithPadding:0.0];
        [_shopproducts reloadData];
    
}
#pragma mark -collection view delegate

/**
 session 数量
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
NSLog(@"ri%@ri",shop_products);
return [shop_products count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
NSLog(@"chacha");
    NSInteger row = [indexPath row];
    TeMaiProduct *tmProduct =shop_products[row];
    SaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.pic setImageFromUrl:tmProduct.picurl];
    cell.title.text = tmProduct.title;
    cell.price.text = [NSString stringWithFormat:@"￥%@",tmProduct.tmdj];
    cell.del_price.attributedText = [[NSString stringWithFormat:@"￥%@",tmProduct.dj0] addStriket];
    NSLog(@"%@shopid%@",tmProduct.shopid,tmProduct.tmid);
    [cell setNeedsLayout];


return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (nil==_header) {
        _header=[UICollectionReusableView new];
        [_header addSubview:_recommendTitle];
    }
    return [_header fillSize];
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
_header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
[_header addSubview:_recommendTitle];
_header.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ammpp_bg"]];
return _header;

}
/**
 cell 点击
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeMaiProduct *product = shop_products[row];
    SaleProduct *con = [SaleProduct new];
    con.pid = product.tmid;
    [self.navigationController pushViewController:con animated:YES];
}


#pragma mark - helpers
-(void)initData{
    
    
 [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
   
    
     // 获取某一特卖商铺
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMSHOPBYID] delegate:self cancelIfExist:YES ];
       

    [ZTCoverView alertCover];
}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMSHOPBYID]]) {
        NSLog(@"kao%@",result);
          tel.text=[result objectForKey:@"tel"];
        shopname.text=[result objectForKey:@"shopname"];}
    
    else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDFAV]]){
        NSString*mess=@"收藏成功";
        alertShow(mess);}
    
    [self.shopproducts reloadData];
    
    
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
    alertShow(errmsg);
    
    [ZTCoverView dissmiss];

}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params
{
if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMSHOPBYID]]) {
    [params addEntriesFromDictionary:@{
                                       NET_ARG_SHOPID_GETTMSHOP:[NSString stringWithFormat:@"%@",
                                                                                                            self.shopidd]}];
}else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]]){
   
    [params addEntriesFromDictionary:
      @{
        NET_ARG_TEMAI_PAGE:[NSString stringWithFormat:@"%d",self.currentPage],
        NET_ARG_TEMAI_SHOPID:[NSString stringWithFormat:@"%@",self.shopidd],
        }];
}else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDFAV]]) {
    [params addEntriesFromDictionary:@{
                                       NET_ARG_LBID:[NSString stringWithFormat:@"%@",self.shopidd],
                                       NET_ARG_UFLB:@"shop-cp",
                                       NET_ARG_LNGOADDFAV:[NSString stringWithFormat:@"%@",[self getlngo]],
                                       NET_ARG_LATOADDFAV:[NSString stringWithFormat:@"%@",[self getlato]],                                                                         }];
}


}

//结果返回处理
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMSHOPBYID]]) {
    
    }else if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL]]){
     NSArray *shop_product = [(NSArray*)result jsonParseToArrayWithType:[TeMaiProduct class]];
        [shop_products removeAllObjects];
        shop_products=[NSMutableArray array];
     [shop_products addObjectsFromArray:shop_product];
       }

}
-(void)didTapCollectionBtn:(UIButton*)btn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
            if (nil==token) {
            LoginViewController*loginView=[[LoginViewController alloc]init];
            loginView.ttag=@"sale";
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:nav animated:YES completion:nil];
            }else{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ADDFAV] delegate:self cancelIfExist:YES ];
    [ZTCoverView alertCover];
    
    
        NSLog(@"collect");}
    
}
-(NSNumber*)getlngo
{    return [[NSUserDefaults standardUserDefaults]objectForKey:@"long"];}
-(NSNumber*)getlato
{return [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];}


@end
