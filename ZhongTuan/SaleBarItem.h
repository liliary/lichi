//
//  SaleBarItem.h
//  ZhongTuan
//
//  Created by anddward on 15/3/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleBarItem : UIButton
@property (nonatomic,assign) BOOL topBorder;
@property (nonatomic,assign) BOOL bottomBorder;
@property (nonatomic,assign) BOOL showIndicator;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat indicatorRightMargin;
@property (nonatomic,assign) CGFloat iconLeftGap;
@property (nonatomic,assign) CGFloat icon2titleGap;
@property (nonatomic,strong) UIImage *icon;

+(id)initWithIcon:(UIImage*)icon title:(NSString*)title indicator:(BOOL)showIdicator;
@end
