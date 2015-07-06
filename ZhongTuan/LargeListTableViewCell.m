//
//  LargeListTableViewCell.m
//  ZhongTuan
//
//  Created by anddward on 15/5/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "LargeListTableViewCell.h"
@interface LargeListTableViewCell(){
UILabel*dolla;

}
@end
@implementation LargeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 400);
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        [self buildViews];
        [self setSelectedView];
    }
    return self;
}
-(void)buildViews{
self.toppic=[ZTImageLoader new];
self.toppic.backgroundColor=[UIColor colorWithHex:0xE4E4A1];
self.productInfo=[[UILabel alloc]init];
self.productInfo.lineBreakMode=NSLineBreakByCharWrapping;
self.productInfo.numberOfLines=0;
self.productInfo.font=[UIFont systemFontOfSize:14.0];
self.productInfo.textColor=[UIColor colorWithHex:0x333333];
dolla=[[UILabel alloc]init];
[dolla setText:@"$"];
[dolla setFont:[UIFont systemFontOfSize:9.0]];
[dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];

self.promotionPrice=[[UILabel alloc]init];

self.oneShoot=[[UILabel alloc]init];
self.oneShoot.font = [UIFont systemFontOfSize:12.0];
self.oneShoot.textColor = [UIColor colorWithHex:0x9b9b9b];

self.count=[[UILabel alloc]init];
self.count.font=[UIFont systemFontOfSize:12.0];
self.sale=[[UILabel alloc]init];
self.sale.font=[UIFont systemFontOfSize:12.0];
self.tagg=[[UILabel alloc]init];
self.tagg.font=[UIFont systemFontOfSize:12.0];
   
    
    // debug
    self.count.text = @"10.0折";
    self.oneShoot.attributedText = [@"256.0" addStriket];
   self.promotionPrice.text = @"256";
    self.productInfo.text = @"loading..........loading..........loading..........load..............load...........";
self.sale.text=@"100";
self.tagg.text=@"特卖";


[self addSubViews:@[self.toppic,self.productInfo,dolla,self.oneShoot,self.promotionPrice,self.count,self.sale,self.tagg]];
}

-(void)setSelectedView{
UIView*bgView=[[UIView alloc]initWithFrame:self.bounds];
bgView.backgroundColor=[UIColor colorWithHex:0xebebeb];
self.selectedBackgroundView=bgView;
}
-(void)layoutSubviews{
[[self.toppic setScreenWidth]setRectHeight:320];

[[[[[self.productInfo fitSize]widthToEndWithPadding:9] setRectMarginLeft:10.0]setRectBelowOfView:self.toppic]addRectY:7];
[[[[self.promotionPrice fitSize]setRectMarginLeft:10.0]setRectBelowOfView:self.productInfo]addRectY:5];
    [[[[[self.oneShoot fitSize]setRectOnRightSideOfView:self.promotionPrice]addRectX:5]setRectBelowOfView:self.productInfo]addRectY:8];
    [[[[[self.count fitSize]setRectOnRightSideOfView:self.oneShoot]addRectX:5]setRectBelowOfView:self.productInfo]addRectY:8];
    
    [[[[self.sale fitSize]setRectMarginLeft:10.0]setRectBelowOfView:self.promotionPrice]addRectY:5];
    [[[self.tagg fitSize]setRectMarginRight:10]setRectMarginBottom:7.0];
    

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





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
