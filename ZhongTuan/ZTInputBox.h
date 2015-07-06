//
//  ZTInputBox.h
//  ZhongTuan
//
//  Created by anddward on 14-11-7.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTInputBox : UIView<UITextFieldDelegate>

@property (nonatomic,strong) NSNumber *leftPadding;    // 左边空隙
@property (nonatomic,strong) NSNumber *rightPadding;   // 右边空隙
@property (nonatomic,strong) NSNumber *labelGap;       // label 和分隔符之间的空隙
@property (nonatomic,strong) NSNumber *contentGap;     // 输入框和分割符之间的空隙
@property (nonatomic,strong) NSDictionary *textFieldLimitation; // @{@"LimitRegular":@"failed message"}

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *textLabel;
@property (strong,nonatomic) UIColor* lineColor;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) CGFloat borderWidth;

// 设置图片 label
-(void)setImageLabel:(UIImage*)image withSeparator:(UIImage*)separator;
// 设置文字 label
-(void)setTextLabel:(NSString*)title withSeparator:(NSString*)separator;
// 收起键盘
-(void)closeKeyBoard;
// 校验输入框
-(BOOL)validate;

@end
