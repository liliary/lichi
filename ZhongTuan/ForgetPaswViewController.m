//
//  ForgetPaswViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/1/10.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// TODO: 添加点击其他地方收起键盘

#import "ForgetPaswViewController.h"
#import "ZTInputBox.h"
#import "UpdatePaswdViewController.h"
#import "ZTRoundButton.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
#import "AlterPaswViewController.h"

@interface ForgetPaswViewController ()<NetResultProtocol>{
    ZTInputBox *_phoneInput;
    ZTRoundButton *_nextBtn;
    UIView *_topLayout;
}

@end

@implementation ForgetPaswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidLayoutSubviews{
    [[[[_phoneInput fitSize]
    setScreenWidth]
    setRectHeight:45.0]
    setRectBelowOfView:_topLayout];
    
    [[[[[_nextBtn fitSize]
    setRectMarginLeft:15.0]
    widthToEndWithPadding:15.0]
    setRectBelowOfView:_phoneInput]
    addRectY:30.0+1.0];
    
    
}

#pragma mark - buildViews
-(void)initTitleBar{
    ZTTitleLabel* titleView = [[ZTTitleLabel alloc] initWithTitle:@"找回密码"];
    [titleView fitSize];
    self.navigationItem.titleView = titleView;
}

-(void)buildViews{
    self.view.backgroundColor = [UIColor whiteColor];
    _topLayout = (UIView*)self.topLayoutGuide;
    
    /// phone input box
    _phoneInput = [ZTInputBox new];
    _phoneInput.leftPadding = @15;
    _phoneInput.rightPadding = @15;
    _phoneInput.bottomBorder = YES;
    _phoneInput.borderWidth = 1.0;
    _phoneInput.textFieldLimitation = @{REG_PHONE:VER_PHONE};
    _phoneInput.textLabel.font = [UIFont systemFontOfSize:16.0];
    _phoneInput.textLabel.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    _phoneInput.textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneInput.textField.placeholder = @"请输入你的手机号码";
    
    /// nextBtn
    _nextBtn = [[ZTRoundButton alloc] initWithTitle:@"下一步" textcolor:[UIColor whiteColor]];
    _nextBtn.backgroundColor = [UIColor redColor];
    [_nextBtn addTarget:self action:@selector(didTapNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubViews:@[_phoneInput,_nextBtn]];
}

#pragma mark - status Events
/**
    参数设置
 */
-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    [params addEntriesFromDictionary:@{
                                       NET_ARG_LOGIN_PHONE:[self getPhoneNum],
                                       }];
}

/**
    失败结果
 */
-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    [ZTCoverView dissmiss];
    AlterPaswViewController *con = [AlterPaswViewController new];
    con.phoneNum = [self getPhoneNum];
    [self.navigationController pushViewController:con animated:YES];
}

/**
    成功结果
 */
-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    [ZTCoverView dissmiss];
    alertShow(@"用户不存在");
}

#pragma mark - OnClick Events
-(void)didTapNextBtn:(UIButton*)btn{
    if ([_phoneInput validate]) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CHECKUSER] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
}

#pragma mark - helpers
-(NSString*)getPhoneNum{
    NSString *phoneNum = _phoneInput.textField.text;
    return [phoneNum reverseString];
}

@end
