//
//  ZTContentLabel.m
//  ZhongTuan
//
//  Created by anddward on 15/2/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTContentLabel.h"

@implementation ZTContentLabel

-(id)initWithTitle:(NSString*)title{
    if (self = [self init]) {
        self.text = title;
        _borderWidth = 1.0;
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        self.font = [UIFont systemFontOfSize:12.0];
        self.textColor = [UIColor colorWithHex:0x969696];
        _labelEdgeInset = UIEdgeInsetsMake(11.0, 10.0, 11.0, 10.0);
    }
    return self;
}

-(void)drawTextInRect:(CGRect)rect{
    CGRect r = rect;
    r.size.height += 60;
    return [super drawTextInRect:UIEdgeInsetsInsetRect(r,_labelEdgeInset)];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    
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
}

@end
