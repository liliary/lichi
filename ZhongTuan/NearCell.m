//
//  NearCell.m
//  ZhongTuan
//
//  Created by anddward on 14-11-14.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
// TODO: 当图片请求失败时,应该清空之前的图片

#import "NearCell.h"
#import "ZTImageLoader.h"

@interface NearCell(){
    UILabel *_dolla;            //价格符号
}
@end

@implementation NearCell

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


#pragma mark - construct

-(void)buildViews{
    _pic = [ZTImageLoader new];
    
    _corner = [[UIImageView alloc] init];
    
    _title = [[UILabel alloc] init];
    [_title setFont:[UIFont systemFontOfSize:15.0]];
    [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    _distance = [[UILabel alloc] init];
    [_distance setFont:[UIFont systemFontOfSize:9.0]];
    [_distance setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    _summary = [[UIWebView alloc] init];
    
    _dolla = [[UILabel alloc] init];
    [_dolla setText:@"￥"];
    [_dolla  setFont:[UIFont systemFontOfSize:9.0]];
    [_dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _price = [[UILabel alloc] init];
    [_price setFont:[UIFont systemFontOfSize:16.0]];
    [_price setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _promotion = [[UILabel alloc] init];
    _promotion.layer.cornerRadius = 2.0;
    [_promotion setFont:[UIFont systemFontOfSize:9.0]];
    [_promotion setTextColor:[UIColor whiteColor]];
    [_promotion setTextAlignment:NSTextAlignmentCenter];
    
    _sale = [[UILabel alloc] init];
    [_sale setFont:[UIFont systemFontOfSize:9.0]];
    [_sale setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    [self addSubViews:@[_pic,_corner,_title,_distance,_dolla,_price,_promotion,_sale]];
}

-(void)setSelectedView{
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
        self.selectedBackgroundView = bgView;
}

#pragma mark - layout

-(void)layoutSubviews{
    [[[[_pic setRectWidth:116.0] setRectHeight:73.5] setRectMarginTop:7.5] setRectMarginLeft:7.5];
    [[[_corner fitSize] setRectX:7.5] setRectY:7.5];
    [[[[_title fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:10.0];
    [[[[_dolla fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginBottom:10.0];
    [[[_price fitSize] setRectOnRightSideOfView:_dolla] setRectMarginBottom:8.0];
    [[[[[_promotion fitSize] setRectOnRightSideOfView:_price] addRectX:4.0] setRectMarginBottom:12.0] setBackgroundColor:[UIColor colorWithHex:0xff4978]];
    [[[_distance fitSize] setRectMarginTop:14.0] setRectMarginRight:7.5];
    [[[_sale fitSize] setRectMarginBottom:10.0] setRectMarginRight:7.5];
    [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
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
}
@end
