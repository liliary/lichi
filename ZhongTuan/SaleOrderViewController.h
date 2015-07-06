//
//  SaleOrderViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTTitleLabel.h"
#import "ZTSessionTitle.h"
#import "ZTProductItem.h"
#import "ZTAddressItem.h"
#import "ZTBuyItem.h"
#import "ZTNumberItem.h"
#import "PurchaseViewController.h"
#import "Address.h"

@interface SaleOrderViewController : UIViewController
// 导航栏
@property (nonatomic,strong) ZTTitleLabel *titleView;
// 收货信息
@property (nonatomic,strong) ZTProductItem  *productItem;
@property (nonatomic,strong) ZTNumberItem   *numberItem;
@property (nonatomic,strong) ZTAddressItem  *addItem;
@property (nonatomic,strong) ZTBuyItem      *buyItem;
// data
@property (nonatomic,strong) NSNumber *productId;
@property(nonatomic,strong)Address*reviseaddress;
 @property(nonatomic,copy)NSString*ordernumber;
 @property(nonatomic,strong)NSNumber*cimaid;//尺码id
 @property(nonatomic,strong)NSNumber*buynumbers;
@end
