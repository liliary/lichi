//
//  User.h
//  ZhongTuan
//
//  Created by anddward on 14-11-6.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model.h"
#import "User.h"

@interface orderInfo : Model
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * city;
@property (nonatomic, retain) NSNumber * coid ;
@property (nonatomic, retain) NSString * cpmx ;
@property (nonatomic, retain) NSString * dateandtime;
@property (nonatomic, retain) NSString * fapiao;
@property (nonatomic, retain) NSString * fcpmc ;
@property (nonatomic, retain) NSString * fcpmid;
@property (nonatomic, retain) NSString * fcppic ;
@property (nonatomic, retain) NSNumber * lato ;
@property (nonatomic, retain) NSNumber * lngo ;
@property (nonatomic, retain) NSString * logco ;//快递公司
@property (nonatomic, retain) NSNumber * logid ;//快递id
@property (nonatomic, retain) NSString * logno ;//物流单号
@property (nonatomic, retain) NSNumber * ordje ;
@property (nonatomic, retain) NSString * ordno ;
@property (nonatomic, retain) NSNumber * ordsl ;
@property (nonatomic, retain) NSNumber * ordzt ;
@property (nonatomic, retain) NSNumber * payje ;
@property (nonatomic, retain) NSString * paym ;
@property (nonatomic, retain) NSNumber * province ;
@property (nonatomic, retain) NSNumber * refje ;
@property (nonatomic, retain) NSString * rememo ;
@property (nonatomic, retain) NSNumber * sendid ;
@property (nonatomic, retain) NSString * sendm ;
@property (nonatomic, retain) NSNumber * shopid ;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * truename ;
@property (nonatomic, retain) NSString * username ;
@property (nonatomic, retain) NSNumber * zfen ;
@property (nonatomic, retain) NSString * zipcode;

//@property (nonatomic, retain) NSNumber * coid;       // 订单id
//@property (nonatomic, retain) NSString * ordno;  // 用户名
//@property (nonatomic, retain) NSNumber * shopid;   // 商铺id
//@property (nonatomic, retain) NSString * username;  // 用户昵称
//@property (nonatomic, retain) NSNumber * ordsl;    // 订单商品数量
//@property (nonatomic, retain) NSNumber * ordje;     // 订单金额
//@property (nonatomic, retain) NSNumber * sex;       // 用户性别
//@property (nonatomic, retain) NSNumber * ordzt;  // 用户生日
//@property (nonatomic, retain) NSString * dateandtime;   //下单时间
//@property (nonatomic, retain) NSNumber * sendid;   // 送货时间
//@property (nonatomic, retain) NSNumber * zfen;   // 用户注册日期
//@property (nonatomic, retain) NSString * rememo;     // 订单评价内容
//@property (nonatomic, retain) NSNumber * province;  // 上次登录时间
//@property (nonatomic, retain) NSNumber * city;    // 最近登录 ip
//@property (nonatomic, retain) NSNumber * areac;    //
//@property (nonatomic, retain) NSString * address;  // 订单地址
//@property (nonatomic, retain) NSString * truename;  // 收货人
//@property (nonatomic, retain) NSString * tel;  // 用户电话
//@property (nonatomic, retain) NSString * zipcode;  // 邮编
//@property (nonatomic, retain) NSNumber * lngo;  // 订单经度
//@property (nonatomic, retain) NSNumber * lato;  // 订单纬度
//@property (nonatomic, retain) NSString * paym;  // 支付方式
//@property (nonatomic, retain) NSNumber * payje;  // 付款金额
//@property (nonatomic, retain) NSNumber * refje;  // 退款金额
//@property (nonatomic, retain) NSString * sendm;  // 送货方式
//@property (nonatomic, retain) NSString * fapiao;  // 订单发票
//@property (nonatomic, retain) NSNumber * fcpmid;  // 产品id
//@property (nonatomic, retain) NSString * fcpmc;  // 产品名臣
//@property (nonatomic, retain) NSString * fcppic;  // 产品图片
//@property (nonatomic, retain) NSString  * cpmx;  // 用户 token
//@property(nonatomic,retain)NSString*

@end
