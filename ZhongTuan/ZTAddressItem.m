//
//  ZTAddressItem.m
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTAddressItem.h"
@interface ZTAddressItem(){
    UIView *_addContents;
}
@end

@implementation ZTAddressItem
-(instancetype)init{
    if (self = [super init]) {
        [self initViews];
    }
    return self;
}

#pragma mark - build views 

-(void)initViews{
    _addContents = [UIView new];
    _nameLabel = [UILabel new];
    _phoneLabel = [UILabel new];
    _addTag = [UILabel new];
    //_addTag.text = @"地址:";
    _addLabel = [UILabel new];
    
    NSArray *labels = @[_nameLabel,_phoneLabel,_addLabel,_addTag];
    for (UILabel* label in  labels) {
        label.textColor = [UIColor colorWithHex:0x919191];
        label.font = [UIFont systemFontOfSize:14.0];
    }
    
    // TODO:背景图片换成邮件彩圈
    [_addContents addSubViews:@[_nameLabel,_phoneLabel,_addTag,_addLabel]];
    [self addSubview:_addContents];


   }




-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextStrokePath(cotx);
    
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(cotx);
    
    CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)-5.0);
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding, CGRectGetMidY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)+5.0);
    CGContextStrokePath(cotx);
}

#pragma mark - layout views
-(void)layoutSubviews{
    [_nameLabel sizeToFit];
    [[[_phoneLabel fitSize] setRectOnRightSideOfView:_nameLabel] addRectX:_contentGap];
    [[[_addTag fitSize] setRectBelowOfView:_nameLabel] addRectY:_lineGap];
    [[[[[_addLabel fitSize] setRectBelowOfView:_nameLabel] setRectOnRightSideOfView:_addTag]
        addRectY:_lineGap] addRectX:_contentGap];
    [[[_addContents wrapContents] setRectCenterVertical] setRectMarginLeft:_leftPadding];
}
@end
