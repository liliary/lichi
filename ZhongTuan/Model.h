//
//  Model.h
//  ZhongTuan
//
//  Created by anddward on 15/1/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZTModelDelegate<NSObject,NSCoding>
@optional
-(void)initWithCustomKey:(NSString*)key value:(id)value;
@end

@interface Model : NSObject <ZTModelDelegate>{
    @protected NSMutableArray *_custom_properties;
}

-(id)initWithDic:(NSDictionary*)dic;
@end
