//
//  ZTSessionTitle.m
//  ZhongTuan
//
//  Created by anddward on 15/2/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTSessionTitle.h"

@implementation ZTSessionTitle

-(id)initWithTitle:(NSString*)title{
    if (self = [self init]) {
        self.text = title;
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:14.0];
        self.textColor = [UIColor colorWithHex:0x323232];
        _titleInsets = UIEdgeInsetsMake(11.0, 10.0, 11.0, 10.0);
        _lineColor = [UIColor colorWithHex:COL_LINEBREAK];
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect,_titleInsets)];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_borderWidth);
    CGContextSetStrokeColorWithColor(cotx, _lineColor.CGColor);
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    if (_topBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    [super drawRect:rect];
}

@end
