//
//  ZhungTuanAppDelegateTest.m
//  ZhongTuan
//
//  Created by anddward on 15/1/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Constant.h"

@interface ZhungTuanAppDelegateTest : XCTestCase{
    AppDelegate *_delegate;
    UIApplication *_application;
    UIWindow *_rootWindow;
}

@end

@implementation ZhungTuanAppDelegateTest

#pragma mark - common setUp && tearDown

- (void)setUp {
    [super setUp];
    _application = [UIApplication sharedApplication];
    _delegate = [_application delegate];
    _rootWindow = [_delegate window];
}

- (void)tearDown {
    [super tearDown];
    _application = nil;
    _delegate = nil;
    _rootWindow = nil;
}

- (void)testAppStartUpStartUp{
    [_delegate application:_application didFinishLaunchingWithOptions:nil];
}

- (void)testAppStartUpTearDown{
    
}

#pragma mark - Test App Start Up

- (void) testDelegateWindowNotNull{
    [self testAppStartUpStartUp];
    XCTAssertNotNil(_rootWindow,@"Error: Root Window is nil");
    [self testAppStartUpTearDown];
}

- (void) testDelegateRootViewControllerNotNull{
    [self testAppStartUpStartUp];
    XCTAssertNotNil([_rootWindow rootViewController],@"Error: Root ViewController is nil");
    [self testAppStartUpTearDown];
}

- (void) testRootViewControllerIsUINavigationController{
    [self testAppStartUpStartUp];
    Class clazz = [UINavigationController class];
    id rootViewController = [_rootWindow rootViewController];
    XCTAssertTrue([rootViewController isMemberOfClass:clazz],@"Error: Root ViewController is not a kind of UINavigationController");
    [self testAppStartUpTearDown];
}

- (void) testRootViewControllerFirstChildIsLoginViewController{
    [self testAppStartUpStartUp];
    Class clazz = [LoginViewController class];
    id firstController = [[(UINavigationController*)[_rootWindow rootViewController] viewControllers] objectAtIndex:0];
    XCTAssertTrue([firstController isMemberOfClass:clazz],@"Error: RootViewController's root Controller is not LoginController");
    [self testAppStartUpTearDown];
}

@end
