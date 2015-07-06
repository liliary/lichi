//
//  MeCell.m
//  ZhongTuan
//
//  Created by anddward on 14-11-22.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "MeCell.h"

@interface MeCell(){
}
@end

@implementation MeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 45.0);
        [self buildViews];
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

#pragma mark - buildViews

-(void)buildViews{
    _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubViews:@[_title,_icon]];
}

-(void)layoutSubviews{
    /// size    
    [[[_icon fitSize] setRectCenterVertical] setRectX:15.0];
    [[[[_title fitSize] setRectCenterVertical] setRectOnRightSideOfView:_icon] addRectX:15.0];
    [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
}

@end
