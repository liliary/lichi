//
//  NearController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-4.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//  TODO:添加页面切换的网络取消
//  TODO:更换合伙人广告
//  TODO:团购按钮做成roundrect,改白色背景
//  TODO:顶部栏和特卖调换

#import "NearController.h"
#import "RegisterViewController.h"
#import "ZTButtonCell.h"
#import "ZTButtonGridView.h"
#import "NearCell.h"
#import "QRScanViewController.h"
#import "CategoryController.h"
#import "ZTNetWorkUtilities.h"
#import "ZTSearchBar.h"
#import "TeamBuyProduct.h"
#import "ZTRoundButton.h"
#import "AllProductsController.h"
#import "SearchViewController.h"
#import "CitySelectedViewController.h"
#import "ProductDetailViewController.h"
#import "ZTSessionView.h"
// TODO: CELL BORDER IS NOT SHOW CORRECTABLE

@interface NearController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    ZTButtonGridViewDelegate,
    NetResultProtocol,
    UITextFieldDelegate
>
{
    /// titleBar
    UIButton *_cityChooseButton;
    ZTSearchBar *_searchBar;
    UIButton *_scanButton;
    
    /// tabelView
    UIView *_headerView;
    UIView *_footerView;
    UIRefreshControl *_reflash;
    
    /// HeaderView
    UIImageView *_slider;
    ZTButtonGridView *_categoryButtons;
    
    // FooterView
    ZTRoundButton *_allTeamBuy;
    
    /// sessionView
    ZTSessionView *_sectionTitleView;
    UILabel *_sectionTitle;
    UIButton *_allButton;
    UIImageView *_rightArrow;
    
    /// data
    NSArray *titles;
    NSArray *icons;
    NSMutableArray *_productList;
    ZTNetWorkUtilities *_server;
    NSInteger productNumber;        // 限制当前页面显示的产品数量
    
    /// refresh
    BOOL isAutoRefreshing;
}
@end

@implementation NearController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self dragDownRefreshIfNeed];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_server popTask:[NSString stringURLWithAppendex:NET_API_PRODUCT_ALL]];
}

#pragma mark - build Views
-(void)buildViews{
    [self initTableView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
}

/**
 构建顶部栏
 */
-(void)initTitleBar{
    /// 导航
    self.navigationController.navigationBar.topItem.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    /// 城市定位区域
    _cityChooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityChooseButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    _cityChooseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _cityChooseButton.titleEdgeInsets = UIEdgeInsetsMake(0, -35.0, 0, 0);
    _cityChooseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [_cityChooseButton setTitle:@"城市" forState:UIControlStateNormal];
    [_cityChooseButton setTitleColor:[UIColor colorWithHexTransparent:0xffd72522] forState:UIControlStateNormal];
    [_cityChooseButton setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    [_cityChooseButton addTarget:self
                          action:@selector(didTapCitySettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cityChooseButton sizeToFit];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:_cityChooseButton]];
    
    /// 搜索栏
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 195.0, 30.0)];
    _searchBar = [[ZTSearchBar alloc] initWithBackgroundImage:[UIImage imageNamed:@"search_bg"] searchIcon:[UIImage imageNamed:@"search_icon"]];
    _searchBar.delegate = self;
    _searchBar.bounds = CGRectMake(0, 0, 195.0, 30.0);
    _searchBar.center = CGPointMake(self.navigationItem.titleView.center.x-10.0, self.navigationItem.titleView.center.y);
    [self.navigationItem.titleView addSubview:_searchBar];
    
    /// 二维码按钮
    _scanButton = [[UIButton alloc] init];
    [_scanButton setBackgroundImage:[UIImage imageNamed:@"btn_scan"] forState:UIControlStateNormal];
    [_scanButton addTarget:self action:@selector(didTapButtonQRScan:) forControlEvents:UIControlEventTouchUpInside];
    [_scanButton sizeToFit];
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithCustomView:_scanButton]];
}

/**
    构建HeaderView
 */
-(void)initHeaderViews{
    _headerView = [UIView new];

    ///Slider
    _slider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ad"]];
    
    ///CategoryButtons
    NSDictionary *source = [NSDictionary dictionaryWithObjects:@[icons,titles] forKeys:@[@"icons",@"titles"]];
    _categoryButtons = [[ZTButtonGridView alloc] initWithIcons:source cell:@"ZTButtonCell" column:4 rowSpace:1.0 columnSpace:1.0 edgeSpace:1.0];
    _categoryButtons.borderWidth = 1.0;
    _categoryButtons.bottomBorder = YES;
    _categoryButtons.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    _categoryButtons.ztButtonViewDelegate = self;
    
    [_headerView addSubViews:@[_slider,_categoryButtons]];
    
    /// layout views
    [_slider sizeToFit];
    [[_categoryButtons setRectBelowOfView:_slider] addRectY:2.0];
    [[_headerView wrapContents] addRectHeight:9.0];
    
    self.tableView.tableHeaderView = _headerView;
}

/**
    构建footerview
 */
-(void)initFooterViews{
    // TODO: 考虑数量不满一屏幕,如何显示footerView(数量不足6个,不显示footerView按钮)
    UIView *footerView = [UIView new];
    
    /// 查看全部按钮
    _allTeamBuy = [[ZTRoundButton alloc]
        initWithTitle:@"查看全部团购" textcolor:[UIColor colorWithHex:0xff4978]];
    [_allTeamBuy addTarget:self action:@selector(didTapAllProductBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    /// lalyout footerView
    [footerView addSubview:_allTeamBuy];
    [[footerView setScreenWidth] setRectHeight:60.0];
    [[[[_allTeamBuy fitSize] setRectMarginLeft:15.0] widthToEndWithPadding:15.0] setRectCenterVertical];
    self.tableView.tableFooterView = footerView;
}

/**
     banner
 */
-(void)buildSectionTitleView{
    /// section View
    _sectionTitleView = [ZTSessionView new];
    _sectionTitleView.frame = CGRectMake(0, 0, 320, 36.0);
    _sectionTitleView.topBorder = YES;
    _sectionTitleView.bottomBorder = YES;
    _sectionTitleView.borderWidth = 1.0;

    /// title
    _sectionTitle = [[UILabel alloc] init];
    _sectionTitle.text = @"猜你喜欢";
    _sectionTitle.font = [UIFont systemFontOfSize:15.0];
    _sectionTitle.textColor = [UIColor colorWithHexTransparent:0xff333333];
    
    /// all teambuy button
    _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _allButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_allButton addTarget:self action:@selector(didTapAllProductBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_allButton setTitleColor:[UIColor colorWithHexTransparent:0xffff4978] forState:UIControlStateNormal];
    [_allButton setTitle:@"全部团购" forState:UIControlStateNormal];
    
    _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    
    [_sectionTitleView addSubViews:@[_sectionTitle,_allButton,_rightArrow]];
        
    /// layout views
    [_sectionTitle sizeToFit];
    [_allButton sizeToFit];
    [_rightArrow sizeToFit];
    [[_sectionTitle setRectCenterVertical] setRectMarginLeft:7.5];
    [[_rightArrow setRectCenterVertical] setRectMarginRight:7.5];
    [[[_allButton setRectCenterVertical] setRectOnLeftSideOfView:_rightArrow] addRectX:-7.5];
}

/**
    列表属性设置
 */
-(void)initTableView{
    // TODO: 抽离下拉状态更新代码
    self.tableView.bounces = YES;
    self.tableView.showsVerticalScrollIndicator =  NO;
    [self.tableView registerClass:[NearCell class] forCellReuseIdentifier:@"nearCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    /// 下拉刷新控制头
    _reflash = [UIRefreshControl new];
    _reflash.tintColor = [UIColor magentaColor];
    _reflash.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:nil];
    [_reflash addTarget:self action:@selector(didReloadData:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _reflash;
    
    /// 头和尾
    [self initHeaderViews];
    [self initFooterViews];
}

#pragma mark - table Delegates
/**
    每个session返回cell数量
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _productList.count >= productNumber? productNumber : _productList.count;
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
    cell.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    cell.bottomBorder = YES;
    cell.borderWidth = 1.0;
    return cell;
}

/**
    cell 点击事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeamBuyProduct* p = (TeamBuyProduct*)_productList[row];
    ProductDetailViewController *controller = [ProductDetailViewController new];
    controller.productId = p.mid;
    [self.navigationController pushViewController:controller animated:YES];
}

/**
    session 数量
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
    Header 高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 36.0;
    }
    return 0.0;
}

/**
    table View section Views
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        [self buildSectionTitleView];
        return _sectionTitleView;
    }
    return nil;
}

#pragma mark - OnClick Events

/**
    点击"扫描二维码"按钮
 */
-(void)didTapButtonQRScan:(UIButton*)button{
    [self.navigationController pushViewController:[[QRScanViewController alloc] init] animated:YES];
}

/**
    点击"分类"按钮
 */
-(void)didTapCollectionAtIndex:(NSIndexPath *)index{
    AllProductsController *controller = [AllProductsController new];
    [self.navigationController pushViewController:controller animated:YES];
}

/**
    点击"城市设置"按钮
 */
-(void)didTapCitySettingBtn:(UIButton*)btn{
//    CitySelectedViewController *controller = [CitySelectedViewController new];
//    [self.navigationController pushViewController:controller animated:YES];
}

/**
    点击"查看全部团购"按钮
 */
-(void)didTapAllProductBtn:(UIButton*)btn{
    AllProductsController *controller = [AllProductsController new];
    [self.navigationController pushViewController:controller animated:YES];
}

/**
 输入搜索被点击
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    SearchViewController *controller = [SearchViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Event status

-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    // 第一页，城市广州，排序按照价格
    [params addEntriesFromDictionary:@{
                                       NET_ARG_PRODUCT_CITYID:@190,
                                       NET_ARG_PRODUCT_PAGE:@0,
                                       NET_ARG_PRODUCT_PX:@0,
                                      }];
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    _reflash.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:@{}];
    [_reflash endRefreshing];
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    _reflash.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:@{}];
    [_reflash endRefreshing];
    [self.tableView reloadData];
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{
    NSArray *productArray = [(NSArray*)result jsonParseToArrayWithType:[TeamBuyProduct class]];
    [[ZTDataCenter sharedInstance] clearAllProductsForType:CKEY_TEAMBUY];
    [[ZTDataCenter sharedInstance] saveProducts:productArray forType:CKEY_TEAMBUY];
    [_productList removeAllObjects];
    [_productList addObjectsFromArray:[[ZTDataCenter sharedInstance]
                                       getProductsFromPage:1 pageSize:10 offSet:0 count:productNumber orderBy:@"mid" asic:YES type:CKEY_TEAMBUY]];
}

/**
    开始刷新
 */
-(void)didReloadData:(UIRefreshControl*)sender{
    sender.attributedTitle = [[NSAttributedString alloc] initWithString:@"数据加载中...." attributes:@{}];
    [[ZTNetWorkUtilities sharedInstance]
     doPost:[NSString stringURLWithAppendex:NET_API_PRODUCT_ALL] delegate:self cancelIfExist:NO];
}

#pragma mark - scrollView delegate

/**
    自动加载
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (isAutoRefreshing && scrollView.contentOffset.y < -90) {
        isAutoRefreshing = NO;
        [_reflash beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1500000000), dispatch_get_main_queue(), ^{
            [[ZTNetWorkUtilities sharedInstance]
                doPost:[NSString stringURLWithAppendex:NET_API_PRODUCT_ALL] delegate:self cancelIfExist:YES];
        });
    }
}

#pragma mark - helpers

-(void)initData{
    productNumber = 6;
    titles = @[@"商家",@"美食",@"电影",@"娱乐",@"酒店",@"旅游",@"新单",@"更多"];
    icons =@[@"nearIcon_1",@"nearIcon_2",@"nearIcon_3",@"nearIcon_4",
             @"nearIcon_5",@"nearIcon_6",@"nearIcon_7",@"nearIcon_8"];
    _productList = [NSMutableArray arrayWithArray:[[ZTDataCenter sharedInstance]
                                                   getProductsFromPage:1
                                                   pageSize:10
                                                   offSet:0
                                                   count:productNumber
                                                   orderBy:@"mid" asic:YES type:CKEY_TEAMBUY]];
}

-(void)dragDownRefreshIfNeed{
    if (_productList.count == 0) {
        isAutoRefreshing = YES;
        [UIView animateWithDuration:1.0 animations:^{
           [self.tableView setContentOffset:CGPointMake(0, -160) animated:NO];
        }];
    }
}

@end
