//
//  TapView.h
//  ZhongTuan
//
//  Created by anddward on 15/5/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
@interface TapView : UIView

@property(nonatomic,strong)ZTImageLoader*pic;
@property(nonatomic,copy)NSString*tagg;

@property(nonatomic,strong)UIImageView*picview;
//处理点击事件
-(void)setTarget:(id)target trigger:(SEL)selector;
//处理图片
-(void)Icons:(NSString*)picurl;
@end
