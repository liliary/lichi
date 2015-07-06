//
//  ZTTiView.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTTiView.h"

@implementation ZTTiView

-(id)initWithTitle:(NSString*)title info:(NSString*)info{
    if (self = [self init]) {
        _titleLabel.text = title;
        _infoLabel.text = info;
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        _titleLabel =  [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor colorWithHex:0x333333];
        _infoLabel = [UILabel new];
        _infoLabel.font = [UIFont systemFontOfSize:11.0];
        _infoLabel.textColor = [UIColor colorWithHex:0x9b9b9b];
        [self addSubViews:@[_titleLabel,_infoLabel]];
        _lineColor = [UIColor colorWithHex:COL_LINEBREAK];
    }
    return self;
}

-(void)layoutSubviews{
    
    [[[_titleLabel setRectMarginLeft:_leftGap]
     setRectCenterVertical]
     addRectY:-(CGRectGetMidY(_titleLabel.bounds)+_titleLabelUp)];  // 位置中上
    
    [[[_infoLabel setRectMarginLeft:_leftGap]
     setRectCenterVertical]
     addRectY:(CGRectGetMidY(_infoLabel.bounds)+_infoLabelDown)];   // 位置中下
}

-(id)fitSize{
    [_titleLabel fitSize];
    [_infoLabel fitSize];
    CGFloat height = CGRectGetHeight(_titleLabel.bounds)+CGRectGetHeight(_infoLabel.bounds)
                        +_titleLabelUp+_infoLabelDown+_topLayout+_bottomLayout;
    self.frame = CGRectMake(0, 0, 0,height);
    self.backgroundColor = [UIColor whiteColor];
    return self;
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
