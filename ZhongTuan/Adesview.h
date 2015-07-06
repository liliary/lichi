//
//  Adesview.h
//  ZhongTuan
//
//  Created by anddward on 15/5/12.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
@interface Adesview : UIView
@property(nonatomic,strong)ZTImageLoader*pic;
//处理点击事件
-(void)setTarget:(id)target trigger:(SEL)selector;
-(instancetype)initWithFrame:(CGRect)frame Withpicurl:(NSString*)picurl;
@end
