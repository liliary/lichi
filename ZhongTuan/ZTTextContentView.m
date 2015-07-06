//
//  ZTTextContentView.m
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTTextContentView.h"

@implementation ZTTextContentView

-(instancetype)init{
    if (self = [super init]) {
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_borderWidth);
    
    
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
    
    if (_leftBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_rightBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    
    [super drawRect:rect];
}

@end
