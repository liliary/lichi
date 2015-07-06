//
//  ZTInputBoxTest.m
//  ZhongTuan
//
//  Created by anddward on 15/1/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ZTInputBox.h"
@interface ZTInputBox()
-(BOOL)verification:(NSString*)str withPatten:(NSString*)pat;
@end

@interface ZTInputBoxTest : XCTestCase{
    ZTInputBox *_inputBox;
}
@end

@implementation ZTInputBoxTest

- (void)setUp {
    [super setUp];
    _inputBox = [ZTInputBox new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testPhoneNumberVerification{
    BOOL result1 = [_inputBox verification:@"13620901006" withPatten:@"^[1][3587]\\d{9}$"];
    XCTAssertTrue(result1);
    BOOL result2 = [_inputBox verification:@"60010902631" withPatten:@"^[1][3587]\\d{9}$"];
    XCTAssertFalse(result2);
    BOOL result3 = [_inputBox verification:@"13500" withPatten:@"^[1][3587]\\d{9}$"];
    XCTAssertFalse(result3);
    BOOL result4 = [_inputBox verification:@"1362090100666" withPatten:@"^[1][3587]\\d{9}$"];
    XCTAssertFalse(result4);
    BOOL result5 = [_inputBox verification:@"" withPatten:@"^[1][3587]\\d{9}$"];
    XCTAssertFalse(result5);
}


/// study
-(void)testReqularExpression{
    NSString *patten = @"^\\d{9}[3587][1]$";
    NSString *str = @"";
    NSRange range = NSMakeRange(0, str.length);
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    NSTextCheckingResult *ckr = [reg firstMatchInString:str options:0 range:range];
    NSString *resultString = [str substringWithRange:[ckr range]];
    XCTAssertEqualObjects(str, resultString);
}

@end
