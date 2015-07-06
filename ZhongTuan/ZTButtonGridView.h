//
//  ZTButtonGridView.h
//  ZhongTuan

//  返回8格按钮显示view
//
//  Created by anddward on 14-11-14.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

@protocol ZTButtonGridViewDelegate <NSObject>
@optional
-(void)didTapCollectionAtIndex:(NSIndexPath*)index;
@end

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
@interface ZTButtonGridView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak,nonatomic) id<ZTButtonGridViewDelegate> ztButtonViewDelegate;
@property (strong,nonatomic) UIColor* borderColor;
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property(copy,nonatomic)NSString*tag;
-(ZTButtonGridView*)initWithIcons:(NSDictionary*)iconNames cell:(NSString*)cellClassName column:(long)col rowSpace:(float)rowSpace columnSpace:(float)colSpace edgeSpace:(float)edgeSpace;

@end
