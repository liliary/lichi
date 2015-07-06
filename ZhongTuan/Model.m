//
//  Model.m
//  ZhongTuan
//
//  Created by anddward on 15/1/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"
#import <objc/runtime.h>

@interface Model(){
}
@end

@implementation Model
/**
    init model form dictionary
 */
-(id)initWithDic:(NSDictionary*)dic{

    if (self = [super init]) {
        Class clazz = [self class];
        unsigned int count = 0;
        objc_property_t* properties = class_copyPropertyList(clazz, &count);
        for (int i=0; i<count; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithUTF8String:property_getName(property)];
            if ([_custom_properties containsObject:propertyName]) {
                [self initWithCustomKey:propertyName value:dic[propertyName]];
                continue;
            }
            NSString *description = [NSString stringWithUTF8String:property_getAttributes(property)];
            
            if (NSNotFound != [description rangeOfString:@"NSNumber"].location) {
                NSNumberFormatter *f = [NSNumberFormatter new];
                NSNumber *numValue = [f numberFromString:dic[propertyName]];
                if (nil != numValue) {
                    [self setValue:numValue forKey:propertyName];
                }else{
                    [self setValue:@-1 forKey:propertyName];
                }
            }else if(NSNotFound != [description rangeOfString:@"NSString"].location){
                NSString *stringValue = dic[propertyName];
                if (nil != stringValue) {
                    [self setValue:stringValue forKey:propertyName];
                }else{
                    [self setValue:@"" forKey:propertyName];
                }
            }
            else{
                // you should not arrive here
                @throw [NSException exceptionWithName:@"OBJECT_INIT_EXCEPTION" reason:@"unsupport value type set to object property" userInfo:nil];
            }
            
        }
        free(properties);
    }
    return self;
}

// 非标准 property 初始化
-(void)initWithCustomKey:(NSString*)key value:(id)value{
}

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
}
@end
