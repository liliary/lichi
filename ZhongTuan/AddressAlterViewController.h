//
//  AddressAlterViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/2/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
@interface AddressAlterViewController : UIViewController
@property (nonatomic,assign) NSInteger addressId;
@property(nonatomic,strong)Address*addre;
@property(nonatomic,strong)NSNumber*shen;
@property(nonatomic,strong)NSNumber*shi;
@property(nonatomic,strong)NSString*qu;
@end
