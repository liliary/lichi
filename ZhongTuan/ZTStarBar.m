//
//  ZTStarBar.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTStarBar.h"
@interface ZTStarBar(){
    CGFloat _starWidth;
    CGFloat _count;
    CGFloat _gap;
    
    UIView* _maskView;
}
@end

@implementation ZTStarBar

-(id)initWithFillStar:(UIImage*)fillStar
            emptyStar:(UIImage*)emptyStar
                 count:(NSInteger)count
                   gap:(CGFloat)gap{
    if (self = [super init]) {
        _gap = gap;
        _count = count;
        _starWidth = emptyStar.size.width;
        _score = 5.0;
        _lineColor = [UIColor colorWithHex:COL_LINEBREAK];
        
        _bottomBar = [[UIImageView alloc] initWithImage:[self drawRepeat:count img:emptyStar gap:gap]];
        _topBar = [[UIImageView alloc] initWithImage:[self drawRepeat:count img:fillStar gap:gap]];
        
        _maskView = [UIView new];
        _maskView.clipsToBounds = YES;
        
        _scoreLabel = [UILabel new];
        _scoreLabel.text = [NSString stringWithFormat:@"%1.1f",_score];
        
        [_maskView addSubview:_topBar];
        [self addSubViews:@[_bottomBar,_maskView,_scoreLabel]];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat topWidth = (floor(_score)*_gap)+((_starWidth*_count)*(_score/_count));
    [[_bottomBar setRectCenterVertical] setRectX:_leftGap];
    [_topBar setRectCenterVertical];
    [[[_maskView setRectCenterVertical] setRectWidth:topWidth] setRectX:_leftGap];
    _scoreLabel.text = [NSString stringWithFormat:@"%1.1f",_score];
    [[[_scoreLabel setRectCenterVertical] setRectOnRightSideOfView:_bottomBar] addRectX:_scoreGap];
}

-(id)fitSize{
    [_bottomBar fitSize];
    [_scoreLabel fitSize];
    _maskView.frame = _bottomBar.frame;
    CGFloat width = _leftGap+CGRectGetWidth(_bottomBar.bounds)+_scoreGap+CGRectGetWidth(_scoreLabel.bounds);
    CGFloat height = CGRectGetHeight(_bottomBar.bounds) > CGRectGetHeight(_scoreLabel.bounds) ?
                     CGRectGetHeight(_bottomBar.bounds): CGRectGetHeight(_scoreLabel.bounds);
    self.frame = CGRectMake(0, 0, width, height);
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _lineColor.CGColor);
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
}

#pragma mark - helpers

-(UIImage*)drawRepeat:(NSInteger)times img:(UIImage*)img gap:(CGFloat)gap{
    CGSize imgSize = img.size;
    CGFloat contextWidth = imgSize.width*times+gap*(times-1);
    CGFloat contextHeight = imgSize.height;
    CGFloat step = imgSize.width+gap;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextWidth,contextHeight), NO, 0);
    for (int i=0; i<times; i++) {
        [img drawAtPoint:CGPointMake(i*step, 0)];
    }
    UIImage* target = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return target;
}

@end
