//
//  ZTItemButton.m
//  ZhongTuan
//
//  Created by anddward on 15/2/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//


#import "ZTItemButton.h"

@implementation ZTItemButton

-(id)initWithTitle:(NSString *)buttonTitle{
    if (self = [self init]) {
        [self setTitle:buttonTitle forState:UIControlStateNormal];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, [UIColor colorWithHex:COL_LINEBREAK].CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    
    // draw > on the right Side
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)-5.0);
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding, CGRectGetMidY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)+5.0);
    CGContextStrokePath(cotx);
    
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
}


@end
