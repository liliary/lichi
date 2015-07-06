//
//  Product.h
//  ZhongTuan
//
//  Created by anddward on 15/1/10.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface TeamBuyProduct : Model

@property (strong,nonatomic) NSNumber* mid;         // 商品id
@property (strong,nonatomic) NSString* cpmc;        // 商品名称
@property (strong,nonatomic) NSString* cpgc;        // 商品规格
@property (strong,nonatomic) NSString* picurl;      // 商品图片
@property (strong,nonatomic) NSNumber* cpdl;        // 大类id
@property (strong,nonatomic) NSNumber* cpxl;        // 小类id
@property (strong,nonatomic) NSString* urlqrcode;   // 二维码code
@property (strong,nonatomic) NSNumber* dj0;         // 原价
@property (strong,nonatomic) NSNumber* dj1;         // 折扣价格
@property (strong,nonatomic) NSNumber* dj2;         // 中团价格
@property (strong,nonatomic) NSNumber* kcsl;        // 库存数量
@property (strong,nonatomic) NSString* sells;       // 销量
@property (strong,nonatomic) NSString* jldw;        // 单位
@property (strong,nonatomic) NSString* bests;       // 好评
@property (strong,nonatomic) NSString* collects;    // 收藏
@property (strong,nonatomic) NSString* shopid;      // 商铺 id
@property (strong,nonatomic) NSString* content;     // 商品描述
@property (strong,nonatomic) NSString* cpmemo;      //套餐详情
@property (strong,nonatomic) NSString* sysm;        //消费提醒

@end
