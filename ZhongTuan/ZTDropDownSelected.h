//
//  ZTDropDownSelected.h
//  ZhongTuan
//
//  Created by anddward on 14-11-20.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSelectedHolder.h"

//////////////// usage demo
//    NSArray *data = @[@{@"key":@"全部分类",@"val":@[
//                            @{@"key":@"美食",@"val":@[@"全部",@"自助餐",@"西餐",@"火锅",@"日韩料理",@"粤菜"]},
//                            @{@"key":@"电影",@"val":@[@"全部",@"电影团购",@"在线订座"]},
//                            @{@"key":@"娱乐",@"val":@[@"全部",@"KTV",@"桑拿",@"按摩",@"酒吧"]},
//                            @{@"key":@"酒店",@"val":@[@"全部",@"小时房",@"经济房",@"四星级",@"公寓"]}]},
//                      @{@"key":@"全城",@"val":@[@"越秀区",@"天河区",@"荔湾区",@"番禺区",@"海珠区",@"南沙区"]},
//                      @{@"key":@"智能排序",@"val":@[@"根据价格排序",@"根据距离排序",@"根据好评排序"]}];
//
//    ZTDropDownSelected *view = [[ZTDropDownSelected alloc] initWithFrame:CGRectMake(0, 330, 320, 150) withData:data];
//    [self.view addSubview:view];

@class ZTSelectedHolder;

@protocol ZTDropDownSelectedDelegate <NSObject>

@optional

-(CGSize)sizeForSegment;
-(void)initHolder:(ZTSelectedHolder*)holder;

@end

@interface ZTDropDownSelected : UIView

/// delegate
@property (nonatomic,weak) id<ZTDropDownSelectedDelegate> ztdelegate;

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
