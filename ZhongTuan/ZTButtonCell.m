//
//  NearButtonCell.m
//  ZhongTuan
//
//  Created by anddward on 14-11-13.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTButtonCell.h"

@interface ZTButtonCell(){
    UIImageView *_iconView;
    UILabel *_titleView;
}
@end

@implementation ZTButtonCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews];
        [self layoutViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)buildViews{
  
    if ([self.taggg isEqualToString:@"net"]) {
        _pic=[[ZTImageLoader alloc]initWithFrame:CGRectMake(0, 0, 36.0, 36.0)];
        _pic.backgroundColor=[UIColor whiteColor];
        _titleView = [[UILabel alloc] init];
        _titleView.font = [UIFont systemFontOfSize:11.0];
        _titleView.textColor = [UIColor colorWithHexTransparent:0xff333333];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pic];
        [self addSubview:_titleView];
    }
    if ([self.taggg isEqualToString:@"cxad"]) {
        _pic=[[ZTImageLoader alloc]initWithFrame:CGRectMake(15, 0, 44.0, 44.0)];
        _pic.backgroundColor=[UIColor whiteColor];
        _titleView = [[UILabel alloc] init];
        _titleView.font = [UIFont systemFontOfSize:11.0];
        _titleView.textColor = [UIColor colorWithHexTransparent:0xff333333];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pic];
        [self addSubview:_titleView];
    }
    
    else{
    
     _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36.0, 36.0)];
    _titleView = [[UILabel alloc] init];
    _titleView.font = [UIFont systemFontOfSize:11.0];
    _titleView.textColor = [UIColor colorWithHexTransparent:0xff333333];
    _titleView.textAlignment = NSTextAlignmentCenter;
[self addSubview:_iconView];
        [self addSubview:_titleView];}
}

-(void)layoutViews{
    if ([self.taggg isEqualToString:@"net"]) {
        [[_pic setRectCenterHorizentail] setRectMarginTop:7.5];
        [[[_titleView setRectBelowOfView:_pic] setRectCenterHorizentail] addRectY:7.5];
    }
    if ([self.taggg isEqualToString:@"cxad"]) {
        [[_pic setRectCenterHorizentail] setRectMarginTop:7.5];
        [[[_titleView setRectBelowOfView:_pic] setRectCenterHorizentail] addRectY:7.5];
    }
    else{
    [[_iconView setRectCenterHorizentail] setRectMarginTop:7.5];

        [[[_titleView setRectBelowOfView:_iconView] setRectCenterHorizentail] addRectY:7.5];}
}

-(void)setImage:(UIImage*)icon{
    [_iconView setImage:icon];
}
-(void)passvule:(NSString *)str{
self.taggg=str;
[self buildViews];
}
-(void)setTitle:(NSString*)title{
    _titleView.text = title;
    [_titleView sizeToFit];
    [self layoutViews];
}

@end
