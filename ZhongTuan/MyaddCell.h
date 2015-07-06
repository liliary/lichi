//
//  MyaddCell.h
//  ZhongTuan
//
//  Created by anddward on 15/2/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSessionTitle.h"
#import "ZTSessionView.h"
@interface MyaddCell : UITableViewCell
@property (strong,nonatomic) ZTSessionTitle *expressDate;      // 送货日期
@property (strong,nonatomic) UILabel *consignee;               // 收货人
@property (strong,nonatomic) UILabel *consigPhone;             // 收货手机
@property (strong,nonatomic) UILabel *province;                // 省份
@property (strong,nonatomic) UILabel *city;                    // 城市
@property (strong,nonatomic) UILabel *area;                    // 区域
@property (strong,nonatomic) UILabel *address;                 // 地址
 @property(strong,nonatomic) ZTSessionView *_infoGrup;           // 信息框
@end
