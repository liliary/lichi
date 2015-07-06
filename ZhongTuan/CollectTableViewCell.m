//
//  CollectTableViewCell.m
//  ZhongTuan
//
//  Created by anddward on 15/5/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CollectTableViewCell.h"
@interface CollectTableViewCell(){


}
@end
@implementation CollectTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 91.0);
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        [self buildViews];
        [self setSelectedView];
    }
    return self;

}
-(void)buildViews{
    
    _pic = [ZTImageLoader new];
    _title = [[UILabel alloc] init];
    [_title setFont:[UIFont systemFontOfSize:15.0]];
    [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
   
    _totolprice= [[UILabel alloc] init];
    [_totolprice setFont:[UIFont systemFontOfSize:12.0]];
    [_totolprice setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];

    
    [self addSubViews:@[_pic,_title,_totolprice]];
    

}

-(void)setSelectedView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.selectedBackgroundView = bgView;
}

#pragma mark -layout views

-(void)layoutSubviews{
    [[[[_pic setRectWidth:75.0] setRectHeight:73.5] setRectMarginTop:7.5] setRectMarginLeft:7.5];
    [[[[_title fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:15.0];
    
    [[[[_totolprice fitSize] setRectOnRightSideOfView:_pic]addRectX:18] setRectMarginTop:60.0];
    [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)-5.0);
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding, CGRectGetMidY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)+5.0);
    CGContextStrokePath(cotx);
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





@end
