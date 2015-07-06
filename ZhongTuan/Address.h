//
//  Address.h
//  ZhongTuan
//
//  Created by anddward on 15/3/9.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface Address : Model
@property (nonatomic,strong) NSString* address;     // 地址
@property (nonatomic,strong) NSNumber* carea;       // 区域编号
@property (nonatomic,strong) NSNumber* city;        // 城市id
@property (nonatomic,strong) NSNumber* isDef;       // 是否默认地址
@property (nonatomic,strong) NSNumber* province;    // 省份id
@property (nonatomic,strong) NSNumber* sendid;      // 送货时间id TODO://获取更明确的信息
@property (nonatomic,strong) NSNumber* tel;         // 收货电话
@property (nonatomic,strong) NSString* truename;    // 收货人姓名
@property (nonatomic,strong) NSNumber* uaid;        // 地址id
@property (nonatomic,strong) NSNumber* username;    // 用户id（用户手机）同user里面的username
@property (nonatomic,strong) NSNumber* zipcode;     // 邮政编码
@end
