//
//  ZTItemButton.h
//  ZhongTuan
//
//  Created by anddward on 15/2/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// a button like this
// __________________________
// |                        |
// | text                 > |
// |________________________|

#import <UIKit/UIKit.h>

@interface ZTItemButton : UIButton

@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) CGFloat indicatorRightPadding;
@property (assign,nonatomic) UIColor *borderColor;

-(id)initWithTitle:(NSString*)buttonTitle;
@end
