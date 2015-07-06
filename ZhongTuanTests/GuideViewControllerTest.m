//
//  GuideViewControllerTest.m
//  ZhongTuan
//
//  Created by anddward on 15/1/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GuideViewController.h"
#import "Constant.h"

@interface GuideViewController()
-(void)initViews;
-(void)didTapEntryBtn:(UIButton*)btn;
@property (strong,nonatomic) UIButton *entryButton;
@end

@interface GuideViewControllerTest : XCTestCase{
    GuideViewController *_guideController;
    NSUserDefaults *_udf;
    BOOL ud_key_guide_had_shown;
}
@end

@implementation GuideViewControllerTest

- (void)setUp {
    [super setUp];
    _guideController = [GuideViewController new];
    _udf = [NSUserDefaults standardUserDefaults];
    ud_key_guide_had_shown = [_udf boolForKey:UD_KEY_GUID_HAD_SHOWN];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _guideController = nil;
    [_udf setBool:ud_key_guide_had_shown forKey:UD_KEY_GUID_HAD_SHOWN];
}

- (void)testEntryButtonDidChange_HAD_HSOWN_Config{
    [_udf setBool:NO forKey:UD_KEY_GUID_HAD_SHOWN];
    [_guideController didTapEntryBtn:nil];
    
    XCTAssertTrue([_udf boolForKey:UD_KEY_GUID_HAD_SHOWN]);
}

@end
