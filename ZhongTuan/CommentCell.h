//
//  CommentCell.h
//  ZhongTuan
//
//  Created by anddward on 15/4/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "ZTImageLoader.h"
#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property(nonatomic,strong)UILabel*name;
@property(nonatomic,strong)UILabel*time;
@property(nonatomic,strong)UILabel* start;
@property(nonatomic,strong)UITextView*content;
@property (nonatomic,strong) ZTImageLoader *pic;      //图片
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,assign) CGFloat borderMargin;

@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;

@end
