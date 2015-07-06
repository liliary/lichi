//
//  Girlclothes.m
//  ZhongTuan
//
//  Created by anddward on 15/4/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "ZTTitleLabel.h"
#import "Girlclothes.h"
#import "SaleCell.h"
#import "TeMaiProduct.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "SaleProduct.h"
@interface Girlclothes()<NetResultProtocol>{
UIView*_topLayout;
 NSMutableArray *_GRIL_ProductList;
 BOOL isAutoRefresh;
  UIRefreshControl *_refresh;
  ZTTitleLabel *titleView;
}
@property (nonatomic,assign)int currentPage;

@end
@implementation Girlclothes
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
   
    //[self initTitleBar];
    [self initViews];
    [self initCollectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"lll%@lll",self.lanamee);
    [self initTitleBar];
    //titleView = [[ZTTitleLabel alloc] initWithTitle:self.lanamee];
     [self initData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   [self dragDownRefreshIfNeed];
}
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
    //  [self.collectionView addSubview:_refresh];
    [self.collectionView addHeaderWithTarget:self action:@selector(didRefresh:)];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMore)];
    
}


/**
 初始化标题栏
 */
-(void)initTitleBar{
    titleView = [[ZTTitleLabel alloc] initWithTitle:[NSString stringWithFormat:@"%@"@"特卖", self.lanamee]];

    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"sale_search"] forState:UIControlStateNormal];
    
    [titleView fitSize];
    [searchButton fitSize];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.titleView = titleView;
}
-(void)initViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    self.topview=[[UIView alloc]init];
    self.topview.backgroundColor=[UIColor whiteColor];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"综合",@"销量",@"价格",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(1.0, 1.0, 318.0, 30.0);
     segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    //segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//设置样式
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    //[segmentedControl fitSize];
    
    [self.topview addSubview:segmentedControl];
    //[self initTableView];
    [self.view addSubview:self.topview];
    //[self.view addSubview:_nopayListView];
    
}
//智能排序
-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    NSLog(@"Index %ld", (long)Index);
    
    switch (Index) {
            
        case 0:
            break;
    }
}
-(void)viewDidLayoutSubviews{
   [[[self.topview setScreenWidth] setRectHeight:30.0] setRectBelowOfView:_topLayout];
    
    //[[[_nopayListView setScreenWidth] setRectBelowOfView:self.topview] heightToEndWithPadding:0.0];
}
#pragma mark - collectionView delegate
/**
 头部size
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320, 20);
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
    return [_GRIL_ProductList count];
   
}

/**
 init Cell
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeMaiProduct *tmProduct = _GRIL_ProductList[row];
    SaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
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
   // header.backgroundColor = [UIColor blueColor];
       return header;
}
/**
 cell 点击
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeMaiProduct *product = _GRIL_ProductList[row];
   SaleProduct *con = [SaleProduct new];
       con.pid = product.tmid;
  [self.navigationController pushViewController:con animated:YES];
}

-(void)initData{

 [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];

}
/**
 处理参数
 */

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{


    NSLog(@"fanhuitemaishangpingshuju%@",result);
    NSArray *daleiproducts = [(NSArray*)result jsonParseToArrayWithType:[TeMaiProduct  class]];
//   NSLog(@"%@hahah",addresses);
  
    [[ZTDataCenter sharedInstance] clearAllProductsForType:CKEY_TE_MAI];
 [[ZTDataCenter sharedInstance] saveProducts:daleiproducts forType:CKEY_TE_MAI];
//    [_GRIL_ProductList addObjectsFromArray:[[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:10 orderBy:@"tmid" asic:NO type:CKEY_TE_MAI]];
    [_GRIL_ProductList removeAllObjects];
    _GRIL_ProductList=[NSMutableArray array];
    [_GRIL_ProductList addObjectsFromArray:daleiproducts];

}

/**
 请求失败
 */
-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    [_refresh endRefreshing];
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手加载数据" attributes:@{}];
    if ([errmsg isEqualToString:@"特卖商品已经完毕"]) {
        [MBProgressHUD showError:@"商品已经全部加载" toView:nil];
    }
}

/**
 请求成功
 */
-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    
    
    [_refresh endRefreshing];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手加载数据" attributes:@{}];
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    [self.collectionView reloadData];

}

/**
 *  设置请求参数
 */
-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{

    [params addEntriesFromDictionary:
     @{
       NET_ARG_TEMAI_PAGE:[NSString stringWithFormat:@"%d",self.currentPage],
       NET_ARG_TEMAI_CPDL:[NSString stringWithFormat:@"%@",self.gril],
       }];
}

#pragma mark - 加载更多
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
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
        });
    }
}


/**
 内容为空,触发自动下拉
 */
-(void)dragDownRefreshIfNeed{
    if (_GRIL_ProductList.count == 0) {
        isAutoRefresh = YES;
        [UIView animateWithDuration:1.0 animations:^{
            [self.collectionView setContentOffset:CGPointMake(0, -160) animated:NO];
        }];
    }
}
/**
 下拉刷新触发
 */
-(void)didRefresh:(UIRefreshControl*)sender{
    //    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"数据加载中...." attributes:@{}];
    [_GRIL_ProductList removeAllObjects];
    self.currentPage = 0;
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_TEMAI_ALL] delegate:self cancelIfExist:YES ];
}




@end




