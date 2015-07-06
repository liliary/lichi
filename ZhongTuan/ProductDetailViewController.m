//
//  ProductDetailViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/3.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
//  TODO:询问缓存 product,如果没有,网络请求,如果请求失败,弹出提示框,确认后pop回主界面

#import "ProductDetailViewController.h"
#import "TeamBuyProduct.h"
#import "ZTTitleLabel.h"
#import "ZTTiView.h"
#import "ZTIconLabel.h"
#import "ZTStarBar.h"
#import "ZTImageLoader.h"
#import "ZTContentLabel.h"
#import "ZTSessionView.h"
#import "ZTTextContentView.h"
#import "ZTSessionTitle.h"
#import "TeambuyOrderViewController.h"
#import "ZTRoundButton.h"

@interface ProductDetailViewController (){
    /// data
    TeamBuyProduct* _product;
    BOOL isDataLoadComplete;
    
    /// views
    UIScrollView* _sv;
    UIView *_layoutTop;
    
    ZTImageLoader* _topPic;             // 顶部图片
    UIImageView* _topCorner;            // 左上角标识
    
    // 基本信息
    ZTTiView* _productTitle;            // 商品名称
    // 销售信息
    ZTSessionView* _sellBar;
    ZTIconLabel* _sell;                 // 销量
    ZTIconLabel* _guarantee;            // 消费保障条
    ZTStarBar* _starBar;                // 评分条
    
    // 商家信息
    ZTSessionView* _storeInfoSession;   // 商家信息部分
    ZTSessionTitle* _storeInfoTitle;    // 标题
    ZTTiView* _storeInfo;               // 商家信息
    ZTIconLabel* _phoneBar;             // 商家电话
    
    // 套餐内容
    ZTSessionView* _contentSession;     // 套餐内容部分
    ZTSessionTitle* _contentTitle;      // 套餐内容标题
    ZTTextContentView* _content;        // 套餐内容
    UIButton* _detailBtn;               // 图文详情
    
    // 消费提示
    ZTSessionView* _warningSession;     // 消费提醒部分
    ZTSessionTitle* _warningTitle;      // 消费提醒标题
    ZTTextContentView* _warningContent; // 消费提醒内容
    
    // 评价
    ZTSessionView* _commentSession;     // 评价部分
    ZTSessionTitle* _commentTitle;      // 评价标题
    ZTTextContentView* _commentContent; // 评论详情
    
    // 购买条
    ZTSessionView* _buyBarTransparentMask;
    UIView* _buyBar;
    UILabel* _price;
    UILabel* _originPrice;
    ZTRoundButton* _buyBtn;
}

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
}

-(void)viewDidLayoutSubviews{
    [_sv setRectScreen];
    
    [[[_topPic setScreenWidth] setRectHeight:200.0] setRectBelowOfView:_layoutTop];
    [[_topCorner fitSize] setRectBelowOfView:_layoutTop];
    
    [[[_productTitle fitSize] setScreenWidth] setRectBelowOfView:_topPic];
    
    [[[_sellBar setScreenWidth] setRectHeight:34.0] setRectBelowOfView:_productTitle];
    [[_sell fitSize] setRectCenterVertical];
    [[[_guarantee fitSize] setRectMarginRight:10.0] setRectCenterVertical];
    [[[[_starBar fitSize] setRectBelowOfView:_sellBar] setScreenWidth] setRectHeight:30.0];
    
    [[[_storeInfoTitle fitSize] setScreenWidth] setRectHeight:30.0];
    [[[_storeInfo fitSize] setScreenWidth] setRectBelowOfView:_storeInfoTitle];
      
    [[[[_phoneBar fitSize] setScreenWidth] setRectHeight:30.0] setRectBelowOfView:_storeInfo];
    [[[_storeInfoSession wrapContents] setRectBelowOfView:_starBar] addRectY:10.0];
    
    [[[_contentTitle fitSize] setScreenWidth] setRectHeight:30.0];
    [[[_content fitSize] setRectBelowOfView:_contentTitle] setScreenWidth];
    [[[[_detailBtn fitSize] setScreenWidth] setRectHeight:28.0]
        setRectBelowOfView:_content];
    [[[_contentSession wrapContents] setRectBelowOfView:_storeInfoSession] addRectY:10.0];
    
    [[[_warningTitle fitSize] setScreenWidth] setRectHeight:30.0];
    [[[_warningContent fitSize] setRectBelowOfView:_warningTitle] setScreenWidth];
    [[[[_warningSession wrapContents] addRectHeight:1.0] setRectBelowOfView:_contentSession] addRectY:10.0];
    
    [[[_commentTitle fitSize] setScreenWidth] setRectHeight:30.0];
    [[[_commentContent fitSize] setRectBelowOfView:_commentTitle] setScreenWidth];
    [[[[_commentSession wrapContents] addRectHeight:1.0] setRectBelowOfView:_warningSession] addRectY:10.0];
    
    [[[_buyBarTransparentMask setScreenWidth] setRectHeight:50.0] setRectMarginBottom:0.0];
    [[[_buyBar setScreenWidth] setRectHeight:50.0] setRectMarginBottom:0.0];
    [[[_price fitSize] setRectMarginLeft:10.0] setRectCenterVertical];
    [[[[[_originPrice fitSize] setRectOnRightSideOfView:_price] addRectX:6.0] setRectCenterVertical] addRectY:2.0];
    [[[[_buyBtn fitSize] setRectWidth:142.5] setRectMarginRight:10.0]setRectCenterVertical];
    
    CGSize contentSize = [_sv fillSize];
    contentSize.height += 30;
    _sv.contentSize = contentSize;
}

#pragma mark - buildViews

-(void)initTitleBar{
    ZTTitleLabel* titleView = [[ZTTitleLabel alloc] initWithTitle:@"商品详情"];
    [titleView fitSize];
    self.navigationItem.titleView = titleView;
}

-(void)buildViews{
    /// bg
    _layoutTop = (UIView*)self.topLayoutGuide;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _sv = [UIScrollView new];
    _sv.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.userInteractionEnabled = YES;
    
    /// 顶部图片
    _topPic = [ZTImageLoader new];
    _topCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w_reservation"]];
    /// 商品标题
    _productTitle = [ZTTiView new];
    _productTitle.leftGap = 10.0;
    _productTitle.topLayout = 15.0;
    _productTitle.bottomLayout = 10.0;
    _productTitle.titleLabelUp = 5.0;
    _productTitle.infoLabelDown = 5.0;
    /// 销售bar
    _sellBar = [ZTSessionView new];
    _sellBar.topBorder = YES;
    _sellBar.bottomBorder = YES;
    _sellBar.borderWidth = 0.5;
    /// 销量
    _sell = [[ZTIconLabel alloc] initWithIcon:[UIImage imageNamed:@"icon_sell"] title:@"销量:"];
    _sell.iconGap = 10.0;
    _sell.contentGap = 8.0;
    /// 7天保退
    _guarantee = [[ZTIconLabel alloc] initWithIcon:[UIImage imageNamed:@"icon_guarantee"] title:@"7天包退保障"];
    _guarantee.contentGap = 8.0;
    [_sellBar addSubViews:@[_sell,_guarantee]];
    
    /// 评分条
    _starBar = [[ZTStarBar alloc] initWithFillStar:[UIImage imageNamed:@"w_star_fill"] emptyStar:[UIImage imageNamed:@"w_star_empty"] count:5 gap:5.0];
    _starBar.scoreGap = 10.0;
    _starBar.leftGap = 10.0;
    _starBar.scoreLabel.textColor = [UIColor colorWithHex:0xff9c00];
    _starBar.bottomBorder = YES;
    _starBar.borderWidth = 1.0;
    
    /// 商家信息
    _storeInfoSession = [ZTSessionView new];
    _storeInfoSession.borderWidth = 1.0;
    _storeInfoSession.topBorder = YES;
    _storeInfoSession.bottomBorder = YES;
    _storeInfoTitle = [[ZTSessionTitle alloc] initWithTitle:@"商家信息"];
    _storeInfo = [ZTTiView new];
    _storeInfo.topBorder = YES;
    _storeInfo.bottomBorder = YES;
    _storeInfo.borderWidth = 0.5;
    _storeInfo.leftGap = 10.0;
    _storeInfo.topLayout = 10.0;
    _storeInfo.bottomLayout = 10.0;
    _storeInfo.titleLabelUp = 5.0;
    _storeInfo.infoLabelDown = 5.0;
    _phoneBar = [[ZTIconLabel alloc] initWithIcon:[UIImage imageNamed:@"icon_phone"] title:@""];
    _phoneBar.iconGap = 10.0;
    _phoneBar.contentGap = 30.0;
    [_storeInfoSession addSubViews:@[_storeInfoTitle,_storeInfo,_phoneBar]];
    
    /// 商品详情
    _contentSession = [ZTSessionView new];
    _contentSession.topBorder = YES;
    _contentSession.bottomBorder = YES;
    _contentSession.borderWidth = 1.0;
    _contentTitle = [[ZTSessionTitle alloc] initWithTitle:@"套餐内容"];
    _content = [ZTTextContentView new];
    _content.topBorder = YES;
    _content.bottomBorder = YES;
    _content.borderWidth = 0.5;
    _content.editable = NO;
    _content.scrollEnabled = NO;
    _content.selectable = NO;
    _content.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _content.font = [UIFont systemFontOfSize:12.0];
    _content.textColor = [UIColor colorWithHex:0x969696];
    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailBtn setTitle:@"查看图文详情" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _detailBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_detailBtn setImage:[UIImage imageNamed:@"btn_rightArrow"] forState:UIControlStateNormal];
    _detailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -220, 0, 0);
    _detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 300, 0, 0);
    [_detailBtn addTarget:self action:@selector(didTapDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentSession addSubViews:@[_contentTitle,_content,_detailBtn]];
    
    /// 消费提醒
    _warningSession = [ZTSessionView new];
    _warningSession.topBorder = YES;
    _warningSession.bottomBorder = YES;
    _warningSession.borderWidth = 1.0;
    _warningTitle = [[ZTSessionTitle alloc] initWithTitle:@"消费提醒"];
    _warningContent = [ZTTextContentView new];
    _warningContent.topBorder = YES;
    _warningContent.borderWidth = 0.5;
    _warningContent.editable = NO;
    _warningContent.selectable = NO;
    _warningContent.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _warningContent.scrollEnabled = NO;
    _warningContent.font = [UIFont systemFontOfSize:12.0];
    _warningContent.textColor = [UIColor colorWithHex:0x969696];
    [_warningSession addSubViews:@[_warningTitle,_warningContent]];
    
    /// 评论
    _commentSession = [ZTSessionView new];
    _commentSession.topBorder = YES;
    _commentSession.bottomBorder = YES;
    _commentSession.borderWidth = 1.0;
    _commentTitle = [[ZTSessionTitle alloc] initWithTitle:@"商品评论"];
    _commentContent = [ZTTextContentView new];
    _commentContent.topBorder = YES;
    _commentContent.borderWidth = 0.5;
    _commentContent.editable = NO;
    _commentContent.selectable = NO;
    _commentContent.scrollEnabled = NO;
    _commentContent.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _commentContent.font = [UIFont systemFontOfSize:12.0];
    _commentContent.textColor = [UIColor colorWithHex:0x969696];
    [_commentSession addSubViews:@[_commentTitle,_commentContent]];
    
    // 购买条
    _buyBarTransparentMask = [ZTSessionView new];
    _buyBarTransparentMask.borderWidth = 1.0;
    _buyBarTransparentMask.topBorder = YES;
    _buyBarTransparentMask.alpha = 0.8;
    _buyBar = [UIView new];
    _buyBar.backgroundColor = [UIColor clearColor];
    _price = [UILabel new];
    _price.font = [UIFont systemFontOfSize:17.0];
    _price.textColor = [UIColor colorWithHex:0xCE5F62];
    _originPrice = [UILabel new];
    _originPrice.font = [UIFont systemFontOfSize:11.0];
    _buyBtn = [[ZTRoundButton alloc] initWithTitle:@"立即抢购" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_buy"]];
    [_buyBtn addTarget:self action:@selector(didTapBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buyBar addSubViews:@[_price,_originPrice,_buyBtn]];
    [_sv addSubViews:@[_topPic,_topCorner,_productTitle,_sellBar,_starBar,_storeInfoSession,_contentSession,_warningSession,_commentSession]];
    [self.view addSubViews:@[_sv,_buyBarTransparentMask,_buyBar]];
}

#pragma mark - onClick Events

-(void)didTapDetailBtn:(UIButton*)btn{
    
}

-(void)didTapBuyButton:(UIButton*)btn{
    self.navigationController.navigationBar.topItem.title = @"返回";
    TeambuyOrderViewController *controller = [TeambuyOrderViewController new];
    controller.productId = _product.mid;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - helpers

-(void)initData{
    // TODO: 查询商家,如果商家不存在,网络请求商家信息
    _product = [[ZTDataCenter sharedInstance] getProductWithPid:_productId forType:CKEY_TEAMBUY];
}

-(void)loadData{
    [_topPic setImageFromUrl:_product.picurl];
    _productTitle.titleLabel.text = _product.cpmc;
    _productTitle.infoLabel.text = _product.cpgc;
    _sell.titleView.text = [NSString stringWithFormat:@"销量:%@",_product.cpxl];
    // TODO: 评分接口
    _starBar.score = 5;
    // TODO: 商家接口
    _storeInfo.titleLabel.text = @"车前宅配寿司";
    _storeInfo.infoLabel.text = @"广州市天河区珠江新城花城汇北区uupark商场891";
    _phoneBar.titleView.text = @"13620901006";
    // TODO: 评价接口
    _content.text = [_product.cpmemo isEqualToString:@""]?@"暂无套餐内容":_product.cpmemo;
    _warningContent.text = [_product.sysm isEqualToString:@""]?@"暂无消费提醒":_product.sysm;
    _commentContent.text = @"暂无评论";
    _price.text = [NSString stringWithFormat:@"￥%@",_product.dj2];
    _originPrice.attributedText = [[NSString stringWithFormat:@"￥%@",_product.dj0] addStriket];
}

@end
