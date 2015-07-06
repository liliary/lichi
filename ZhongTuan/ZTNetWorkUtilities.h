//
//  NetWorkUtilities.h
//  ZhongTuan
//
//  Created by anddward on 14-12-18.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetResultProtocol <NSObject>
@optional
-(void)requestUrl:(NSString*)request resultSuccess:(id)result;
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg;
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params;
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result;
@end

@interface ZTNetWorkUtilities : NSObject<NSURLSessionDelegate>

@property (nonatomic,strong) NSMutableDictionary* taskPool;

+(id)sharedInstance;

-(void)doPost:(NSString*)stringUrl delegate:(id<NetResultProtocol>)delegate cancelIfExist:(BOOL)cancelAnyway;
-(void)getFile:(NSString*)stringUrl cancelIfExist:(BOOL)cancelIfExist complete:(void(^)(NSString *url,NSData* data))processFile;
-(void)popTask:(NSString*)key;
- (void)uploadPhoto:(NSString *)method params:(NSDictionary *)_params serviceName:(NSString *)name NotiName:(NSString *)nName imageD:(NSData *)imageData;

@end
