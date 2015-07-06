//
//  PaySelectedCell.m
//  ZhongTuan
//
//  Created by anddward on 15/2/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "PaySelectedCell.h"

@interface PaySelectedCell(){
}
@end

@implementation PaySelectedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 50.0);
        [self buildViews];
    }
    return self;
}

-(void)layoutSubviews{
    [[[_icon fitSize] setRectMarginLeft:10.0] setRectMarginTop:15.0];
    [[[[_payToolName fitSize] setRectOnRightSideOfView:_icon] addRectX:26.0] setRectMarginTop:15.0];
    [[[[[_payToolDescription fitSize] setRectOnRightSideOfView:_icon] addRectX:26.0] setRectBelowOfView:_payToolName] addRectY:7.5];
    [[[_checkBox fitSize] setRectMarginRight:10.0] setRectCenterVertical];
}

#pragma mark - build views

-(void)buildViews{
    _icon = [UIImageView new];
    
    _payToolName = [UILabel new];
    _payToolName.font = [UIFont systemFontOfSize:12.0];
    _payToolName.textColor = [UIColor colorWithHex:0x323232];
    
    _payToolDescription = [UILabel new];
    _payToolDescription.font = [UIFont systemFontOfSize:11.0];
    _payToolDescription.textColor = [UIColor colorWithHex:0x9b9b9b];
    
    _checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBox setImage:[UIImage imageNamed:@"check_no"] forState:UIControlStateNormal];
    [_checkBox setImage:[UIImage imageNamed:@"check_yes"] forState:UIControlStateSelected];
    
    
    [self addSubViews:@[_icon,_payToolName,_payToolDescription,_checkBox]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, [UIColor colorWithHex:COL_LINEBREAK].CGColor);
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale);
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextStrokePath(cotx);
    [super drawRect:rect];
}

@end
