//
//  SettingCell.h
//  ZhongTuan
//
//  Created by anddward on 15/2/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) BOOL topBorder;
@property (nonatomic,assign) BOOL bottomBorder;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,assign) CGFloat borderMargin;
@end
