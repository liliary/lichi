//
//  ZTRoundRedButton.m
//  ZhongTuan
//
//  Created by anddward on 15/1/29.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTRoundButton.h"

@implementation ZTRoundButton

-(instancetype)initWithTitle:(NSString*)title textcolor:(UIColor*)color{
    return [self initWithTitle:title textcolor:color backgroundImage:nil];
}

-(instancetype)initWithTitle:(NSString*)title textcolor:(UIColor*)color backgroundImage:(UIImage*)image{
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 5.0;
    }
    return self;
}

@end
