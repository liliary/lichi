//
//  NearCell.h
//  ZhongTuan
//
//  Created by anddward on 14-11-14.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

@interface NearCell : UITableViewCell

@property (nonatomic,strong) ZTImageLoader *pic;      //图片
@property (nonatomic,strong) UIImageView *corner;   //图片左上角优惠标记
@property (nonatomic,strong) UILabel *title;        //标题
@property (nonatomic,strong) UILabel *distance;     //距离
@property (nonatomic,strong) UIWebView *summary;    //简介
@property (nonatomic,strong) UILabel *price;        //价格
@property (nonatomic,strong) UILabel *promotion;    //促销tag
@property (nonatomic,strong) UILabel *sale;         //销量
@property (strong,nonatomic) UIColor* borderColor;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;

@end
