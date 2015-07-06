//
//  Area.h
//  ZhongTuan
//
//  Created by anddward on 15/3/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface Area : Model
@property (nonatomic,strong) NSNumber* _id;         // 地区id
@property (nonatomic,strong) NSString* ZoneName;    // 地区名称
@property (nonatomic,strong) NSNumber* CityID;      // 地区所属城市id
@end
