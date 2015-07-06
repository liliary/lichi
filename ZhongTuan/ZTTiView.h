//
//  ZTTiView.h
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

// |--------------------|
// |BigTitle(blod)      |
// |                    |
// |litle title....     |
// |____________________|
//
#import <UIKit/UIKit.h>

@interface ZTTiView : UIView

@property (strong,nonatomic) UILabel* titleLabel;
@property (strong,nonatomic) UILabel* infoLabel;
@property (assign,nonatomic) CGFloat leftGap;
@property (assign,nonatomic) CGFloat titleLabelUp;
@property (assign,nonatomic) CGFloat infoLabelDown;
@property (assign,nonatomic) CGFloat topLayout;
@property (assign,nonatomic) CGFloat bottomLayout;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) BOOL topBorder;
@property (strong,nonatomic) UIColor* lineColor;
@property (assign,nonatomic) CGFloat borderWidth;

-(id)initWithTitle:(NSString*)title info:(NSString*)info;
-(id)fitSize;
@end
