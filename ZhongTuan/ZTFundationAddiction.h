//
//  ZTFundationAddiction.h
//  ZhongTuan
//
//  Created by anddward on 14-11-7.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(ZTFundationAddiction)
+(UIColor*)colorWithHexTransparent:(long)hexColor;
+(UIColor*)colorWithHex:(long)hexColor;
@end

@interface UINavigationBar(ZTFundationAddiction)
@end

@interface NSLayoutConstraint(ZTFundationAddiction)
+(NSArray*)vsfm:(NSString*)vsfm opt:(NSLayoutFormatOptions)opt mts:(NSDictionary*)mts vs:(NSDictionary*)vs;
@end


@interface NSString(ZTFundationAddiction)
#pragma mark - Attribute String
-(NSMutableAttributedString*)addStriket;
#pragma mark - string control
-(NSString*)reverseString;
-(NSString*)md5;
+(NSString*)stringURLWithAppendex:(NSString*)appendString;
@end

@interface NSDictionary(ZTFundationAddiction)
-(NSData*)assembleHttpParamsData;
-(id)jsonParseWithType:(Class)clazz;
-(NSDictionary*)jsonParseToDictionaryWithType:(Class)clazz;
@end

@interface NSArray(ZTFundationAddiction)
-(NSArray*)jsonParseToArrayWithType:(Class)clazz;
@end

#pragma INLINE FUNCTIONS
// size && position
extern long screenWidth();
extern long screenHeight();
extern CGSize screenSize();

//extern void sizeFitAll(NSArray *viewArray);
extern void alertShow(NSObject* content);

extern void initViewProperties(Class clazz);

extern const char* getFileName();






