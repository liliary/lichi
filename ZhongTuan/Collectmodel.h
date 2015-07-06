//
//  Collectmodel.h
//  ZhongTuan
//
//  Created by anddward on 15/5/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface Collectmodel : Model
@property (strong,nonatomic) NSString* picurl;//图片网址
@property (strong,nonatomic) NSString* title ;//商品名称
@property (strong,nonatomic) NSString* dj ;//原价
@property(nonatomic,strong)NSNumber*lbid; // 收藏物品id
@end
