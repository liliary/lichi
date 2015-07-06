//
//  titleLabel.h
//  ZhongTuan
//
//  Created by anddward on 14-11-27.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
    生成默认的标题bar title
 */

@interface ZTTitleLabel : UILabel

-(id)initWithTitle:(NSString*)title;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor* lineColor;
@end
