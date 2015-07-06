//
//  ActivitiesCellTableViewCell.h
//  ZhongTuan
//
//  Created by anddward on 14-11-21.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

@interface ActivitiesCell : UITableViewCell
@property (nonatomic,strong) ZTImageLoader *topPic;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *aTime;
@property (nonatomic,strong) UILabel *aPhone;
@property (nonatomic,strong) UILabel *aQQ;
@property (nonatomic,strong) UILabel *aAddress;
@end
