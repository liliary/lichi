//
//  SessionView.h
//  ZhongTuan
//
//  Created by anddward on 15/2/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// a view with topBorder && bottomBorder
// |================================|
// |                                |
// |                                |
// |================================|

#import <UIKit/UIKit.h>

@interface ZTSessionView : UIView

@property (strong,nonatomic) UIColor* lineColor;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;

@end
