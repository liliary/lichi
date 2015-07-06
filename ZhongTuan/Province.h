//
//  Province.h
//  ZhongTuan
//
//  Created by anddward on 15/3/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface Province : Model
@property (nonatomic,strong) NSString* ProName;         // 省份名称
@property (nonatomic,strong) NSNumber* _id;             // 省份id
@property (nonatomic,strong) NSString* ProRemark;       // 省份类型 eg：省份、直辖市
@property (nonatomic,strong) NSString* SimP_Pro_Name;   // 省份简称
@property (nonatomic,strong) NSString* _code;           // 省份拼音简称
@end
