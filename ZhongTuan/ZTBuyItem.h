//
//  ZTBuyItem.h
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTBuyItem : UIView
@property (nonatomic,strong) UILabel *totalTag;
@property (nonatomic,strong) UILabel *total;
@property (nonatomic,strong) UILabel *totalUnit;
@property (nonatomic,strong) UILabel *totalPrice;
@property (nonatomic,strong) UIButton *orderBtn;
// call back
@property (nonatomic,copy)void (^didTapOrder)();
@end
