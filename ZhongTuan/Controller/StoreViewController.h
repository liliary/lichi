//
//  StoreViewController.h
//  ZhongTuan
//
//  Created by apple on 15/4/11.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSessionTitle.h"
@interface StoreViewController : UIViewController

// 顶部栏
@property (nonatomic,strong) UIView *topBar;         // 顶部栏
@property (nonatomic,strong) UIButton *backBtn;         // 返回按钮
@property (nonatomic,strong) UICollectionView *shopproducts;
@property (nonatomic,strong) ZTSessionTitle *recommendTitle;//collection 头部
@property(nonatomic,strong)NSNumber*shopidd;
@end
