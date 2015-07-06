//
//  ZTProductItem.m
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTProductItem.h"
@interface ZTProductItem(){
    UIView *_infoArea;
}
@end

@implementation ZTProductItem

-(instancetype)init{
    if (self = [super init]) {
        [self initViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - build views
-(void)initViews{
    _pic = [ZTImageLoader new];
    
    _infoArea = [UIView new];
    
    _title = [UILabel new];
    _title.lineBreakMode = NSLineBreakByTruncatingTail;
    _title.textColor = [UIColor colorWithHex:0x313131];
    _title.font = [UIFont systemFontOfSize:14.0];
    
    _priceTag = [UILabel new];
    _priceTag.text = @"价格：";
    
    _price = [UILabel new];
    
    for (UILabel *label in @[_priceTag,_price]) {
        label.textColor = [UIColor colorWithHex:0x5f5f5f];
        label.font = [UIFont systemFontOfSize:12.0];
    }
    
    [_infoArea addSubViews:@[_title,_priceTag,_price]];
    [self addSubViews:@[_pic,_infoArea]];
    
    // debug
    _pic.backgroundColor = [UIColor redColor];
    
    _title.text = @"就佛啊基恩姐家及安防戳阿胶发颤暗沉吉安产额房产撤家居服戳金额非啊案犯饿哦产妇戳甲基按哦饭啊经济法解决佛禅阿额发酵烦恶艾梵烦啊按飞车几级方茶几饿饭差额减肥产妇";
    _price.text = @"￥30.0";
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, [UIColor colorWithHex:COL_LINEBREAK].CGColor);
    CGContextSetLineWidth(cotx, 1.0);
    
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(cotx);
}

#pragma mark - layout
-(void)layoutSubviews{
    [[[[_pic setRectWidth:66.0] setRectHeight:66.0] setRectMarginLeft:10.0] setRectCenterVertical];
    [[[_infoArea setRectOnRightSideOfView:_pic] addRectX:10.0] widthToEndWithPadding:10.0];
    [[_title fitSize] widthToEndWithPadding:0.0];
    [[_priceTag fitSize] setRectBelowOfView:_title];
    [[[_price fitSize] setRectBelowOfView:_title] setRectOnRightSideOfView:_priceTag];
    [[_infoArea wrapContents] setRectCenterVertical];
}
@end
