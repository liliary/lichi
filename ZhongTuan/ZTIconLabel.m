//
//  ZTIconLabel.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTIconLabel.h"
#import "ZTFundationAddiction.h"

@implementation ZTIconLabel

-(id)initWithIcon:(UIImage*)icon title:(NSString*)title{
    if (self = [self init]) {
        _iconView.image = icon;
        _titleView.text = title;
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        _iconView = [UIImageView new];
        _titleView = [[UILabel alloc] init];
        _titleView.font = [UIFont systemFontOfSize:11.0];
        _titleView.textColor = [UIColor colorWithHex:0x9b9b9b];
        [self addSubViews:@[_iconView,_titleView]];
    }
    return self;
}

-(void)layoutSubviews{

    [[_iconView setRectMarginLeft:_iconGap]
        setRectCenterVertical];
    
    [[[_titleView setRectOnRightSideOfView:_iconView]
        addRectX:_contentGap]
        setRectCenterVertical];
}

-(id)fitSize{
    [_iconView fitSize];
    [_titleView fitSize];
    CGFloat width = _iconGap+CGRectGetWidth(_iconView.bounds)+_contentGap+CGRectGetWidth(_titleView.bounds);
    CGFloat height = CGRectGetHeight(_iconView.bounds) > CGRectGetHeight(_titleView.bounds) ?
                        CGRectGetHeight(_iconView.bounds) : CGRectGetHeight(_titleView.bounds);
    self.frame = CGRectMake(0, 0, width, height);
    return self;
}


@end
