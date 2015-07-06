//
//  ZTFundamantalAddiction.m
//  ZhongTuan
//
//  Created by anddward on 14-11-7.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTFundationAddiction.h"
#import <CommonCrypto/CommonDigest.h>
#import "Model.h"
#import <objc/runtime.h>

@implementation UIColor(ZTFundationAddiction)

+(UIColor*)colorWithHexTransparent:(long)hexColor{
    float alpha = ((float)((hexColor & 0xFF000000) >> 24))/255.0;
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)( hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(UIColor*)colorWithHex:(long)hexColor{
    return [self colorWithHexTransparent:(hexColor|0xff000000)];
}

@end

@implementation NSLayoutConstraint (ZTFundationAddiction)
+(NSArray*)vsfm:(NSString*)vsfm opt:(NSLayoutFormatOptions)opt mts:(NSDictionary*)mts vs:(NSDictionary*)vs{
    return [NSLayoutConstraint constraintsWithVisualFormat:vsfm options:opt metrics:mts views:vs];
}
@end

@implementation UINavigationBar(ZTFundationAddiction)

@end

@implementation NSString(ZTFundationAddiction)

/**
    添加删除线
 */
-(NSMutableAttributedString*)addStriket{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    [string setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, string.length)];
    return string;
}

/**
    翻转字符串
 */
-(NSString*)reverseString{
    NSInteger len = [self length];
    unichar *buffer = malloc(len*sizeof(unichar));
    if (buffer == nil) {
        return nil;
    }
    NSRange range = NSMakeRange(0, len);
    [self getCharacters:buffer range:range];
    for (NSInteger stPos = 0, endPos = len-1;stPos < len /2;stPos++ ,endPos--){
        unichar tmp = buffer[endPos];
        buffer[endPos] = buffer[stPos];
        buffer[stPos] = tmp;
    }
    return [[NSString alloc] initWithCharactersNoCopy:buffer length:len freeWhenDone:YES];
}

/**
    md5 加密字符串
 */

-(NSString*)md5{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char md5buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes],(int)[data length], md5buffer);
    NSMutableString *target = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for ( int i=0;i<CC_MD5_DIGEST_LENGTH;i++ ){
        [target appendFormat:@"%02x",md5buffer[i]];
    }
    return [NSString stringWithString:target];
}

/**
    拼接 url
 */
+(NSString*)stringURLWithAppendex:(NSString*)appendString{
    return [NET_API_BASE stringByAppendingString:appendString];
}

@end

@implementation NSDictionary(ZTFundationAddiction)

/**
    组装参数数组 => NSData
 */
-(NSData*)assembleHttpParamsData{
    NSMutableString *target = [NSMutableString new];
    BOOL isBegin = YES;
    for (NSString* key in [self allKeys]){
        if (isBegin) {
            isBegin = NO;
        }else{
            [target appendString:@"&"];
        }
        [target appendFormat:@"%@=%@",key,self[key]];
    }
    return [target dataUsingEncoding:NSUTF8StringEncoding];
}

/**
    json 解释单个对象
 */
-(id)jsonParseWithType:(Class)clazz{
    Model *target = [[clazz new] initWithDic:self];
    return target;
}

/**
    json 解释整个字典
 */
-(NSDictionary*)jsonParseToDictionaryWithType:(Class)clazz{
    NSMutableDictionary *targetDic = [NSMutableDictionary new];
    NSArray *keys = [self allKeys];
    for (NSString *key in keys) {
        Model *target = [[clazz new] initWithDic:self[key]];
        [targetDic setObject:target forKey:key];
    }
    return targetDic;
}

@end

@implementation NSArray(ZTFundationAddiction)

/**
    json 解释数组
 */
-(NSArray*)jsonParseToArrayWithType:(Class)clazz{

    NSMutableArray *targetAry = [NSMutableArray new];
    for (NSDictionary *objDic in self) {
        Model *target = [[clazz new] initWithDic:objDic];
        [targetAry addObject:target];
    }
    return targetAry;
}

@end

/**
    得到屏幕宽度
 */
inline long screenWidth(){
    return [[UIScreen mainScreen] bounds].size.width;
}

/**
    得到屏幕高度
 */
inline long screenHeight(){
    return [[UIScreen mainScreen] bounds].size.height;
}

/**
    得到屏幕 size
 */
inline CGSize screenSize(){
    return [[UIScreen mainScreen] bounds].size;
}

/**
    提示框
 */
void alertShow(NSObject* content){
    //TODO: sub class and add block call back
    NSString *str = [NSString stringWithFormat:@"%@",content];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

void initViewProperties(Class clazz){
    unsigned int property_Count;
    objc_property_t *properties = class_copyPropertyList(clazz, &property_Count);
    for (int i=0; i<property_Count; i++) {
        objc_property_t p = properties[i];
        const char *des = property_getAttributes(p);
        fprintf(stdout, "%s\r\n",des);
    }
}

const char* getFileName(){
//get shujukudizhi
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *libPath = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *sqlitePath = [libPath URLByAppendingPathComponent:@"zt.sqlite"];
    
    if (![fm fileExistsAtPath:[sqlitePath path]]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"china_province_city_zone" ofType:@"db"];
        if (sourcePath) {
            [fm copyItemAtPath:sourcePath toPath:[sqlitePath path] error:nil];
        }
    }
    return [[sqlitePath path] UTF8String];
}

