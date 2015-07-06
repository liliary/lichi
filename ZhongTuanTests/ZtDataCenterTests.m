//
//  ZtDataCenterTests.m
//  ZhongTuan
//
//  Created by anddward on 15/1/9.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ZTDataCenter.h"
#import "Constant.h"
#import "ZTFundationAddiction.h"
#import "User.h"
#import "TeamBuyProduct.h"
#import "TestObject.h"
@interface ZTDataCenter()
-(void)saveToDisk;
-(void)initFromDisk;
@end

@interface ZtDataCenterTests : XCTestCase{
    ZTDataCenter* _dataCenter;
    NSDictionary* _userInfomation;
    NSString* _userToken;
    NSString* _userPhone;
    User *_user;
}

@end

@implementation ZtDataCenterTests

- (void)setUp {
    [super setUp];
    _dataCenter = [ZTDataCenter sharedInstance];
    _userToken = @"9b731d14f32f659e44075b37da8bce7f";
    _userPhone = @"13620901006";
    _userInfomation = @{
                     @"acctoken":@"9b731d14f32f659e44075b37da8bce7f",
                     @"avatar" : @"http://appimg.teambuy.com.cn/upload/2014/12/24/www_101823_rhp7aNp1.png",
                     @"birthday" : @"1994-01-21 00:00:00",
                     @"email" : @"asd@fg.hb",
                     @"handpwd" : @"",
                     @"lastdate" : @"2015-01-14 14:05:33",
                     @"lastip" : @"113.65.191.156",
                     @"mobile" : @"13620901006",
                     @"nickname" : @"泽华",
                     @"regdate" : @"2014-11-13 09:33:38",
                     @"regip" : @"113.65.191.145",
                     @"sex" : @"0",
                     @"signate" : @"fghjjk",
                     @"uid" : @"127",
                     @"userlb" : @"9",
                     @"userpwd" : @"df80c8ea702c75bc01258437e3110515",
                     };
    _user = [_userInfomation jsonParseWithType:[User class]];
    XCTAssertNotNil(_dataCenter,@"dataCenter nil");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _userPhone = nil;
    _userToken = nil;
    _userInfomation = nil;
    _dataCenter = nil;
}

#pragma mark - function: login user

- (void)testShareInstanceMethod{
    ZTDataCenter *anotherDataCenter = [ZTDataCenter sharedInstance];
    XCTAssertEqualObjects(anotherDataCenter, _dataCenter,@"object from sharedInstance method is not equal");
}

- (void)testUserLoginSaveUserDataToCache{
    [_dataCenter loginUser:_user];
    User *userInfo = [_dataCenter getUserWithToken:_userToken];
    XCTAssertEqualObjects(_user, userInfo,@"retrieve data not equal to input data");
}

-(void)testUserLoginSaveUserTokenToUserDefault{
    [_dataCenter loginUser:_user];
    NSString *currentUserToken = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    XCTAssertEqualObjects(_userToken, currentUserToken,"user token has not been saved in UserDefaults");
}

-(void)testUserLoginSaveUserPhoneToUserDefault{
    [_dataCenter loginUser:_user];
    NSString *currentUserPhoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_PHONE];
    XCTAssertEqualObjects(_userPhone, currentUserPhoneNumber,"user phonenumber has not been saved in UserDefaults");
}

- (void)testGetUsetWthTokenResultNotNil{
    [_dataCenter loginUser:_user];
    User *userInfo = [_dataCenter getUserWithToken:_userToken];
    XCTAssertNotNil(userInfo,"result from @sel(getUserWithToken) is nil");
}

-(void)testLogoutUser{
    [_dataCenter logoutUser:nil];
    NSString *currentUserToken = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    XCTAssertNil(currentUserToken);
}

-(void)testProductArraySave{
    NSArray *products = @[
        [[TeamBuyProduct new] initWithDic:@{
            @"bests":@"0",
            @"collects":@"0",
            @"cpdl":@"1",
            @"cpgg":@"元",
            @"mid":@"0",
            @"shopid":@"13",
        }],
        [[TeamBuyProduct new] initWithDic:@{
            @"bests":@"0",
            @"collects":@"0",
            @"cpdl":@"1",
            @"cpgg":@"元",
            @"mid":@"1",
            @"shopid":@"13",
        }],
    ];
    [_dataCenter saveProducts:products forType:CKEY_TEAMBUY];
    TeamBuyProduct *p = [_dataCenter getProductWithPid:@1 forType:CKEY_TEAMBUY];
    TeamBuyProduct *tmp = [[TeamBuyProduct alloc] initWithDic:@{
            @"bests":@"0",
            @"collects":@"0",
            @"cpdl":@"1",
            @"cpgg":@"元",
            @"mid":@"1",
            @"shopid":@"13",
    }];
    XCTAssertEqualObjects(p, tmp);
}

-(void)testDataCenterWriteToDic{
    // TODO: cacheFile name write to define
    NSFileManager *fmg = [NSFileManager defaultManager];
    NSURL *url = [fmg URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *cacheFile = [url URLByAppendingPathComponent:@"ZTCache"];
    if ([fmg fileExistsAtPath:[cacheFile path]]) {
        [fmg removeItemAtURL:cacheFile error:nil];
    }
    [_dataCenter saveToDisk];
    XCTAssertTrue([fmg fileExistsAtPath:[cacheFile path]]);
}

-(void)testDataCenterInitFromDisk{
    NSFileManager *fmg = [NSFileManager defaultManager];
    NSURL *url = [fmg URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *cacheFile = [url URLByAppendingPathComponent:@"ZTCache"];
    [_dataCenter loginUser:_user];
    [_dataCenter saveToDisk];
    XCTAssertTrue([fmg fileExistsAtPath:[cacheFile path]]);
    NSMutableDictionary *cache = [_dataCenter valueForKey:@"_cache"];
    XCTAssertTrue([cache count] != 0);
    [cache removeAllObjects];
    [_dataCenter initFromDisk];
    NSMutableDictionary *cache2 = [_dataCenter valueForKey:@"_cache"];
    XCTAssertTrue([cache2 count] != 0);
    return;
}

-(void)testGetProducts{
    NSMutableArray *products = [NSMutableArray new];
    for (NSInteger i=0; i<10 ; i++) {
        TeamBuyProduct *p = [[TeamBuyProduct alloc] initWithDic:@{@"mid":[NSString stringWithFormat:@"%ld",(long)i]}];
        [products addObject:p];
    }
    [_dataCenter saveProducts:products forType:CKEY_TEAMBUY];
    NSArray *result = [_dataCenter getProductsFromPage:1 pageSize:10 offSet:0 count:6 orderBy:@"mid" asic:YES type:CKEY_TEAMBUY];
    NSArray *sortArray = [products sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        TeamBuyProduct *t1 = (TeamBuyProduct*)obj1;
        TeamBuyProduct *t2 = (TeamBuyProduct*)obj2;
        if (t1.mid > t2.mid) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    sortArray = [sortArray objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 6)]];
    XCTAssertEqualObjects(sortArray, result);
}

#pragma mark - offical test


-(void)testDictionarySortByAttribute{
    NSMutableDictionary *m = [NSMutableDictionary new];
    for (NSInteger i=0; i<10 ; i++) {
        TestObject *obj = [TestObject new];
        obj.s1 = [NSString stringWithFormat:@"%ld tt",i];
        [m setObject:obj forKey:[NSString stringWithFormat:@"%ldObj",i]];
    }
    NSURL *mStore = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:[NSURL URLWithString:@"ddd"] create:NO error:nil];
    NSURL *url = [mStore URLByAppendingPathComponent:@"ddd"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
    }
    [NSKeyedArchiver archiveRootObject:m toFile:[url path]];
    BOOL yes = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    XCTAssertTrue(yes);
}

-(void)testWriteDictionaryToDic{
    NSDictionary *testDic = @{@"test1":@"t1",@"test2":@"t2"};
    NSURL *cachePath = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *fileUrl = [cachePath URLByAppendingPathComponent:@"testDic"];
    [testDic writeToFile:[fileUrl path] atomically:YES];
}

-(void)testGetProvinceList{
    NSArray *array = [[ZTDataCenter sharedInstance] getProvinceList];
    XCTAssertTrue(array.count != 0);
}

@end
