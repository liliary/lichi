//
//  NoPayCell.m
//  ZhongTuan
//
//  Created by anddward on 15/4/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "NoPayCell.h"
#import "ZTImageLoader.h"

@interface NoPayCell(){
    UILabel *_dolla;            //价格符号
    UILabel*_shuliang ;            //数量
}
@end
@implementation NoPayCell



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
    if ([self.tagg isEqualToString:@"collect"]) {
    NSLog(@"gejiushibuiyang");
        _pic = [ZTImageLoader new];
        _title = [[UILabel alloc] init];
        [_title setFont:[UIFont systemFontOfSize:15.0]];
        [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    }else{
        NSLog(@"gggggejiushibuiyang");

    _pic = [ZTImageLoader new];
    _title = [[UILabel alloc] init];
    [_title setFont:[UIFont systemFontOfSize:15.0]];
    [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    _totolprice= [[UILabel alloc] init];
    [_totolprice setFont:[UIFont systemFontOfSize:12.0]];
    [_totolprice setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _dolla = [[UILabel alloc] init];
    [_dolla setText:@"￥"];
    [_dolla  setFont:[UIFont systemFontOfSize:13.0]];
    [_dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _shuliang = [[UILabel alloc] init];
    [_shuliang setText:@"数量: "];
    [_shuliang  setFont:[UIFont systemFontOfSize:10.0]];
    [_shuliang setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    _quantity = [[UILabel alloc] init];
    [_quantity setFont:[UIFont systemFontOfSize:9.6]];
    [_quantity setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
//       UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(135, 65, 50, 25)];
//       [bt setTitle:@"付款" forState: UIControlStateNormal];
//    bt.layer.cornerRadius=5.0;
//       bt.backgroundColor=[UIColor redColor];
//        bt.titleLabel.font = [UIFont systemFontOfSize:16.0];
//     [bt addTarget:self action:@selector(fukuan:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubViews:@[_pic,_title, _dolla, _totolprice,_shuliang,_quantity]];}
    
}

-(void)setSelectedView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.selectedBackgroundView = bgView;
}

#pragma mark - layout

-(void)layoutSubviews{
    [[[[_pic setRectWidth:75.0] setRectHeight:73.5] setRectMarginTop:7.5] setRectMarginLeft:7.5];
    [[[[_title fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:15.0];
    [[[[_dolla fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:40.0];
    [[[_totolprice fitSize] setRectOnRightSideOfView:_dolla]setRectMarginTop:40.0];
    //[[[[[_promotion fitSize] setRectOnRightSideOfView:_price] addRectX:4.0] setRectMarginBottom:12.0] setBackgroundColor:[UIColor colorWithHex:0xff4978]];
    [[[ _shuliang fitSize] setRectMarginTop:40.0] setRectMarginRight:80.0];
    [[[_quantity fitSize] setRectMarginTop:40.0] setRectOnRightSideOfView:_shuliang];
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
