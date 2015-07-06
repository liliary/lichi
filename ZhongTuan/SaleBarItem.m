//
//  SaleBarItem.m
//  ZhongTuan
//
//  Created by anddward on 15/3/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "SaleBarItem.h"

@implementation SaleBarItem

#pragma mark - public methods

+(id)initWithIcon:(UIImage *)icon title:(NSString *)title indicator:(BOOL)showIdicator{
    SaleBarItem *item = [[SaleBarItem alloc] init];
    item.icon = icon;
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:icon forState:UIControlStateNormal];
    item.showIndicator = showIdicator;
    return item;
}

#pragma mark - overwrite

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cotx, _borderWidth);
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    
    if (_topBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_showIndicator) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightMargin-5.0, CGRectGetMidY(rect)-5.0);
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightMargin, CGRectGetMidY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightMargin-5.0, CGRectGetMidY(rect)+5.0);
        CGContextStrokePath(cotx);
    }
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect isz = [super imageRectForContentRect:contentRect];
    isz.origin.x = _iconLeftGap;
    return isz;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect tsz = [super titleRectForContentRect:contentRect];
    CGRect isz = [self imageRectForContentRect:contentRect];
    tsz.origin.x = CGRectGetMaxX(isz)+_icon2titleGap;
    return tsz;
}

@end
