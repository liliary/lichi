//
//  AllProductsController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/3.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
// TODO: 当url不合法时,拒绝服务

#import "AllProductsController.h"
#import "ZTTitleLabel.h"
#import "NearCell.h"
#import "TeamBuyProduct.h"
#import "ProductDetailViewController.h"

@interface AllProductsController ()<NetResultProtocol,UITableViewDataSource,UITableViewDelegate>{
    /// tableView
    UITableView* _tableView;
    UIRefreshControl* _refresh;
    
    /// data
    NSMutableArray *_productList;
    
    /// refresh
    BOOL isAutoRefreshing;
}

@end

@implementation AllProductsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self buildViews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadDataIfNeed];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - buildViews

-(void)initTitleBar{
    ZTTitleLabel* titleView = [[ZTTitleLabel alloc] initWithTitle:@"全部团购"];
    [titleView fitSize];
    self.navigationItem.titleView = titleView;
}

-(void)buildViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
}

-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _tableView.bounces = YES;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[NearCell class] forCellReuseIdentifier:@"nearCell"];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    /// refresh control
    _refresh = [UIRefreshControl new];
    _refresh.tintColor = [UIColor magentaColor];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手加载数据" attributes:nil];
    [_refresh addTarget:self  action:@selector(didRefreshData:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    [self.view addSubview:_tableView];
}

#pragma mark - tableView Delegates

/**
 每个session返回cell数量
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _productList.count;
}

/**
 cell 高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91.0;
}

/**
 返回cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearCell" forIndexPath:indexPath];
    long row = [indexPath row];
    TeamBuyProduct *p = _productList[row];
    [cell.pic setImageFromUrl:p.picurl];
    cell.title.text = p.cpmc;
    // TODO: distance is always equals to 958
    cell.distance.text = @"958";
    // TODO: CORNER IS ALWAYS SHOW
    cell.corner.image = [UIImage imageNamed:@"free"];
    cell.price.text = [NSString stringWithFormat:@"%@",p.dj2];
    cell.sale.text = [NSString stringWithFormat:@"销量:%@",p.sells];
    return cell;
}

/**
 cell 点击事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamBuyProduct *p = (TeamBuyProduct*)_productList[[indexPath row]];
    ProductDetailViewController *controller = [ProductDetailViewController new];
    controller.productId = p.mid;
    self.navigationController.navigationBar.topItem.title = @"返回";
    [self.navigationController pushViewController:controller animated:YES];
}

/**
 session 数量
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0;
}

#pragma mark - Status Events

-(void)didRefreshData:(UIRefreshControl*)sender{
    // TODO: 页面切换取消网络请求
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在加载数据...." attributes:nil];
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_PRODUCT_ALL] delegate:self cancelIfExist:YES];
}

-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    // 第一页，城市广州，排序按照价格
    [params addEntriesFromDictionary:@{
                                       NET_ARG_PRODUCT_PAGE:@1,
                                       NET_ARG_PRODUCT_CITYID:@5,
                                       }];
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:@{}];
    [_refresh endRefreshing];
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:@{}];
    [_refresh endRefreshing];
    [_tableView reloadData];
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{
    NSArray *productArray = [(NSArray*)result jsonParseToArrayWithType:[TeamBuyProduct class]];
    [[ZTDataCenter sharedInstance] clearAllProductsForType:CKEY_TEAMBUY];
    [[ZTDataCenter sharedInstance] saveProducts:productArray forType:CKEY_TEAMBUY];
    [_productList removeAllObjects];
    [_productList addObjectsFromArray:[[ZTDataCenter sharedInstance]
                                       getProductsFromPage:1 pageSize:10 offSet:0 count:-1 orderBy:@"mid" asic:YES type:CKEY_TEAMBUY]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (isAutoRefreshing && scrollView.contentOffset.y < -90) {
        isAutoRefreshing = NO;
        _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在加载数据...." attributes:nil];
        [_refresh beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1500000000),dispatch_get_main_queue(), ^{
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_PRODUCT_ALL] delegate:self cancelIfExist:YES];
        });
    }
}

#pragma mark - helpers
-(void)initData{
    _productList = [NSMutableArray arrayWithArray: [[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:-1 orderBy:@"mid" asic:YES type:CKEY_TEAMBUY]];
}

-(void)loadDataIfNeed{
    if (_productList.count == 0) {
        isAutoRefreshing = YES;
        [UIView animateWithDuration:1.0 animations:^{
            [_tableView setContentOffset:CGPointMake(0, -160) animated:NO];
        }];
    }
}

@end
