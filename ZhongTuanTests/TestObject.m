//
//  TestObject.m
//  ZhongTuan
//
//  Created by anddward on 15/2/1.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "TestObject.h"
#import <Objc/runtime.h>

@implementation TestObject
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        Class clazz = [self class];
        unsigned int count = 0;
        objc_property_t* properties = class_copyPropertyList(clazz, &count);
        for (int i=0; i<count; i++) {
            objc_property_t p = properties[i];
            NSString *pName = [NSString stringWithUTF8String:property_getName(p)];
            [self setValue:[aDecoder decodeObjectForKey:pName] forKey:pName];
        }
        
//        self.s1 = [aDecoder decodeObjectForKey:@"s1"];
//        self.s2 = [aDecoder decodeObjectForKey:@"s2"];
//        self.n1 = [aDecoder decodeObjectForKey:@"n1"];
//        self.n2 = [aDecoder decodeObjectForKey:@"n2"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    Class clazz = [self class];
    unsigned int count = 0;
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    for (int i=0; i<count; i++) {
        objc_property_t p = properties[i];
        NSString *pName = [NSString stringWithUTF8String:property_getName(p)];
        [aCoder encodeObject:[self valueForKey:pName] forKey:pName];
    }
//    [aCoder encodeObject:_s1 forKey:@"s1"];
//    [aCoder encodeObject:_s2 forKey:@"s2"];
//    [aCoder encodeObject:_n1 forKey:@"n1"];
//    [aCoder encodeObject:_n2 forKey:@"n2"];
}
@end
