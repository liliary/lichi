//
//  ZTNumberItem.m
//  ZhongTuan
//
//  Created by anddward on 15/3/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTNumberItem.h"

@implementation ZTNumberItem
-(instancetype)init{
    if (self = [super init]) {
        [self initViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - build views
-(void)initViews{
    _title = [UILabel new];
    _title.text = @"数量";
    _title.font = [UIFont systemFontOfSize:16.0];
    
    _addBtn = [UIButton new];
    [_addBtn setImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(didTapAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _subBtn = [UIButton new];
    [_subBtn setImage:[UIImage imageNamed:@"btn_sub"] forState:UIControlStateNormal];
    [_subBtn addTarget:self action:@selector(didTapSubBtn:) forControlEvents:UIControlEventTouchUpInside];

    _countLabel = [UITextField new];
    _countLabel.background = [UIImage imageNamed:@"bg_price"];
    _countLabel.enabled = NO;
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    _kcTag = [UILabel new];
    _kcTag.text = @"库存：";
    
    _kc = [UILabel new];
    // debug
    _kc.text = @"50";
    
    _kcUnitTag = [UILabel new];
    _kcUnitTag.text = @"件";
    
    for (UILabel *label in @[_kcTag,_kc,_kcUnitTag]) {
        label.textColor = [UIColor colorWithHex:0x313131];
        label.font = [UIFont systemFontOfSize:10.0];
    }
    
    [self addSubViews:@[_title,_addBtn,_countLabel,_subBtn,_kcTag,_kc,_kcUnitTag]];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cotx, 1.0);
    CGContextSetStrokeColorWithColor(cotx, [UIColor colorWithHex:COL_LINEBREAK].CGColor);
    
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(cotx);
    
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextStrokePath(cotx);
}

#pragma mark - layout views

-(void)layoutSubviews{
    [[[_title fitSize] setRectMarginLeft:10.0] setRectMarginTop:10.0];
    [[[[_subBtn fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_title] addRectY:10.0];
    [[[[[[_countLabel setRectWidth:45.0] setRectHeight:23.0] setRectOnRightSideOfView:_subBtn] addRectX:5.0] setRectBelowOfView:_title] addRectY:10.0];
    [[[[[_addBtn fitSize] setRectOnRightSideOfView:_countLabel] addRectX:5.0] setRectBelowOfView:_title] addRectY:10.0];
    [[[[[_kcTag fitSize] setRectOnRightSideOfView:_addBtn] addRectX:10.0] setRectBelowOfView:_addBtn] addRectY:-_kcTag.bounds.size.height];
    [[[_kc fitSize] setRectOnRightSideOfView:_kcTag] setRectY:_kcTag.frame.origin.y];
    [[[_kcUnitTag fitSize] setRectOnRightSideOfView:_kc] setRectY:_kcTag.frame.origin.y];
}

#pragma mark - onClick Events
-(void)didTapAddBtn:(UIButton*)btn{
    _didTapAddBtn();
}

-(void)didTapSubBtn:(UIButton*)btn{
    _didTapSubBtn();
}


@end
