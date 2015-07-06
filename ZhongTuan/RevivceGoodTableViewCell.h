//
//  RevivceGoodTableViewCell.h
//  ZhongTuan
//
//  Created by anddward on 15/5/19.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
#import "ZTIconButton.h"
@interface RevivceGoodTableViewCell : UITableViewCell
@property (nonatomic,strong) ZTImageLoader *pic;      //图片
@property (nonatomic,strong) UILabel *title;        //标题
@property (nonatomic,strong) UILabel *totolprice;     //总价
@property (nonatomic,strong) UILabel *quantity;        //数量
@property(nonatomic,strong)UILabel*ordernumber;        //订单号
@property(nonatomic,strong)UILabel*state;             //状态
@property(nonatomic,strong)UILabel *delivercom;    //快递公司
@property(nonatomic,strong)UILabel*delivernumber;//物流单号
@property (strong,nonatomic) UIColor* borderColor;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property(nonatomic,strong)UIButton*showdelier; //查看物流
@property(nonatomic,strong)UIButton*qrsh;       //确认收货
@property(nonatomic,strong)UILabel *wudh;      //物流单号
@property(nonatomic,strong)UILabel *dd;      //订单号
@property (copy, nonatomic) void (^actionBlock)(void);//查看物流回调
@property (copy, nonatomic) void (^aactionBlock)(void);//确认收货回调
@property(nonatomic,copy)NSString*tagg;

@end

