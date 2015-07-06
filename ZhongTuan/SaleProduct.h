//
//  SaleProduct.h
//  ZhongTuan
//
//  Created by anddward on 15/3/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZTItemButton.h"
#import "ZTRoundButton.h"
#import "ZTSessionView.h"
#import "SaleBarItem.h"
#import "ZTSessionTitle.h"
#import "SaleCell.h"
#import "TeMaiProduct.h"
#import "ZTImageLoader.h"
#import "TeambuyOrderViewController.h"
#import "SaleOrderViewController.h"
@interface SaleProduct : UIViewController
// 顶部栏
@property (nonatomic,strong) UIView *topBar;         // 顶部栏
@property (nonatomic,strong) UIButton *backBtn;         // 返回按钮
@property(nonatomic,strong)UIButton*share;              //分享按钮
// 商品图片
@property (nonatomic,strong) ZTImageLoader *topPic;       // 顶部产品大图
// 商品信息
@property (nonatomic,strong) ZTSessionView *productInfoArea;       // 产品信息栏
@property (nonatomic,strong) UILabel *oneShootTag;      // "一口价"tag
@property (nonatomic,strong) UILabel *oneShootPrice;    // 一口价
@property (nonatomic,strong) UILabel *promotionTag;     // 新品特惠tag
@property (nonatomic,strong) UILabel *promotionPrice;   // 新品特惠价格
@property(nonatomic,strong) UIButton*call;           //联系商家
@property (nonatomic,strong) UILabel *productInfo;   // 产品简介
// 产品尺码/颜色分类
@property (nonatomic,strong) ZTItemButton *StoreBtn;   // 产品查看店铺
// 图文详情
@property (nonatomic,strong) SaleBarItem *productDetailBtn;   // 图文详情按钮
// 产品尺码
@property (nonatomic,strong) SaleBarItem *productArgsBtn;     // 产品尺码按钮
// 产品参数
@property (nonatomic,strong) SaleBarItem *productcanshuBtn;     // 产品参数按钮
// 产品评价
@property (nonatomic,strong) SaleBarItem *productCommentBtn;  // 产品推荐按钮
// 产品推荐
@property (nonatomic,strong) ZTSessionTitle *recommendTitle;
@property (nonatomic,strong) UICollectionView *productRecommended;
// 底部栏
@property (nonatomic,strong) UIView *bottomBar;
@property (nonatomic,strong) ZTRoundButton *buyBtn;
@property (nonatomic,strong) ZTRoundButton *collectionBtn;
// 数据
@property (nonatomic,strong) NSNumber* pid;


@end
