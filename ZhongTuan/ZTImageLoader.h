//
//  ZTImageLoader.h
//  ZhongTuan
//
//  Created by anddward on 15/2/2.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//  TODO: 解决图片下载好后不更新的问题.(reload Data,call back)

#import <Foundation/Foundation.h>

@interface ZTImageLoader : UIImageView
@property(nonatomic,strong)NSLock*mylock;
-(void)setImageFromUrl:(NSString*)url;
-(void)setImageFromUrl:(NSString *)url backgroundColor:(UIColor*)color;
@end
