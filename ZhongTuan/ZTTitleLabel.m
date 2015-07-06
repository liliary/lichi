//
//  titleLabel.m
//  ZhongTuan
//
//  Created by anddward on 14-11-27.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTTitleLabel.h"

@implementation ZTTitleLabel

-(id)initWithTitle:(NSString *)title{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.text = title;
        self.font = [UIFont systemFontOfSize:16.0];
        self.textColor = [UIColor redColor];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

@end
