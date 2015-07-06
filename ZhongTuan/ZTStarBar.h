//
//  ZTStarBar.h
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
//  ______________________________
// |                              |
// | 星 星 星 星 星 星   分数.       |
// |______________________________|

#import <UIKit/UIKit.h>

@interface ZTStarBar : UIView

@property (strong,nonatomic) UIImageView* topBar;
@property (strong,nonatomic) UIImageView* bottomBar;
@property (strong,nonatomic) UILabel* scoreLabel;
@property (assign,nonatomic) CGFloat scoreGap;
@property (assign,nonatomic) CGFloat score;
@property (assign,nonatomic) CGFloat leftGap;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (strong,nonatomic) UIColor* lineColor;

-(id)initWithFillStar:(UIImage*)fillStar
            emptyStar:(UIImage*)emptyStar
                 count:(NSInteger)count
                   gap:(CGFloat)gap;

-(id)fitSize;

@end
