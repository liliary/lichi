//
//  ZTSelectedHolder.m
//  ZhongTuan
//
//  Created by anddward on 14-11-28.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTSelectedHolder.h"
#import "ZTSelectedButton.h"

@interface ZTSelectedHolder()<ZTSelectedButtonDelegate>{
    /// buttons
    NSMutableArray *_buttons;
}

@end

@implementation ZTSelectedHolder

#pragma mark - public methods

-(instancetype)initWithFrame:(CGRect)frame delegate:(id)ztDelegate{
    self = [super initWithFrame:frame];
    if (self) {
        [self initButtonsWithDelegate:ztDelegate];
    }
    return self;
}

// 初始化button
-(void)initButtonsWithDelegate:(id)ztDelegate{
    _buttons = [[NSMutableArray alloc] init];
    _ztDelegate = ztDelegate;
    [self createButtons];
    [self addSubViews:_buttons];
}

#pragma mark - buildViews
/**
    组装按钮
 */
-(void)createButtons{
    NSInteger count = [_ztDelegate numberOfButtonsInHolder];
    for (int i=0 ;i<count ;i++){
        ZTSelectedButton *button = [[ZTSelectedButton alloc] init];
        [_ztDelegate initButton:button ForHolderAtIndex:i];
        button.index = i;
        button.ztDelegate = self;
        _buttons[i] = button;
    }
}

-(void)layoutSubviews{
    /// size & position
//    CGFloat buttonWidth = (CGRectGetWidth(self.bounds)-(_buttons.count-1)*_buttonInterval)/_buttons.count;
    for (int i=0; i<_buttons.count; i++) {
//        ZTSelectedButton *button = _buttons[i];
//        CGFloat buttonHeight = [_ztDelegate heightForButtonAtIndex:i];
//        button.frame = CGRectMake((buttonWidth+_buttonInterval)*i, 0, buttonWidth, buttonHeight);
//        [button setRectCenterVertical];
    }
}

#pragma mark - ZTSelectedButtonDelegate
/**
 处理ztselected按钮点击事件,被点击按钮打开，其余按钮关闭。
 warning：会触发holder组件的didTapButtonAtIndex:方法
 */
-(void)didTapZTSelectedButton:(NSInteger)index{
    for (ZTSelectedButton *button in _buttons) {
        if (index != button.index){
            [button setButtonState:ZTSelectedButtonStatusNol];
        }else{
//            [_ztDelegate didTapButton:button AtIndex:button.index];
            [button setButtonState:ZTSelectedButtonStatusSel];
        }
    }
}
@end
