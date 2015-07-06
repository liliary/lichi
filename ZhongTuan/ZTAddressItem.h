//
//  ZTAddressItem.h
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTAddressItem : UIView
// 个人信息
@property (nonatomic,strong) UILabel* nameLabel;
@property (nonatomic,strong) UILabel* phoneLabel;
// 地址信息
@property (nonatomic,strong) UILabel* addTag;
@property (nonatomic,strong) UILabel* addLabel;
// 位置参数
@property (nonatomic,assign) CGFloat leftPadding;           // 左缩进距离
@property (nonatomic,assign) CGFloat lineGap;               // 上下两行之间的距离
@property (nonatomic,assign) CGFloat rightPadding;          // 距离右边indicator 的距离
@property (nonatomic,assign) CGFloat indicatorRightPadding; // indicator 距离右边距离
@property (nonatomic,assign) CGFloat borderWidth;           // 边框宽度
@property (nonatomic,strong) UIColor *borderColor;          // 边框颜色
@property (nonatomic,assign) CGFloat contentGap;            // 内容之间的空隙
@end
