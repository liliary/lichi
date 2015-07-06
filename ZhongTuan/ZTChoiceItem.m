//
//  ZTChoiceItem.m
//  ZhongTuan
//
//  Created by anddward on 15/3/2.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTChoiceItem.h"

@implementation ZTChoiceItem
#pragma mark - buildViews
-(id)initWithTitle:(NSString*)title content:(NSString*)content tag:(NSInteger)tag{
    if (self = [self init]) {
        _choiseTitleLable.text = title;
        [_choiseContentBtn setTitle:content forState:UIControlStateNormal];
        _choiseContentBtn.tag = tag;
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        _choiseTitleLable = [UILabel new];
        _choiseContentBtn = [UIButton new];
        _choiseContentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews:@[_choiseTitleLable,_choiseContentBtn]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    // draw indicator
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-5.0-_indicatorRightMargin, CGRectGetMidY(rect)-5.0);
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightMargin, CGRectGetMidY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-5.0-_indicatorRightMargin, CGRectGetMidY(rect)+5.0);
    CGContextStrokePath(cotx);
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
}

#pragma mark - layout views

-(void)layoutSubviews{
    [[_choiseTitleLable fitSize] setRectCenterVertical];
    [[[[_choiseContentBtn fitSize] setRectOnRightSideOfView:_choiseTitleLable] widthToEndWithPadding:0.0] setRectCenterVertical];
}

@end
