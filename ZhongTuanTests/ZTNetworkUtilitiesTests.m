//
//  ZTNetworkUtilitiesTests.m
//  ZhongTuan
//
//  Created by anddward on 15/1/9.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ZTNetWorkUtilities.h"
#import <objc/runtime.h>


@interface ZTNetWorkUtilities()
/// ZTNetWorkUtilities private methodds
-(NSMutableURLRequest*)createRequest:(NSString*)stringUrl usePost:(BOOL)post delegate:(id<NetResultProtocol>)delegate;
@end

@interface ZTNetworkUtilitiesTests : XCTestCase<NetResultProtocol>{
    ZTNetWorkUtilities *_netUtilities;
    id<NetResultProtocol> _fakeDelegate;
    NSString *_testUrl;
}

@end

@implementation ZTNetworkUtilitiesTests

- (void)setUp {
    [super setUp];
    _netUtilities = [ZTNetWorkUtilities sharedInstance];
    
    Protocol *ptl = objc_getProtocol("NetResultProtocol");
    Class fakeNetResultClass = objc_allocateClassPair([NSObject class], "FakeNetWorkDelegate", 0);
    class_addProtocol(fakeNetResultClass, ptl);
//    objc_registerClassPair(fakeNetResultClass);
//    _fakeDelegate = [[fakeNetResultClass alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - test singlethen

- (void)testSingleton{
    ZTNetWorkUtilities *anotherInstance = [ZTNetWorkUtilities sharedInstance];
    XCTAssertEqual(anotherInstance, _netUtilities,@"instance should equal under singleton mode");
}

#pragma mark - <NetResultProto
@end
