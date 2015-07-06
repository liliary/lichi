//
//  CategoryCell.m
//  ZhongTuan
//
//  Created by anddward on 14-11-27.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 91.0);
    }
    return self;
}

@end
