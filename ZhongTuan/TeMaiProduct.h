//
//  TeMaiProduct.h
//  ZhongTuan
//
//  Created by anddward on 15/2/3.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface TeMaiProduct : Model
@property (strong,nonatomic) NSNumber* bests ;//好评
@property (strong,nonatomic) NSNumber* collects ;//收藏
@property (strong,nonatomic) NSString* content; //商品详情
@property (strong,nonatomic) NSNumber* cpdl ;//大类id
@property (strong,nonatomic) NSNumber* cpxl ;// 小类id
@property (strong,nonatomic) NSString* dfen ;//评分
@property (strong,nonatomic) NSString* dj0 ;//原价
@property (strong,nonatomic) NSString* dj1 ;//优惠价
@property (strong,nonatomic) NSString* edate;//下架时间
@property (strong,nonatomic) NSString* jldw ;//计量单位
@property (strong,nonatomic) NSNumber* kcsl ;//库存
@property (strong,nonatomic) NSNumber* mid ;//单品id
@property (strong,nonatomic) NSNumber* ok ;//是否上架状态
@property (strong,nonatomic) NSString* picurl;//图片网址
@property (strong,nonatomic) NSString* rebate ;//销售返点
@property (strong,nonatomic) NSString* sdate ;//上架时间
@property (strong,nonatomic) NSNumber* sells ;//销量
@property (strong,nonatomic) NSNumber* shopid ;//店铺id
@property (strong,nonatomic) NSString* title ;//商品名称
@property (strong,nonatomic)NSNumber* tmdj ;//特卖商品价格
@property (strong,nonatomic) NSNumber* tmid ;//特卖商品id
@property (strong,nonatomic) NSString* tmlb ;//特卖类型
@property (strong,nonatomic) NSString* tmurl;//专题网址
@property (strong,nonatomic) NSString* tmword;//促销词
@property (strong,nonatomic) NSNumber* xh ;//排序
@property (strong,nonatomic) NSString* zkl ;//折扣
@property(strong,nonatomic) NSNumber*buynums;//m买的多少
@property(strong,nonatomic) NSNumber*buytimes;//买的次数

//@property (strong,nonatomic) NSNumber* tmid;    //特卖id
//@property (strong,nonatomic) NSString* title;   //特卖标题
//@property (strong,nonatomic) NSString* tmword;  //特卖描述
//@property (strong,nonatomic) NSString* tmlb;    //特卖类别  dp 打开产品, zt 打开webView
//@property (strong,nonatomic) NSString* tmurl;   //特卖url
//@property (strong,nonatomic) NSNumber* mid;     //特卖产品id
//@property (strong,nonatomic) NSNumber* tmdj;    //特卖价格
//@property (strong,nonatomic) NSString* sdate;   //特卖开始时间
//@property (strong,nonatomic) NSString* edate;   //特卖结束时间
//@property (strong,nonatomic) NSString* picurl;  //特卖图片
//@property (strong,nonatomic) NSNumber* xh;      //序号
//@property (strong,nonatomic) NSNumber* dj0;     //原价?
//@property (strong,nonatomic) NSNumber* dj1;     //???
//@property (strong,nonatomic) NSString* zkl;     //折扣

@end
