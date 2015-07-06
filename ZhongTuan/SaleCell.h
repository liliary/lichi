//
//  SaleCell.h
//  ZhongTuan
//
//  Created by anddward on 14-11-19.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

@interface SaleCell : UICollectionViewCell

@property (strong,nonatomic) ZTImageLoader* pic;        //产品图片
@property (strong,nonatomic) UIImageView* rightCorner;  //右上角tag
@property (strong,nonatomic) UIImageView* lace;         //产品底部蕾丝
@property (strong,nonatomic) UILabel* title;            //标题
@property (strong,nonatomic) UILabel* price;            //价格
@property (strong,nonatomic) UILabel* del_price;        //删除价格

@end
