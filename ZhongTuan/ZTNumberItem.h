//
//  ZTNumberItem.h
//  ZhongTuan
//
//  Created by anddward on 15/3/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTNumberItem : UIView
@property (nonatomic,strong) UILabel *title;        // 数量标题
@property (nonatomic,strong) UITextField *countLabel;   // 计数框
@property (nonatomic,strong) UIButton *addBtn;      // 加按钮
@property (nonatomic,strong) UIButton *subBtn;      // 减按钮
@property (nonatomic,strong) UILabel *kcTag;        // 库存tag
@property (nonatomic,strong) UILabel *kc;           // 库存
@property (nonatomic,strong) UILabel *kcUnitTag;    // 库存单位tag
// call back
@property (nonatomic,copy) void (^didTapAddBtn)();
@property (nonatomic,copy) void (^didTapSubBtn)();
@end
