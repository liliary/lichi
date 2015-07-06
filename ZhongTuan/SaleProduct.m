//
//  SaleProduct.m
//  ZhongTuan
//
//  Created by anddward on 15/3/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "ZTSessionView.h"
#import "SaleProduct.h"
#import "WebViewController.h"
#import "StoreViewController.h"
#import "ZTCoverView.h"
#import "ZTSelectedHolder.h"
#import "ZTSessionView.h"
#import "cima.h"
#import "ZTTextContentView.h"
#import "CommentProudentviewcontroller.h"
#import <ShareSDK/ShareSDK.h>
#import "LoginViewController.h"
@interface SaleProduct()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NetResultProtocol>{
    CGFloat _alphaMaxLimit;         // topBar最大透明度
    UICollectionReusableView *_header;
    // data
    NSArray *_recommendProducts;        // 推荐列表
    TeMaiProduct *_product;
    TeMaiProduct* pro;            // 特卖商品
    ZTSessionView*show;            //显示尺码view
    NSMutableArray*arr ;         //尺码数组
    cima*selectcima;             //生成订单传入尺码
    ZTSessionView*canshu;       //参数view
    NSString*param;             //返回参数
    NSString* tiaozhuan;    //跳转
}
@end

@implementation SaleProduct

-(void)viewDidLoad{

    [super viewDidLoad];
          [self initData];
    [self initViews];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.navigationController.navigationBar.hidden =YES;
    self.tabBarController.tabBar.hidden = YES;
   // self.navigationItem.titleView.backgroundColor=[UIColor whiteColor];
    [self loadData];
}

#pragma mark - buildViews
/**
    初始化所有界面
 */
-(void)initViews{
    [self initTopBar];
    [self initRecommends];
    [self initHeaderView];
    [self initBootomBar];
    
    [self.view addSubViews:@[_productRecommended,_topBar,_bottomBar]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/**
    初始化顶部栏
 */
-(void)initTopBar{
    _topBar = [UIView new];
    _topBar.backgroundColor = [UIColor clearColor];
        _backBtn = [UIButton new];
    [_backBtn setImage:[UIImage imageNamed:@"sale_backbtn_bg"] forState:UIControlStateNormal];
    
    [_backBtn addTarget:self action:@selector(didTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _share=[UIButton new];
    _share.backgroundColor=[UIColor clearColor];
   [ _share setImage:[UIImage imageNamed:@"shareaa"]  forState:UIControlStateNormal];
    [_share addTarget:self action:@selector(didTapShareBtn:)  forControlEvents:UIControlEventTouchUpInside];

    [_topBar addSubViews:@[_backBtn,_share]];
}
-(void)didTapShareBtn:(UIButton*)sender{
//NSString *imagePath=[[NSBundle mainBundle]pathForResource:@"ShareSDK" ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"http://app.teambuy.com.cn/tmdetail.php?id=%@",self.pid]
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithUrl:_product.picurl]
                                                title:[NSString stringWithFormat:@"[中团特卖]%@",_product.title]
                                                  url:[NSString stringWithFormat:@"http://app.teambuy.com.cn/tmdetail.php?id=%@",self.pid]
                                
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
   id<ISSContainer> container = [ShareSDK container];
[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                 NSLog(@"发布失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
                                
//                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];


}
/**
    构建头部
 */
-(void)initHeaderView{
    [self initProductInfo];
    [self initItems];
}

/**
    初始化商品信息栏
 */
-(void)initProductInfo{
    _productInfoArea = [ZTSessionView new];
    _productInfoArea.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    _productInfoArea.bottomBorder = YES;
    _productInfoArea.borderWidth = 1.0;
    
    _topPic = [ZTImageLoader new];
    
    _oneShootTag = [UILabel new];
    _oneShootTag.text = @"一口价";
    
    _oneShootPrice = [UILabel new];
    
    _promotionTag = [UILabel new];
    _promotionTag.text = @"新品特惠";
    
    _promotionPrice = [UILabel new];
    _promotionPrice.textColor = [UIColor colorWithHex:0xeb5f62];
    _promotionPrice.font = [UIFont systemFontOfSize:14.0];
    
     _call=[[UIButton alloc]init];
    [_call setImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
    //_phoneBar = [[ZTIconLabel alloc] initWithIcon:[UIImage imageNamed:@"icon_phone"] title:@""];
    //_phoneBar.iconGap = 10.0;
    //_phoneBar.contentGap = 30.0;
    
    [_call addTarget:self action:@selector(storeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    
    _productInfo = [UILabel new];
    _productInfo.lineBreakMode = NSLineBreakByCharWrapping;
    _productInfo.numberOfLines = 0;
    _productInfo.font = [UIFont systemFontOfSize:14.0];
    _productInfo.textColor = [UIColor colorWithHex:0x333333];
    
    NSArray *grayLabels = @[_oneShootTag,_oneShootPrice,_promotionTag];
    for (UILabel *label in  grayLabels) {
        label.font = [UIFont systemFontOfSize:12.0];
        label.textColor = [UIColor colorWithHex:0x9b9b9b];
    }
    
    // debug
    _oneShootPrice.text = @"loading..........";
    _oneShootPrice.attributedText = [@"loading.........." addStriket];
    _promotionPrice.text = @"loading..........";
    _productInfo.text = @"loading..........loading..........loading..........";
    [_productInfoArea addSubViews:@[_oneShootTag,_oneShootPrice,_promotionTag,_promotionPrice,_call,_productInfo]];
}

/**
    初始化item
 */
-(void)initItems{
    _StoreBtn = [[ZTItemButton alloc] initWithTitle:@"查看店铺"];
    [_StoreBtn setTitleColor:[UIColor colorWithHex:0xEB5F62] forState:UIControlStateNormal];
    [_StoreBtn addTarget:self action:@selector(storeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _StoreBtn.borderWidth = 1.0;
    _StoreBtn.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    _StoreBtn.topBorder = YES;
    _StoreBtn.bottomBorder = YES;
    _StoreBtn.indicatorRightPadding = 15.0;
    _StoreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _StoreBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10.0, 0, 0);
    _StoreBtn.backgroundColor = [UIColor whiteColor];
    _StoreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    _productDetailBtn = [SaleBarItem initWithIcon:[UIImage imageNamed:@"sale_detailBtn_bg"] title:@"图文详情" indicator:YES];
    _productDetailBtn.topBorder = YES;
    _productDetailBtn.bottomBorder = YES;
    [_productDetailBtn addTarget:self action:@selector(productDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    _productArgsBtn = [SaleBarItem initWithIcon:[UIImage imageNamed:@"sale_argBtn_bg"] title:@"尺码详情" indicator:YES];
    
    
    _productcanshuBtn = [SaleBarItem initWithIcon:[UIImage imageNamed:@"sale_comBtn_bg"] title:@"产品参数" indicator:YES];
    _productcanshuBtn.topBorder = YES;
    _productcanshuBtn.bottomBorder = YES;
    [_productcanshuBtn addTarget:self action:@selector(showcanshu:) forControlEvents:UIControlEventTouchUpInside];
    
        _productCommentBtn = [SaleBarItem initWithIcon:[UIImage imageNamed:@"sale_comBtn_bg"] title:@"产品评价" indicator:YES];
    _productCommentBtn.topBorder = YES;
    _productCommentBtn.bottomBorder = YES;
    [_productCommentBtn addTarget:self action:@selector(showpingjia:) forControlEvents:UIControlEventTouchUpInside];

    
    _recommendTitle = [[ZTSessionTitle alloc] initWithTitle:@"为你推荐"];
    _recommendTitle.topBorder = YES;
    _recommendTitle.bottomBorder = YES;
    _recommendTitle.borderWidth = 1.0;
    _recommendTitle.backgroundColor = [UIColor whiteColor];
    _recommendTitle.font = [UIFont systemFontOfSize:14.0];
    
    for (SaleBarItem *item in  @[_productDetailBtn,_productcanshuBtn ,_productArgsBtn,_productCommentBtn]) {
        item.borderWidth = 1.0;
        item.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        item.showIndicator = YES;
        item.indicatorRightMargin = 15.0;
        item.iconLeftGap = 10.0;
        item.icon2titleGap = 8.0;
        item.titleLabel.font = [UIFont systemFontOfSize:14.0];
        item.backgroundColor = [UIColor whiteColor];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
-(void)showcanshu:(UIButton*)sender{
//这里可以判断点击收起view
//    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMINFO] delegate:self cancelIfExist:YES ];
//    
//    [ZTCoverView alertCover];
}
-(void)showpingjia:(UIButton*)send{
CommentProudentviewcontroller*vc=[[CommentProudentviewcontroller alloc]init];
    if (_product!=nil) {
        vc.shopid=_product.shopid;
        vc.tmid=self.pid;
    }else{
    vc.tmid=_product.tmid;
        vc.shopid=_product.shopid;}
    [self.navigationController pushViewController:vc animated:YES];


}


-(void)cima:(UIButton*)sender{
    for (UIButton*button in show.subviews) {
        if (button.tag!=sender.tag) {
      
            [button setBackgroundImage:[UIImage imageNamed:@"no_select.png"] forState:UIControlStateNormal];
        }else{
        
                [button setBackgroundImage:[UIImage imageNamed:@"select(2).png"] forState:UIControlStateNormal];
        
        selectcima=arr[sender.tag];
        
        
        }
    }



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
    _productRecommended = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _productRecommended.backgroundColor = [UIColor whiteColor];
    _productRecommended.delegate = self;
    _productRecommended.dataSource = self;
    _productRecommended.showsHorizontalScrollIndicator = NO;
    _productRecommended.showsVerticalScrollIndicator = NO;
    _productRecommended.bounces = NO;
    [_productRecommended registerClass:[SaleCell class] forCellWithReuseIdentifier:@"cell"];
    [_productRecommended registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

/**
    初始化底部bar
 */
-(void)initBootomBar{
    _bottomBar   = [UIView new];
    _bottomBar.backgroundColor = [UIColor whiteColor];
    
    _buyBtn = [ZTRoundButton new];
    [_buyBtn setImage:[UIImage imageNamed:@"sale_buyBtn_bg"] forState:UIControlStateNormal];
    [_buyBtn addTarget:self action:@selector(didTapBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _collectionBtn = [ZTRoundButton new];
    [_collectionBtn setImage:[UIImage imageNamed:@"sale_collectBtn_bg"] forState:UIControlStateNormal];
    [_collectionBtn addTarget:self action:@selector(didTapCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomBar addSubViews:@[_buyBtn,_collectionBtn]];
}

#pragma mark - layoutViews
-(void)viewDidLayoutSubviews{

    // 顶部栏
    [[_topBar setScreenWidth] setRectHeight:77.0];
    [[[_backBtn fitSize] setRectMarginLeft:15.0] setRectMarginTop:26.0];
    [[[_share fitSize]setRectMarginRight:15.0]setRectMarginTop:26.0];
    [[_topPic setScreenWidth] setRectHeight:315.0];
    
    // 产品信息
    [_productInfoArea setScreenWidth];
    [[[_oneShootTag fitSize] setRectMarginLeft:10.0] setRectMarginTop:10.0];
    [[[[_oneShootPrice fitSize] setRectOnRightSideOfView:_oneShootTag] setRectMarginTop:10.0] addRectX:10.0];
    [[[[_promotionTag fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_oneShootTag] addRectY:10.0];
    [[[[[_promotionPrice fitSize] setRectOnRightSideOfView:_promotionTag] addRectX:10.0] setRectBelowOfView:_oneShootPrice] addRectY:10.0];
    [[[_call fitSize]setRectMarginRight:18]setRectMarginTop:50];
  
    [[[[[_productInfo setRectMarginLeft:10.0] widthToEndWithPadding:10.0] fitSize] setRectBelowOfView:_promotionTag]  addRectY:10.0];
    [[[[_productInfoArea wrapContents] setScreenWidth] addRectHeight:12.0] setRectBelowOfView:_topPic];
    
    // items
//    [[[[_StoreBtn setScreenWidth] setRectHeight:44.0] setRectBelowOfView:_productInfoArea] addRectY:7.0];
    [[[[_productArgsBtn setScreenWidth]setRectHeight:44.0]setRectBelowOfView:_productInfoArea]addRectY:7.0];
    if (show) {
        [[[[show wrapContents] setScreenWidth] addRectHeight:12.0] setRectBelowOfView:_productArgsBtn];
        
        [[[_productDetailBtn setScreenWidth]setRectHeight:44.0]setRectBelowOfView:show];}
    else{
    
        [[[_productDetailBtn setScreenWidth] setRectHeight:44.0] setRectBelowOfView:_productArgsBtn];}
    
    
    [[[_productcanshuBtn setScreenWidth] setRectHeight:44.0] setRectBelowOfView:_productDetailBtn];
    
    if (canshu) {
        [[[canshu wrapContents] setScreenWidth] setRectBelowOfView:_productcanshuBtn];
        
        [[[_productCommentBtn setScreenWidth]setRectHeight:44.0]setRectBelowOfView:canshu];
    }
    
    else{ [[[_productCommentBtn setScreenWidth] setRectHeight:44.0] setRectBelowOfView:_productcanshuBtn];}

    [[[[_StoreBtn setScreenWidth] setRectHeight:44.0] setRectBelowOfView:_productCommentBtn] addRectY:7.0];
    
    // 为你推荐

    [[[[_recommendTitle setScreenWidth] setRectHeight:32.0] setRectBelowOfView:_StoreBtn] addRectY:10.0];
    [[_productRecommended setScreenWidth] heightToEndWithPadding:44.0];
    
    // 底部bar
    [[[_bottomBar setScreenWidth] setRectHeight:44.0] setRectMarginBottom:0.0];
    [[[[_buyBtn setRectWidth:139.0] setRectHeight:36.0] setRectMarginTop:5.0] setRectMarginLeft:10.0];
    [[[[_collectionBtn setRectWidth:139.0] setRectHeight:36.0] setRectMarginRight:10.0] setRectMarginTop:5.0];
    
    [_productRecommended reloadData];
    // debug
    _topPic.backgroundColor = [UIColor brownColor];
    
}

//#pragma mark - scrollView delegate
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat line = _topPic.bounds.size.height;
//    if (scrollView.contentOffset.y >= line) {
//        _topBar.alpha = _alphaMaxLimit;
//    }else{
//        _topBar.alpha = scrollView.contentOffset.y/line*_alphaMaxLimit;
//    }
//}
//

#pragma mark - collection view delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _recommendProducts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    TeMaiProduct *product = _recommendProducts[row];
    SaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.pic setImageFromUrl:product.picurl];
    cell.title.text = product.title;
    cell.price.text = [NSString stringWithFormat:@"￥%@",product.dj0];
    cell.del_price.attributedText = [[NSString stringWithFormat:@"￥%@",product.tmdj] addStriket];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (nil == _header) {
        _header = [UICollectionReusableView new];
        
        
        if (canshu) {
            if (show) {
                [_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                                       _productArgsBtn,show,_productcanshuBtn,canshu, _productCommentBtn,_recommendTitle]];
            }else{[_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                                         _productArgsBtn,_productcanshuBtn,canshu, _productCommentBtn,_recommendTitle]];}
            
        }else{
        if (show) {
            [_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                                   _productArgsBtn, show,_productcanshuBtn,_productCommentBtn,_recommendTitle]];
        }
        
        [_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                               _productArgsBtn,_productcanshuBtn, _productCommentBtn,_recommendTitle]];
        }}
    return [_header fillSize];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    _header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (canshu) {
        if (show) {
            [_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                                   _productArgsBtn,show,_productcanshuBtn,canshu, _productCommentBtn,_recommendTitle]];
        }else{[_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                                     _productArgsBtn,_productcanshuBtn,canshu, _productCommentBtn,_recommendTitle]];}
        
    }
    else{

    
    if (show) {
        [_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                               _productArgsBtn,show,_productcanshuBtn, _productCommentBtn,_recommendTitle]];
    }
    [_header addSubViews:@[_topPic,_productInfoArea,_StoreBtn,_productDetailBtn,
                           _productArgsBtn, _productcanshuBtn,_productCommentBtn,_recommendTitle]];
        _header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];}
    return _header;
}
// 点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger row = [indexPath row];
    TeMaiProduct *product =_recommendProducts[row];
    SaleProduct *con = [SaleProduct new];
    con.pid = product.tmid;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - onClick Events

-(void)didTapBackBtn:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didTapCallBtn:(UIButton*)btn{
    
    
}


-(void)didTapBuyBtn:(UIButton*)btn{

 NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
 NSString *token = [def objectForKey:UD_KEY_CURRENT_TOKEN];
    if ( token) {
        if (_product.buytimes!=0) {
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ALLOWBUY] delegate:self cancelIfExist:YES ];
            [ZTCoverView alertCover];
            self.navigationController.navigationBar.tintColor = [UIColor redColor];
            SaleOrderViewController *con = [SaleOrderViewController new];
            con.productId = _pid;
            con.cimaid=selectcima.tmcid;
            con.buynumbers=_product.buynums;
            NSLog(@"%@nimeia%@",con.productId,selectcima.tmcid);
            if (arr&&!selectcima.tmcid) {
                NSString*mess=@"请选择尺码";
                alertShow(mess);
            }else
            {
                if ([tiaozhuan isEqualToString:@"stop"]) {
                    NSLog(@"cacaca");}
                else{[self.navigationController pushViewController:con animated:YES];}
            }
        }
        else{
            self.navigationController.navigationBar.tintColor = [UIColor redColor];
            SaleOrderViewController *con = [SaleOrderViewController new];
            con.productId = _pid;
            con.cimaid=selectcima.tmcid;
            NSLog(@"%@nimeia%@",con.productId,selectcima.tmcid);
            if (arr&&!selectcima.tmcid) {
                NSString*mess=@"请选择尺码";
                alertShow(mess);
            }else
            { [self.navigationController pushViewController:con animated:YES];}}
    }
    else if (!token){
        LoginViewController*loginView=[[LoginViewController alloc]init];
        loginView.ttag=@"sale";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
[self presentViewController:nav animated:YES completion:nil];
    
    
    }
}

-(void)didTapCollectionBtn:(UIButton*)btn{
NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        LoginViewController*loginView=[[LoginViewController alloc]init];
        loginView.ttag=@"sale";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
 [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ADDFAV] delegate:self cancelIfExist:YES ];
        [ZTCoverView alertCover];}


NSLog(@"collect");

}
#pragma mark - helpers
-(void)initData{
    _alphaMaxLimit = 0.6;
    _product = [[ZTDataCenter sharedInstance] getProductWithPid:_pid forType:CKEY_TE_MAI];
NSLog(@"HUAN%@CUN",_product);
    _recommendProducts = [[ZTDataCenter sharedInstance] getProductsFromPage:1 pageSize:2 offSet:0 count:2 orderBy:@"tmid" asic:YES type:CKEY_TE_MAI];
}

-(void)loadData{
    if (nil != _product) {
        [_topPic setImageFromUrl:_product.picurl];
        _oneShootPrice.attributedText = [[NSString stringWithFormat:@"￥%@",_product.dj0] addStriket];
        _promotionPrice.text = [NSString stringWithFormat:@"￥%@",_product.tmdj];
        _productInfo.text = _product.title;
        //获得特卖商品尺码
               [[ZTNetWorkUtilities sharedInstance]doPost:[NSString stringURLWithAppendex:NET_API_GETTMCIMA] delegate:self cancelIfExist:YES];
        //获取产品参数
        
         [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMINFO] delegate:self cancelIfExist:YES ];
        
    }else{
    NSLog(@"meci weikong");
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETATEMAI] delegate:self cancelIfExist:YES ];
        
        
           [ZTCoverView alertCover];
        // TODO: PRODUCT IS NIL FETCH PRODUCT
    }
    
}
#pragma mark - net mork
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
NSLog(@"oko");

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDFAV]]){
        NSString*mess=@"收藏成功";
        alertShow(mess);
    }else if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI]]){
    [_topPic setImageFromUrl:_product.picurl];
    _oneShootPrice.attributedText = [[NSString stringWithFormat:@"￥%@",_product.dj0] addStriket];
    _promotionPrice.text = [NSString stringWithFormat:@"￥%@",_product.tmdj];
    _productInfo.text = _product.title;
    
        //获得特卖商品尺码
        [[ZTNetWorkUtilities sharedInstance]doPost:[NSString stringURLWithAppendex:NET_API_GETTMCIMA] delegate:self cancelIfExist:YES];
        //获取产品参数
        
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMINFO] delegate:self cancelIfExist:YES ];

    }
    else if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMCIMA]])
    {show=[ZTSessionView new];
        show.backgroundColor=[UIColor grayColor];
        for (int i = 0; i<arr.count; i++) {
        cima*size=arr[i];
            UIButton * headerBtn = [[UIButton alloc]initWithFrame:CGRectMake(i%4*80+10, i/4*20+10, 50, 15)];
            [headerBtn setBackgroundImage:[UIImage imageNamed:@"no_select.png"] forState:UIControlStateNormal];
            
            headerBtn.tag =i;
            headerBtn.backgroundColor=[UIColor clearColor];
            [headerBtn setImage:nil forState:UIControlStateNormal];
            [headerBtn setTitle:size.chima forState:UIControlStateNormal];
            headerBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
            headerBtn.titleLabel.textColor = [UIColor colorWithHex:0x323232];

            [headerBtn addTarget:self action:@selector(cima:) forControlEvents:UIControlEventTouchUpInside];
            
            [show addSubview:headerBtn];
        }
        
        
        [self viewDidLayoutSubviews];
    
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMINFO]]) {
        canshu=[ZTSessionView new];
        canshu.backgroundColor=[UIColor blueColor];
      ZTTextContentView*canshulabel=[[ZTTextContentView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    canshulabel.backgroundColor=[UIColor grayColor];
        //[canshulabel wrapContents];
        canshulabel.text=param;
   [canshu addSubview:canshulabel];
         [self viewDidLayoutSubviews];
    }
    //限购返回
    else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ALLOWBUY]]){
    
    
    }
    
    [ZTCoverView dissmiss];

}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ALLOWBUY]])
    {
        UIAlertView*deleaddress=[[UIAlertView alloc]initWithTitle:@"提示" message:errmsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil, nil];
        [deleaddress show];
    
   // alertShow(errmsg);
    //tiaozhuan=@"stop";
    }
    [ZTCoverView dissmiss];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
[self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            NSLog(@"取消1");
        break;}
}


-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI] ])
    {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_TEMAI_TMID:[NSString stringWithFormat:@"%@",self.pid],                                                                          }];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDFAV]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_LBID:[NSString stringWithFormat:@"%@",self.pid],
                                          NET_ARG_UFLB:@"cpmx-tm",
                                          NET_ARG_LNGOADDFAV:[NSString stringWithFormat:@"%@",[self getlngo]],
                                          NET_ARG_LATOADDFAV:[NSString stringWithFormat:@"%@",[self getlato]],                                                                         }];
    } if ([request isEqualToString:[NSString stringURLWithAppendex: NET_API_GETTMCIMA]]) {
        [params addEntriesFromDictionary:@{NET_ARG_TMID:_product.tmid}];
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMINFO]]) {
        [params addEntriesFromDictionary:@{NET_ARG_TMID_GETTMINFO:_product.tmid}];
        
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ALLOWBUY]]) {
        [params addEntriesFromDictionary:@{NET_ARG_ALLOWBUY_TMID:_product.tmid,
                                           NET_ARG_ALLOWBUY_BUYTIMES:_product.buytimes}];
        
    }

    
}
-(NSNumber*)getlngo
{    return [[NSUserDefaults standardUserDefaults]objectForKey:@"long"];}
-(NSNumber*)getlato
{return [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];}

-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
NSLog(@"notok%@",result);

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI] ])
    { _product=[[TeMaiProduct alloc]init];
        _product.picurl=[result objectForKey:@"picurl"];
    _product.dj0=[result objectForKey:@"dj0"];

    _product.tmdj=[result objectForKey:@"tmdj"];
     
    _product.title=[result objectForKey:@"title"];
    _product.shopid=[result objectForKey:@"shopid"];
      _product.tmid=[result objectForKey:@"tmid"];
      _product.buynums=[result objectForKey:@"buynums"];
      _product.buytimes=[result objectForKey:@"buytimes"];
    NSLog(@"xiangou%@",result);
       
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMCIMA]]) {
    //返回尺码进行处理
        NSArray *cimas = [(NSArray*)result jsonParseToArrayWithType:[cima class]];
        
        arr=[NSMutableArray array];
        [arr removeAllObjects];
        [arr addObjectsFromArray:cimas];

    
        
    }
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMINFO]])
    {NSLog(@"caca%@o",result);
   param=[[NSString alloc]init];
    param=[result objectForKey:@"param"];
    NSLog(@"%@",param);
    }
    
    //限购返回
    else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ALLOWBUY]]){
       NSLog(@"limit%@",result);
        
    }
}
#pragma mark - “查看店铺”按钮点击
- (void)storeBtnClick:(UIButton *)btn{

    StoreViewController *storeVC = [[StoreViewController alloc] init];
    if (_product!=nil) {
        storeVC.shopidd=_product.shopid;
    }else{
        storeVC.shopidd=_product.shopid;}
    
   [self.navigationController pushViewController:storeVC animated:YES];
}

/** 
 *  图文详情
 */
-(void)productDetail:(UIButton *)btn{
    WebViewController *webVc = [[WebViewController alloc] init];
   
   // webVc.urlStr = [NSString stringWithFormat:@"http://app.teambuy.com.cn/webc/m/tmlog/id/%d",];
   webVc.urlStr = [NSString stringWithFormat:@"http://app.teambuy.com.cn/webc/m/temai/id/%@",self.pid];
    [self.navigationController pushViewController:webVc animated:YES];
    
}
@end
