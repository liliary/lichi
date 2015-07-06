//
//  ZTIconLabel.h
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// ___________________________
// |  ___                     |
// | |___|  title ....        |
// |__________________________|

#import <UIKit/UIKit.h>

@interface ZTIconLabel : UIView

@property (strong,nonatomic) UIImageView* iconView;
@property (strong,nonatomic) UILabel* titleView;
@property (assign,nonatomic) CGFloat iconGap;
@property (assign,nonatomic) CGFloat contentGap;

-(id)initWithIcon:(UIImage*)icon title:(NSString*)title;
-(id)fitSize;
@end
