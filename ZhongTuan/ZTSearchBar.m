//
//  ZTSearchBar.m
//  ZhongTuan
//
//  Created by anddward on 15/1/30.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTSearchBar.h"

@implementation ZTSearchBar

-(instancetype)initWithBackgroundImage:(UIImage*)bg searchIcon:(UIImage*)icon{
    if (self = [super init]) {
        self.background = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(29.0, 0, 29.0, 0) resizingMode:UIImageResizingModeTile];
        self.leftView = [[UIImageView alloc] initWithImage:icon];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.placeholder = @"搜索";
        self.font = [UIFont systemFontOfSize:12.0];
    }
    return self;
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 7.0;
    return iconRect;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 7.0;
    return editingRect;
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 7.0;
    return textRect;
}

@end
