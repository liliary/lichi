//
//  ZTProductItem.h
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

@interface ZTProductItem : UIView
@property (nonatomic,strong) ZTImageLoader *pic;
@property (nonatomic,strong) UILabel *title;        // 标题
@property (nonatomic,strong) UILabel *priceTag;     // 产品价格tag
@property (nonatomic,strong) UILabel *price;        // 产品价格
@end
