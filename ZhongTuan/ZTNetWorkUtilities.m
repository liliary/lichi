//
//  ZTNetWorkUtilities.m
//  ZhongTuan
//
//  Created by anddward on 14-12-18.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//
// TODO: 发生数据错误时提示不够友好
// TODO: 优化流程,多次对 url 进行转换,性能不高
// TODO: 尽量使用 block 取代 delegate
#import "MeController.h"
#import "ZTNetWorkUtilities.h"
@interface ZTNetWorkUtilities(){
}
@end

@implementation ZTNetWorkUtilities

+(id)sharedInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZTNetWorkUtilities alloc] init];
    });
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        _taskPool = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    return self;
}

#pragma mark - public methods
/**
    使用 post 请求数据
 */
-(void)doPost:(NSString*)stringUrl delegate:(id<NetResultProtocol>)delegate cancelIfExist:(BOOL)cancelAnyway{

    dispatch_queue_t taskToken = dispatch_queue_create([stringUrl UTF8String], NULL);
    dispatch_async(taskToken, ^{
        
        NSMutableURLRequest *req = [self createRequest:stringUrl usePost:YES delegate:delegate];
        NSLog(@"[request]<Headers>:\r\n%@\r\n<requestbody>:%@\r\n",[req allHTTPHeaderFields],[[NSString alloc] initWithData:[req HTTPBody] encoding:NSUTF8StringEncoding]);
        
        [self doRequest:req errorDelegate:delegate cancelIfExist:cancelAnyway result:^(NSData *resultData) {
        
            [self url:stringUrl delegate:delegate JsonDataParse:resultData];
        }];

    });
}

/**
    下载一个文件
 */
-(void)getFile:(NSString *)stringUrl cancelIfExist:(BOOL)cancelIfExist complete:(void(^)(NSString *url,NSData* result))processFile{

    dispatch_queue_t taskToken = dispatch_queue_create([stringUrl UTF8String], NULL);
    dispatch_async(taskToken, ^{
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringUrl]];
        req.HTTPMethod = @"GET";
         NSLog(@"qunma");
               [self doRequest:req errorDelegate:nil cancelIfExist:cancelIfExist result:^(NSData *result){
                  NSLog(@"nima%@",result);
            processFile(stringUrl,result);
           
        }];
    });
}

#pragma mark - json Parse

-(void)url:(NSString*)stringUrl delegate:(id<NetResultProtocol>)delegate JsonDataParse:(NSData*)result{
    // TODO: 异常提示有错误,出现1001等...
    /// data receive success
    
    NSError *jsonParseError = nil;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&jsonParseError];
    if (nil == resultDic) {
        // 外层数据解释失败
        [self request:stringUrl errorToPub:NET_ERR_JSON_PARSE_FAILED errorToLog:[jsonParseError localizedDescription] delegate:delegate];
        return;
    }
    
    NSNumber *retCode = [resultDic objectForKey:NET_KEY_RET];
    switch ([retCode integerValue]) {
            // 访问失败
        case NET_RET_FAILED:{
            NSString *errmsg = resultDic[NET_KEY_DATA][NET_KEY_ERRMSG];
            [self request:stringUrl errorToPub:errmsg errorToLog:errmsg delegate:delegate];
            return;
        }
            // token 超时
        case NET_RET_TOKEN_TIMEOUT:{
            NSString *errmsg = resultDic[NET_KEY_DATA][NET_KEY_ERRMSG];
            NSLog(@"[response]<error>:%@",errmsg);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (delegate) {
                    [[ZTDataCenter sharedInstance] logoutUser:(UIViewController*)delegate];
                }
            });
            return;
        }
            // 访问成功，数据成功返回
        case NET_RET_SUCCESS:{
            id resultData = resultDic[NET_KEY_DATA];
            if ([delegate respondsToSelector:@selector(requestUrl:processResultInBackground:)]) {
                [delegate requestUrl:stringUrl processResultInBackground:resultData];
            }
            NSLog(@"[response]<success>:%@",resultData);
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate requestUrl:stringUrl resultSuccess:resultData];
            });
            return;
        }
        default:
            [self request:stringUrl errorToPub:NET_ERR_JSON_PARSE_FAILED errorToLog:[jsonParseError localizedDescription] delegate:delegate];
            return;
    }
}

#pragma mark - taskPool management
/**
    下载任务入栈,如果 cancelAnyway 为 Yes, 则如果已经存在同个key( 一般使用 url作为 key) 的任务,则前任务会被 cancel
 */
-(void)pushTask:(NSURLSessionTask*)task forkey:(NSString*)key cancelifExist:(BOOL)cancelAnyway{
 
    if (cancelAnyway)[self popTask:key];
    if (nil != task)[_taskPool setObject:task forKey:key];
}

-(void)popTask:(NSString*)key{
    NSURLSessionTask *task = [_taskPool objectForKey:key];
    if (nil != task) {
        [task cancel];
    }
    [_taskPool removeObjectForKey:key];
}

#pragma mark - request construct

-(NSMutableURLRequest*)createRequest:(NSString*)stringUrl usePost:(BOOL)post delegate:(id<NetResultProtocol>)delegate{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringUrl]];
    NSLog(@"  bulid request %@",req);
    if (post) {
        [req setHTTPMethod:@"POST"];
    }else{
        [req setHTTPMethod:@"GET"];
    }
    NSMutableDictionary* params = [NSMutableDictionary new];
    if ([delegate respondsToSelector:@selector(requestUrl:processParamsInBackground:)]) {
    
    
        [delegate requestUrl:stringUrl processParamsInBackground:params];
        NSLog(@" bulid params %@",params);
    }
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    [params setObject:token == nil?@"":token forKey:NET_ARG_LOGIN_TOKEN];
    [req setHTTPBody:[params assembleHttpParamsData]];
    return req;
}

#pragma mark - helpers

-(void)request:(NSString*)stringUrl errorToPub:(NSString*)errPub errorToLog:(NSString*)errPrv delegate:(id<NetResultProtocol>)delegate{
    NSLog(@"[response]<error>:%@",errPrv);
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate requestUrl:stringUrl resultFailed:errPub];
    });
}

-(void)doRequest:(NSURLRequest*)request errorDelegate:(id)delegate cancelIfExist:(BOOL)cancelAnyway result:(void(^)(NSData* resultData))processResult{
  
    // TODO: 移除 delegate 和 cancelanyway
    NSString *stringUrl = [[request URL] absoluteString];

    NSURLSessionTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
       
        // pop task
        [self popTask:stringUrl];
        
        if (nil != error) {             // 访问异常
            [self request:stringUrl errorToPub:[error localizedRecoverySuggestion] errorToLog:[error localizedDescription] delegate:delegate];
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSLog(@"@[response]:%@",[httpResponse allHeaderFields]);
        
        if (nil!=httpResponse && 200!=[httpResponse statusCode]) {
            // 服务器状态异常
            NSString *statusCode = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
            [self request:stringUrl errorToPub:NET_ERR_STATUS_EXEPTION errorToLog:statusCode delegate:delegate];
            return;
        }
        
        NSData *result = [NSData dataWithContentsOfURL:location];
        if ( [result length]<=0 ) {
            // 返回数据为空
            [self request:stringUrl errorToPub:NET_ERR_EMPTY_CONTENT errorToLog:NET_ERR_EMPTY_CONTENT delegate:delegate];
           

            return;
        }
        processResult(result);
    }];
  
    [self pushTask:task forkey:stringUrl cancelifExist:cancelAnyway];
    [task resume];
}



- (void)uploadPhoto:(NSString *)method params:(NSDictionary *)_params serviceName:(NSString *)name NotiName:(NSString *)nName imageD:(NSData *)imageData

{
    
    NSString*nowName = nName;
    
    NSString * url = [NSString stringWithFormat:@"%@%@",@"http://app.teambuy.com.cn/apnc/m/",method];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    //    UIImage * imageToPost = imageWithName(@"beauty.jpg");
    [request setHTTPMethod:@"POST"];
    // 分界线
    NSString *boundary = @"0xKhTmLbOuNdArY";
    //内容格式
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    // add params (all params are strings)
    //  NSDictionary * _params = @{@"imgFile":@"aa.jpg",@"userCode":@"avaname"};
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@",param]dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];}
        // add image data
        //    NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
    if (imageData){
    [body appendData:[[NSString stringWithFormat:@"--%@", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=image.jpg", name] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
            [body appendData:[@"" dataUsingEncoding:NSUTF8StringEncoding]];}
            [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                                                                                                                                                  
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
 // set the content-length
[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
//MeController * myConnection = [[MeController alloc]initWithRequest:request delegate:self];
//myConnection.name = nName;
//[myConnection start];
    
    
[NSURLConnection connectionWithRequest:request delegate:self];
    NSLog(@"keyima");
                                                                                                                                                                  }





@end
