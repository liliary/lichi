//
//  Product.m
//  ZhongTuan
//
//  Created by anddward on 15/1/10.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "TeamBuyProduct.h"

@implementation TeamBuyProduct
-(BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[TeamBuyProduct class]]) {
        TeamBuyProduct *obj = (TeamBuyProduct*)object;
        return [obj.mid isEqual:_mid];
    }
    return NO;
}
@end
