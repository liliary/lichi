//
//  NoPayCell.h
//  ZhongTuan
//
//  Created by anddward on 15/4/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
@interface NoPayCell : UITableViewCell
@property (nonatomic,strong) ZTImageLoader *pic;      //图片
@property (nonatomic,strong) UILabel *title;        //标题
@property (nonatomic,strong) UILabel *totolprice;     //总价
@property (nonatomic,strong) UILabel *quantity;        //数量
@property (strong,nonatomic) UIColor* borderColor;
@property (copy, nonatomic) void (^aactionBlock)(void);//去付款
//@property(nonatomic,strong) UILabel*ordernumber;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) CGFloat indicatorRightPadding;
@property(copy,nonatomic)NSString*tagg;
@end
