//
//  User.m
//  ZhongTuan
//
//  Created by anddward on 14-11-6.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "User.h"


@implementation User

-(BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[User class]]) {
        User *obj = (User*)object;
        return [obj.acctoken isEqual:_acctoken];
    }
    return NO;
}

@end
