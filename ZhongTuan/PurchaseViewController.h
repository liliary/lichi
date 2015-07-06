//
//  PayViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "HomeTabBarController.h"
#import <UIKit/UIKit.h>
#import "TeMaiProduct.h"
#import "orderInfo.h"
@interface PurchaseViewController : UIViewController

// data
@property (nonatomic,copy) NSString *ordno;
@property(nonatomic,strong)TeMaiProduct*payproduct;
@property(nonatomic,copy)NSNumber*paymoney;
@property(nonatomic,strong)NSString*payway;
@property(nonatomic,assign)NSString *tag;
@property(nonatomic,strong)orderInfo*info;
@property(nonatomic,strong)HomeTabBarController*controller;
@end
