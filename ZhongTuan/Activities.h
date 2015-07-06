//
//  Activities.h
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface Activities : Model

@property (strong,nonatomic) NSNumber* tgno;
@property (strong,nonatomic) NSString* tgname;  // 活动名称
@property (strong,nonatomic) NSString* title;   // 标题
@property (strong,nonatomic) NSString* address; // 活动地址
@property (strong,nonatomic) NSString* url;
@property (strong,nonatomic) NSString* tdate;
@property (strong,nonatomic) NSString* ttime;   //
@property (strong,nonatomic) NSString* bmtel;   // 报名电话
@property (strong,nonatomic) NSString* bmqq;    // 报名qq
@property (strong,nonatomic) NSString* picurl;  // 图片链接
@property (strong,nonatomic) NSString* zt;      //
@property (strong,nonatomic) NSString* xh;      // 排序用,序号
@property (strong,nonatomic) NSString* edate;   //结束时间
@property (strong,nonatomic) NSString* detail;  //活动详情
@property (strong,nonatomic) NSString* memo;    //活动优惠
@property (strong,nonatomic) NSString* picbrand;// 参与品牌
@property (strong,nonatomic) NSString* picpro;  //特价产品
@property (strong,nonatomic) NSString* www;     //交通路线
@property (strong,nonatomic) NSString* reapp;   //是否允许重复报名

@end
