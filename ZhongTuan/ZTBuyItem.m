//
//  ZTBuyItem.m
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTBuyItem.h"
@implementation ZTBuyItem
-(instancetype)init{
    if (self = [super init]) {
        [self initViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - build views
-(void)initViews{
    _totalTag = [UILabel new];
    _totalTag.text = @"共";
    
    _total = [UILabel new];
    
    _totalUnit = [UILabel new];
    _totalUnit.text = @"件,";
    
    _totalPrice = [UILabel new];
    
    _orderBtn = [UIButton new];
    [_orderBtn setImage:[UIImage imageNamed:@"sale_buyBtn_bg"] forState:UIControlStateNormal];
    [_orderBtn addTarget:self action:@selector(didTapOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubViews:@[_totalTag,_total,_totalUnit,_totalPrice,_orderBtn]];
}

#pragma mark - layout views
-(void)layoutSubviews{
    [[[_totalTag fitSize] setRectMarginLeft:10.0] setRectCenterVertical];
    [[[_total fitSize] setRectOnRightSideOfView:_totalTag] setRectCenterVertical];
    [[[_totalUnit fitSize] setRectOnRightSideOfView:_total] setRectCenterVertical];
    [[[[_totalPrice fitSize] setRectOnRightSideOfView:_totalUnit] addRectX:10.0] setRectCenterVertical];
    [[[_orderBtn fitSize] setRectMarginRight:15.0] setRectCenterVertical];
}

#pragma mark - onClick Events
-(void)didTapOrder:(UIButton*)btn{
    _didTapOrder();
}
@end
