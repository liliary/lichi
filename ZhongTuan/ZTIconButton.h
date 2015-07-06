//
//  complexButton.h
//  ZhongTuan
//
//  Created by anddward on 14-11-22.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    a view like this:
    ----------------------------
    |  ______  _____________   |
    |  |icon|  |messageView|   |
    |  ------  -------------   |
    ----------------------------
 */

typedef NS_ENUM(NSInteger, ZTIconButtonAlignMode){
    ZTIconButtonAlignModeCenter = 1,
    ZTIconButtonAlignModeLeft = 2,
};

@interface ZTIconButton : UIView
@property (strong,nonatomic) UIImageView *icon;
@property (assign,nonatomic) CGFloat  iconLeftGap;
@property (assign,nonatomic) CGFloat  iconContentGap;
@property (assign,nonatomic) CGFloat  bottomLabelMoveDown;
@property (strong,nonatomic) UILabel* labelTop;
@property (strong,nonatomic) UILabel* labelBottom;
@property (assign,nonatomic) ZTIconButtonAlignMode alignMode;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) BOOL leftBorder;
@property (assign,nonatomic) BOOL rightBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (strong,nonatomic) UIColor* borderColor;
@property(strong,nonatomic)NSString*tagg;
-(void)setTarget:(id)target trigger:(SEL)selector;
@end
