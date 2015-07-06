//
//  AppDelegate.m
//  ZhongTuan
//
//  Created by anddward on 14-11-3.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeTabBarController.h"
#import "LoginViewController.h"
#import "ZTFundationAddiction.h"
#import "GuideViewController.h"
#import <sqlite3.h>
#import "Pingpp.h"
#import "NoPayViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
// TODO: _CACHE WILL SAVE MANY TIMES !!!! check if save aready
// TODO: problem when save to disk


@interface AppDelegate ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKMapManager* _mapManager;
    BMKLocationService* _locService;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//移动分享
[ShareSDK registerApp:@"4b113dd43feb"];


    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"832864675"
                               appSecret:@"bfd71fe0bba45b7ba87a78a784bc04da"
                             redirectUri:@"http://www.sharesdk.cn"];


    [ShareSDK  connectSinaWeiboWithAppKey:@"832864675"
                                appSecret:@"bfd71fe0bba45b7ba87a78a784bc04da"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];



    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801554055"
                                  appSecret:@"a471b1458d3c6e225bbd5ef59e6c5ea3"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1103670935"
                           appSecret:@"EPx4o9qJdXy2S72U"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1103670935"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];


    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx1872d077ceee2249"
                           wechatCls:[WXApi class]];
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx1872d077ceee2249"
                           appSecret:@"8f73e71e0a6a8b910a0314eb1b030dd3"
                           wechatCls:[WXApi class]];

    [ShareSDK connectWeChatWithAppId:@"wx1872d077ceee2249"   //微信APPID
                           appSecret:@"8f73e71e0a6a8b910a0314eb1b030dd3"  //微信APPSecret
                           wechatCls:[WXApi class]];

    [ShareSDK connectQQWithQZoneAppKey:@"1103670935"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"832864675"
                               appSecret:@"bfd71fe0bba45b7ba87a78a784bc04da"
                             redirectUri:@"http://www.sharesdk.cn"];

    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"F3PDLn5Wz9IiTeGSFzWlIMXr" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"baidu Sdk start success!!");
    }
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    self.window = window;
    
    BOOL guide_is_shown = [[NSUserDefaults standardUserDefaults] boolForKey:UD_KEY_GUID_HAD_SHOWN];
    if (!guide_is_shown) {
        GuideViewController *controller = [GuideViewController new];
        //UINavigationController *rootController = [[UINavigationController new] initWithRootViewController:controller];
        window.rootViewController = controller;
        [self appSetting];
        [window makeKeyAndVisible];
    }
    else {
       HomeTabBarController *home = [HomeTabBarController new];
       // UINavigationController *rootController = [[UINavigationController new] initWithRootViewController:home];
        window.rootViewController = home;
        [self appSetting];
        [window makeKeyAndVisible];
    
    
    }
    
    
    
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:500.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self saveCache];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveCache];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveCache];
}

#pragma mark - helper method 
-(void)appSetting{
    ZTDataCenter *dataCenter = [ZTDataCenter sharedInstance];
    [dataCenter initFromDisk];
}

-(void)saveCache{
    ZTDataCenter *dataCenter = [ZTDataCenter sharedInstance];
    sqlite3 *db = [[ZTDataCenter sharedInstance] dataBase];
    if (db != NULL) {
        sqlite3_close(db);
    }
    [dataCenter saveToDisk];
}

#pragma mark - baidu map
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    NSUserDefaults *latlong=[NSUserDefaults standardUserDefaults];

    [latlong setObject:[ NSNumber numberWithFloat:userLocation.location.coordinate.latitude ] forKey:@"lat"];
    [latlong setObject:[NSNumber numberWithFloat: userLocation.location.coordinate.longitude] forKey:@"long"];
    [latlong synchronize];
    BMKGeoCodeSearch *_search = [[BMKGeoCodeSearch alloc] init];
    _search.delegate = self;
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_search reverseGeoCode:option];
    if (flag) {
        NSLog(@"ok");
    }else{
        NSLog(@"fuck");
    }
}

//处理定位失败
-(void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      NSLog(@"**********************************");
      NSLog(@"**********************************");
      NSLog(@"**********************************");

      NSLog(@"%@",result.address);
      NSLog(@"街道号码：%@",result.addressDetail.streetNumber);
      NSLog(@"街道名字：%@",result.addressDetail.streetName);
      NSLog(@"地区：%@",result.addressDetail.district);
      NSLog(@"城市：%@",result.addressDetail.city);
      NSLog(@"省份：%@",result.addressDetail.province);
      
      NSLog(@"**********************************");
      NSLog(@"**********************************");
      NSLog(@"**********************************");
  } else {
      NSLog(@"抱歉，未找到结果");
  }
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
        
        // result : success, fail, cancel, invalid
        NSString *msg;
        if (error == nil) {
            NSLog(@"PingppError is nil");
            msg = result;
            NSLog(@"PingppError: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"jumppage" object:nil userInfo:@{@"where":result}];
        } else {
            NSLog(@"PingppError: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"jumppage" object:nil userInfo:@{@"where":result}];
          
              //  NoPayViewController*Nopayvc=[[NoPayViewController alloc]init];
//                //[self.window.rootViewController presentViewController:Nopayvc animated:YES completion:nil];
//               [self.window.rootViewController.navigationController addChildViewController:Nopayvc];
//               NSLog(@"vcvc%@",self.window.rootViewController.navigationController.viewControllers);
//                [self.window.rootViewController.navigationController popToViewController:Nopayvc animated:YES];
            msg = [NSString stringWithFormat:@"result=%@ PingppError: code=%lu msg=%@", result, (unsigned long)error.code, [error getMsg]];
            NSLog(@"%@",msg);

            NSLog(@"hahahahha");
            
        }
        //alertShow(msg);
        //[(ViewController*)self.viewController.visibleViewController showAlertMessage:msg];
    }];
    
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
    
    return  YES;
}
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
                        
}


@end
