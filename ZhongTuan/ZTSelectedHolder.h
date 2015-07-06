//
//  ZTSelectedHolder.h
//  ZhongTuan
//
//  Created by anddward on 14-11-28.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSelectedButton.h"
/********************************* delegate **********************************/
@protocol ZTSelectedHolderDelegate <NSObject>
/**
    按钮数量
    @return: holder应该包含的按钮的数量。
 */
-(NSInteger)numberOfButtonsInHolder;

/**
 按钮初始化,holder默认会将序号先分配给按钮
 @args button:需要被初始化的按钮
 index:按钮序号
 */
-(void)initButton:(ZTSelectedButton*)button ForHolderAtIndex:(NSInteger)index;

@end

@protocol ZTSelectedHolderOnClick <NSObject>

/**
    按钮点击代理
    @args index:按钮序号
 */
-(void)didTapButton:(ZTSelectedButton*)button AtIndex:(NSInteger)index;

@end

/********************************* class **********************************/

/* class */
@interface ZTSelectedHolder : UIView

// view
@property (nonatomic,strong) UIImageView *separator;

// attribute
@property (nonatomic,assign) CGFloat buttonInterval;

// delegate
@property (nonatomic,assign) id<ZTSelectedHolderDelegate> ztDelegate;
@property (nonatomic,assign) id<ZTSelectedHolderOnClick> ztClickDelegate;

/**
    初始化。
 */
-(instancetype)initWithFrame:(CGRect)frame delegate:(id)ztDelegate;

/**
    初始化按钮
 */
-(void)initButtonsWithDelegate:(id)ztDelegate;

@end
