//
//  ZTCheckButton.h
//  ZhongTuan
//
//  Created by anddward on 15/2/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
//   ________________________
//  |                        |
//  | text ....  [img]       |
//  |________________________|

#import <UIKit/UIKit.h>

@interface ZTCheckButton : UIButton

@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,assign) CGFloat contentGap;
@property (nonatomic,assign) BOOL checkable;
@property (nonatomic,assign) BOOL bottomBorder;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat leftMarginGap;

-(id)initWithTitle:(NSString*)title ImageIcon:(UIImage*)icon selected:(UIImage*)selIcon contentGap:(CGFloat)gap;
@end
