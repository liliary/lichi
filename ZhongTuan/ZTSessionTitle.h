//
//  ZTSessionTitle.h
//  ZhongTuan
//
//  Created by anddward on 15/2/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// a UILabel with top & bottom Border

#import <UIKit/UIKit.h>

@interface ZTSessionTitle : UILabel

@property (assign,nonatomic) UIEdgeInsets titleInsets;
@property (strong,nonatomic) UIColor* lineColor;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;

-(id)initWithTitle:(NSString*)title;
@end
