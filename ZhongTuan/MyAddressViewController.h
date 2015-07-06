//
//  MyAddressViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleOrderViewController.h"
@interface MyAddressViewController : UIViewController
@property(nonatomic,strong) SaleOrderViewController*delegate;
@property(nonatomic,copy)NSString*ttag;
@end
