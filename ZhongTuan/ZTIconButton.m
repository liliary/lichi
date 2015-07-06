//
//  complexButton.m
//  ZhongTuan
//
//  Created by anddward on 14-11-22.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTIconButton.h"
@interface ZTIconButton(){
    id delegate;
    SEL triggerMethod;
}
@end

@implementation ZTIconButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapButton:)];
        [self addGestureRecognizer:gesture];
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - public methods

-(void)setTarget:(id)target trigger:(SEL)selector{
    delegate = target;
    triggerMethod = selector;
}

#pragma mark - build views

-(void)buildViews{
    _icon = [UIImageView new];
    _icon.userInteractionEnabled=YES;
    /// 顶部信息
    _labelTop = [UILabel new];
    _labelTop.font = [UIFont systemFontOfSize:16.0];
    _labelTop.textColor = [UIColor colorWithHex:0x333333];
    
    /// 底部信息
    _labelBottom = [UILabel new];
    _labelBottom.font = [UIFont systemFontOfSize:16.0];
    _labelBottom.textColor = [UIColor colorWithHex:0x9b9b9b];
        
    [self addSubViews:@[_icon,_labelTop,_labelBottom]];
}

-(void)layoutSubviews{
    
        [[[_icon fitSize] setRectCenterVertical] setRectMarginLeft:_iconLeftGap];
    
    [[[[[_labelTop fitSize]
      setRectOnTopOfView:_icon]
      setRectY:CGRectGetMidY(self.bounds)-CGRectGetHeight(_labelTop.bounds)]
      setRectOnRightSideOfView:_icon]
      addRectX:_iconContentGap];
    
    [[[_labelBottom fitSize]
        setRectY:CGRectGetMidY(self.bounds)]
        addRectY:_bottomLabelMoveDown];
    
    switch (_alignMode) {
        case ZTIconButtonAlignModeLeft:
            [[_labelBottom setRectOnLeftSideOfView:_labelTop] addRectX:CGRectGetWidth(_labelBottom.bounds)];
            break;
        default:
            [_labelBottom setCenterOfViewHorizentail:_labelTop];
            break;
    }
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

#pragma mark button click event

-(void)didTapButton:(UITapGestureRecognizer*)recognizer{
    if ([delegate respondsToSelector:triggerMethod]) {
        [delegate performSelector:triggerMethod withObject:self afterDelay:0];
    }
}


@end
