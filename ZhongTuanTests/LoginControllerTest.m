//
//  LoginControllerTest.m
//  ZhongTuan
//
//  Created by anddward on 15/1/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginViewController.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "GuideViewController.h"
#import "ZTInputBox.h"
#import "HomeTabBarController.h"

#pragma mark - private Categories
@interface LoginViewController(){
}
-(void)dispatchLogin;
-(void)initPhoneNumberPlaceHolder;
@end

@interface LoginControllerTest : XCTestCase{
    UIWindow *_window;
    UINavigationController *_controller;
    LoginViewController *_loginViewController;
    
    NSUserDefaults *_udf;
    BOOL ud_key_guide_had_shown;
    NSString *ud_key_current_token;
    NSString *ud_key_current_phone;
}

@end

@implementation LoginControllerTest

- (void)setUp {
    [super setUp];
    _window = [UIWindow new];
    _loginViewController = [LoginViewController new];
    _controller = [[UINavigationController alloc] initWithRootViewController:_loginViewController];
    _window.rootViewController = _controller;
    [_window makeKeyAndVisible];
    
    _udf = [NSUserDefaults standardUserDefaults];
    ud_key_guide_had_shown = [_udf boolForKey:UD_KEY_GUID_HAD_SHOWN];
    ud_key_current_token = [_udf objectForKey:UD_KEY_CURRENT_TOKEN];
    ud_key_current_phone = [_udf objectForKey:UD_KEY_CURRENT_PHONE];
}

- (void)tearDown {
    [super tearDown];
    _controller = nil;
    _loginViewController = nil;
    _window = nil;
    
    [_udf setBool:ud_key_guide_had_shown forKey:UD_KEY_GUID_HAD_SHOWN];
    [_udf setObject:ud_key_current_token forKey:UD_KEY_CURRENT_TOKEN];
    [_udf setObject:ud_key_current_phone forKey:UD_KEY_CURRENT_PHONE];
}

#pragma mark - startup Test
/**
 *  Should show Guide View if "GUIDE_HAD_SHOWN" is NO
 */
- (void) testShowViewGuideIfNeed{
    _loginViewController.DEBUG_GUIDE = NO;
    [_udf setBool:NO forKey:UD_KEY_GUID_HAD_SHOWN];
    
    [_loginViewController dispatchLogin];
    
    id presentedViewController = [[_loginViewController navigationController] presentedViewController];
    XCTAssertTrue([presentedViewController isMemberOfClass:[GuideViewController class]],@"Error: should presented by GuideView");
}

/**
 *  Should show HomeView if "GUIDE_HAD_SHOWN" is YES && user's token is not nil
 */
- (void) testAutoLogin{

    [_udf setBool:YES forKey:UD_KEY_GUID_HAD_SHOWN];
    [_udf setValue:@"qwertyuiop" forKey:UD_KEY_CURRENT_TOKEN];
    
    [_loginViewController dispatchLogin];
    
    id presentedViewController = [[_loginViewController navigationController] presentedViewController];
    
    XCTAssertTrue([presentedViewController isMemberOfClass:[HomeTabBarController class]],@"Error: should presented by HomeViewController");
}

/**
 *  Should show LoginPage When user's token is nil
 */
- (void) testNotOtherPrestedViewControllerWhileLogin{

    [_udf setBool:YES forKey:UD_KEY_GUID_HAD_SHOWN];
    [_udf setObject:nil forKey:UD_KEY_CURRENT_TOKEN];
    
    [_loginViewController dispatchLogin];
    id presentedViewController = [[_loginViewController navigationController] presentedViewController];
    
    XCTAssertNil(presentedViewController,@"Error:while need login,should not presented any other viewController ");

}

#pragma mark - Layout

/**
 *  first time login,no phone number remember
 */
- (void) testNoPhoneRememberWhenUserFirstTimeLogin{


}

/**
 *  not first time login,phone inputFiled should show user's phoneNumber
 */
- (void)testShouldShowPhoneNumberWhenUserLoginNextTime{

    
}

@end


