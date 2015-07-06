//
//  City.h
//  ZhongTuan
//
//  Created by anddward on 15/3/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface City : Model
@property (nonatomic,strong) NSString *CityName;        // 城市名称
@property (nonatomic,strong) NSNumber *ProID;           // 省份id
@property (nonatomic,strong) NSNumber *_id;             // 城市id
@property (nonatomic,strong) NSNumber *CityCode;        // 城市Code
@property (nonatomic,strong) NSString *Sim_Cit_Name;    // 城市简称
@property (nonatomic,strong) NSString *_code;           // 城市拼音简称
@end
