//
//  cima.h
//  ZhongTuan
//
//  Created by anddward on 15/4/24.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface cima : Model
@property(nonatomic,copy)NSString*chima;  //   尺码
@property(nonatomic,strong)NSNumber*kcsl;   //库存数量
@property(nonatomic,strong)NSNumber*tmcid;   //尺码id
@property(nonatomic,strong)NSNumber*tmid;    // 特卖id
@end
