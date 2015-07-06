//
//  ActivitiesController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-4.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//  TODO:添加页面切换的网络取消
//  TODO:初始化时,当列表为空,自动下拉操作

#import "ActivitiesController.h"
#import "ZTButtonGridView.h"
#import "ActivitiesCell.h"
#import "ZTTitleLabel.h"
#import "Activities.h"

@interface ActivitiesController ()<NetResultProtocol>{
    
    /// header
    ZTButtonGridView *_cateGoryButton;
    UIView *_headerView;
    UIRefreshControl* _refresh;
    
    /// data
    NSDictionary *_category_source;
    NSMutableArray* _HD_productList;
    
    // scroll
    BOOL isAutoScrolling;
}

@end

@implementation ActivitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self initTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self dragDownRefreshIfNeed];
}



#pragma mark - build views

-(void)initTitleBar{
    
    ZTTitleLabel *titleView = [[ZTTitleLabel alloc] initWithTitle:@"线下活动"];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"sale_search"] forState:UIControlStateNormal];
    
    [titleView fitSize];
    [searchButton fitSize];
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = rightBarbutton;
    self.navigationItem.titleView = titleView;
}

-(void)buildHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _cateGoryButton = [[ZTButtonGridView alloc] initWithIcons:_category_source cell:@"ZTButtonCell" column:4 rowSpace:1.0 columnSpace:1.0 edgeSpace:1.0];
    _cateGoryButton.bottomBorder = YES;
    _cateGoryButton.borderWidth = 1.0;
    [self.tableView setTableHeaderView:_cateGoryButton];
}

-(void)initTableView{
    [self buildHeaderView];
    
    /// refresh control
    _refresh = [UIRefreshControl new];
    _refresh.tintColor = [UIColor magentaColor];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:nil];
    [_refresh addTarget:self action:@selector(didReloadData:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _refresh;
    
    self.tableView.bounces = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ActivitiesCell class] forCellReuseIdentifier:@"cell"];
}


#pragma mark - tableviw delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 265.0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_HD_productList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    Activities *atItem = _HD_productList[row];
    ActivitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ActivitiesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.topPic setImageFromUrl:atItem.picurl];
    cell.title.text = atItem.title;
    cell.aTime.text = atItem.tdate;
    cell.aPhone.text = atItem.bmtel;
    cell.aQQ.text = atItem.bmqq;
    cell.aAddress.text = atItem.address;
    return cell;
}

#pragma mark - Event Status

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // TODO: 自动下拉独立出来做成tableview内置功能
    if (isAutoScrolling && scrollView.contentOffset.y<90) {
        isAutoScrolling = NO;
        [_refresh beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2000000000), dispatch_get_main_queue(), ^{
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ACTIVITIES_ALL] delegate:self cancelIfExist:YES];
        });
    }
}

-(void)didReloadData:(UIRefreshControl*)sender{
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在加载数据...." attributes:nil];
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ACTIVITIES_ALL] delegate:self cancelIfExist:YES];
}

-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    [params addEntriesFromDictionary:@{ NET_ARG_ACTVT_AC:@"020",NET_ARG_ACTVT_PAGE:@"1",}];
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{
    NSArray *huoDongArray = [(NSArray*)result jsonParseToArrayWithType:[Activities class]];
    [[ZTDataCenter sharedInstance] clearAllProductsForType:CKEY_HUODONG];
    [[ZTDataCenter sharedInstance] saveProducts:huoDongArray forType:CKEY_HUODONG];
    [_HD_productList removeAllObjects];
    _HD_productList = [NSMutableArray arrayWithArray:[[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:-1 orderBy:@"xh" asic:YES type:CKEY_HUODONG]];
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    [_refresh endRefreshing];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:nil];
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    [_refresh endRefreshing];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松手刷新数据" attributes:nil];
    [self.tableView reloadData];
}

#pragma mark - helpers
-(void)initData{
    _category_source =
    @{@"icons":@[@"at_01",
               @"at_02",
               @"at_03",
               @"at_04",
               @"at_05",
               @"at_06",
               @"at_07",
               @"at_08"],
    @"titles":@[@"房产",
                @"家居",
                @"结婚",
                @"汽车",
                @"教育",
                @"相亲",
                @"聚会",
                @"团博会"],
    };
    _HD_productList = [NSMutableArray arrayWithArray:[[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:10 offSet:0 count:-1 orderBy:@"tgno" asic:YES type:CKEY_HUODONG]];
}

-(void)dragDownRefreshIfNeed{
    if (_HD_productList.count == 0) {
        isAutoScrolling = YES;
        [UIView animateWithDuration:1.0 animations:^{
            [self.tableView setContentOffset:CGPointMake(0, -160) animated:NO];
        }];
    }
}

@end
