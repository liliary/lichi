//
//  NearButtonCell.h
//  ZhongTuan
//
//  Created by anddward on 14-11-13.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
@interface ZTButtonCell : UICollectionViewCell
@property(nonatomic,assign)NSInteger*tag;
@property(nonatomic,strong)ZTImageLoader*pic;
@property(nonatomic,copy)NSString*taggg;
-(void)setTitle:(NSString*)title;
-(void)setImage:(UIImage*)icon;
-(void)passvule:(NSString*)str;

@end
