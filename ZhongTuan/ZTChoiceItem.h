//
//  ZTChoiceItem.h
//  ZhongTuan
//
//  Created by anddward on 15/3/2.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
//   _________________________
//  |                         |
//  | title    content..   >  |
//  |_________________________|

#import <UIKit/UIKit.h>

@interface ZTChoiceItem : UIView
@property (nonatomic,strong) UILabel *choiseTitleLable;
@property (nonatomic,strong) UIButton *choiseContentBtn;
@property (nonatomic,assign) CGFloat contentLeftMargin; // if not set ,chooiseContentLabel start after titleLabel
@property (nonatomic,assign) CGFloat indicatorRightMargin;
// border
@property (nonatomic,assign) BOOL bottomBorder;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,assign) UIColor *borderColor;


@property (assign,nonatomic) NSInteger tag;
-(id)initWithTitle:(NSString*)title content:(NSString*)content tag:(NSInteger)tag;
@end
