//
//  ZTContentLabel.h
//  ZhongTuan
//
//  Created by anddward on 15/2/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

// a Label with ContentEdgeInsets

#import <UIKit/UIKit.h>

@interface ZTContentLabel : UILabel
@property (assign,nonatomic) UIEdgeInsets labelEdgeInset;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) UIColor *borderColor;
@end
