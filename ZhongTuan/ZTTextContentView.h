//
//  ZTTextContentView.h
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

// a UITextView with Border
// +========================+
//|| text                   ||
//||                        ||
// +========================+

#import <UIKit/UIKit.h>

@interface ZTTextContentView : UITextView
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) BOOL leftBorder;
@property (assign,nonatomic) BOOL rightBorder;
@property (strong,nonatomic) UIColor* borderColor;
@end
