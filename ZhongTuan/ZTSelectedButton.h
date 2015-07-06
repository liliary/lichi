//
//  ZTSelectedButton.h
//  ZhongTuan
//
//  Created by anddward on 14-11-28.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
/* enum */
// 按钮状态
typedef NS_ENUM(NSInteger, ZTSelecctedButtonStatus){
    ZTSelectedButtonStatusNol = 0,        // 平常状态（关闭，收起）
    ZTSelectedButtonStatusSel = 1,         // 选中状态（打开，下拉）
};
// 指示器类型
typedef NS_ENUM(NSInteger, ZTSelectedButtonRightIndicatorType){
    ZTSelectedButtonRightIndicatorTypeReplace = 0,  // 替换，当状态改变时，替换indicator的背景图；
    ZTSelectedButtonRightIndicatorTypeRotate = 1,   // 旋转，当状态改变时，旋转indicator；
    ZTSelectedButtonRightIndicatorTypeLabel = 2,    // 旋转，indicator是一个label
};

/* delegate */
@protocol ZTSelectedButtonDelegate <NSObject>
@optional
    -(void)didTapZTSelectedButton:(NSInteger)index;
@end

/* class */
@interface ZTSelectedButton : UIView
///// views
// 文本
@property (nonatomic,strong) NSString *labelTitleForNol;
@property (nonatomic,strong) NSString *labelTitleForSel;
// 文本颜色
@property (nonatomic,strong) UIColor *labelColorForNol;
@property (nonatomic,strong) UIColor *labelColorForSel;
// 文本大小
@property (nonatomic,assign) CGFloat labelFontSizeForNol;
@property (nonatomic,assign) CGFloat labelFontSizeForSel;
// 右边indicator图片
@property (nonatomic,strong) UIImage *rIconImageForNol;
@property (nonatomic,strong) UIImage *rIconImageForSel;
// 底部indicator图片
@property (nonatomic,strong) UIImage *bIconImageForNol;
@property (nonatomic,strong) UIImage *bIconImageForSel;

/// style
@property (nonatomic,assign) ZTSelectedButtonRightIndicatorType rIconType;  // 指示器类型
@property (nonatomic,assign) CGFloat rIconMarginRight;

/// delegate
@property (nonatomic,weak) id<ZTSelectedButtonDelegate> ztDelegate; //  代理
@property (nonatomic,assign) NSInteger index;
/** 
    初始化
    @args title: Label文本，设置为nomal状态文本
    @args rIcon: 右边indicator 图片,设置为nomal状态文本
    @args bIcon: 底部indicator 图片,设置为nomal状态文本
 */
-(id)initWithTitle:(NSString*)title rightIndicatorImage:(UIImage*)rIcon bottomIndicatorImage:(UIImage*)bIcon;

/**
    改变按钮状态,warning：该操作会改变按钮的显示样式。
    @args status: 参考 enum ZTSelecctedButtonStatus.
 */
-(void)setButtonState:(ZTSelecctedButtonStatus)status;

/**
    构建view
 */
-(void)createViews;

@end
