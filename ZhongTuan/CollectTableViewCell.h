//
//  CollectTableViewCell.h
//  ZhongTuan
//
//  Created by anddward on 15/5/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

@interface CollectTableViewCell : UITableViewCell
@property (nonatomic,strong) ZTImageLoader *pic;      //图片
@property (nonatomic,strong) UILabel *title;        //标题
@property (nonatomic,strong) UILabel *totolprice;     //总价
@property (strong,nonatomic) UIColor* borderColor;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) CGFloat indicatorRightPadding;

@end
