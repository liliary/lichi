//
//  SettingCell.m
//  ZhongTuan
//
//  Created by anddward on 15/2/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [[[_titleLabel fitSize] setRectMarginLeft:15.0] setRectCenterVertical];
    [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    
    if (_topBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect)+_borderMargin, CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_borderMargin, CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect)+_borderMargin, CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_borderMargin, CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    [super drawRect:rect];
}

@end
