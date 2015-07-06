//
//  SessionView.m
//  ZhongTuan
//
//  Created by anddward on 15/2/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTSessionView.h"

@implementation ZTSessionView

-(instancetype)init{
    if (self = [super init]) {
        _lineColor = [UIColor colorWithHex:COL_LINEBREAK];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cotx,_borderWidth*0.5*[UIScreen mainScreen].scale);
    CGContextSetStrokeColorWithColor(cotx, _lineColor.CGColor);
    
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
    [super drawRect:rect];
}

@end
