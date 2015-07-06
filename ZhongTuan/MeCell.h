//
//  MeCell.h
//  ZhongTuan
//
//  Created by anddward on 14-11-22.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCell : UITableViewCell

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,assign) CGFloat borderMargin;

@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;

@end
