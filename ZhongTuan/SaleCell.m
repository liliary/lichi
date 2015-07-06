//
//  SaleCell.m
//  ZhongTuan
//
//  Created by anddward on 14-11-19.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "SaleCell.h"
#import "ZTFundationAddiction.h"
#import "ZTImageLoader.h"

@interface SaleCell()

@end

@implementation SaleCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews];
    }
    return self;
}

-(void)buildViews{
    _pic =  [ZTImageLoader new];
    _pic.backgroundColor = [UIColor whiteColor];
    
    _lace = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_lace"]];
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont systemFontOfSize:12.0];
    _title.textColor = [UIColor colorWithHex:0x333333];
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.numberOfLines = 0;
    
    _price = [[UILabel alloc] init];
    _price.font = [UIFont systemFontOfSize:16.0];
    _price.textColor = [UIColor redColor];
    
    _del_price = [[UILabel alloc] init];
    _del_price.font = [UIFont systemFontOfSize:12.0];
    _del_price.textColor = [UIColor colorWithHex:0x9b9b9b];
    
    [self addSubViews:@[_pic,_lace,_title,_price,_del_price]];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)layoutSubviews{
    [[[[_pic setRectWidth:143.5] setRectHeight:150.0] setRectX:2.5] setRectY:2.5];
    [[[_lace setRectBelowOfView:_pic] setRectX:2.5] addRectY:-2.5];
    [[[[[_title setRectWidth:138.5]
        setRectHeight:30.0]
        setRectBelowOfView:_lace]
        setRectCenterHorizentail]
        addRectY:5.0];
    [[[[_price fitSize] setRectBelowOfView:_title] addRectY:10.0] setRectX:5.0];
    [[[[[_del_price fitSize] setRectBelowOfView:_title] addRectY:13.0] setRectOnRightSideOfView:_price] addRectX:5.0];    
}
@end
