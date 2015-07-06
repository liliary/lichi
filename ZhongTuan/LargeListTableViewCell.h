//
//  LargeListTableViewCell.h
//  ZhongTuan
//
//  Created by anddward on 15/5/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
@interface LargeListTableViewCell : UITableViewCell
@property (nonatomic,strong) ZTImageLoader *toppic;      //图片
@property (nonatomic,strong) UILabel *productInfo;   //产品信息
@property (nonatomic,strong) UILabel *promotionPrice;     //促销特价
@property (nonatomic,strong) UILabel *oneShoot;     //一口价
@property (nonatomic,strong) UILabel *count;        //折扣
@property (nonatomic,strong) UILabel *tagg;    //特卖tag
@property (nonatomic,strong) UILabel *sale;         //销量
@property (strong,nonatomic) UIColor* borderColor;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@end
