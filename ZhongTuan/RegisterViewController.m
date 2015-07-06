//
//  RegisterViewController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-6.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
// TODO: 添加点击其他地方收起键盘

#import "RegisterViewController.h"
#import "NearController.h"
#import "ZTInputBox.h"
#import "HomeTabBarController.h"
#import "ZTRoundButton.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
#import "User.h"
#import "MeController.h"

@interface RegisterViewController()<NetResultProtocol>{
    UIView *_topLayout;
    ZTInputBox *_phoneInput;
    ZTInputBox *_paswInput;
    ZTInputBox *_repaswInput;
    ZTInputBox *_yzm;
    UIButton *_getYzmBtn;
    ZTRoundButton *_registerBtn;
    
}

@end

@implementation RegisterViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initNavigationBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidLayoutSubviews{
    [[[[_phoneInput fitSize]
    setScreenWidth]
    setRectHeight:40.0]
    setRectBelowOfView:_topLayout];
    
    [[[[[_paswInput fitSize]
    setScreenWidth]
    setRectHeight:40.0]
    setRectBelowOfView:_phoneInput]
    addRectY:1.5];
    
    [[[[[_repaswInput fitSize]
    setScreenWidth]
    setRectHeight:40.0]
    setRectBelowOfView:_paswInput]
    addRectY:1.5];
    
    [[[[[_yzm fitSize]
    setScreenWidth]
    setRectHeight:40.0]
    setRectBelowOfView:_repaswInput]
    addRectY:1.5];
    
//    [[[[_getYzmBtn fitSize]
//    setRectMarginRight:15.0]
//    setRectBelowOfView:_yzm]
//    addRectY:16.0];


    [[_getYzmBtn fitSize]
           setRectMarginRight:15.0];
     [_yzm addSubview:_getYzmBtn];
     
    [[[[[_registerBtn fitSize]
    setRectMarginLeft:15.0]
    widthToEndWithPadding:15.0]
    setRectBelowOfView:_yzm]
    addRectY:15.0];
}

#pragma mark - build Views

-(void)initNavigationBar{
    // TODO:learn about titleTextAttributes and move to global setting
    ZTTitleLabel* titleView = [[ZTTitleLabel alloc] initWithTitle:@"注册"];
    [titleView fitSize];
    self.navigationItem.titleView = titleView;
}

-(void)buildViews{
    self.view.backgroundColor = [UIColor whiteColor];
    _topLayout = (UIView*)self.topLayoutGuide;
    // TODO: 去掉空格调整,实现两端对齐.
    // TODO: 套用 scrollview
    // TODO: 点击空域收起键盘
    
    /// phone input box
    _phoneInput = [ZTInputBox new];
    _phoneInput.leftPadding = @15;
    _phoneInput.rightPadding = @15;
    _phoneInput.borderWidth = 0.5;
    _phoneInput.bottomBorder = YES;
    _phoneInput.textFieldLimitation = @{REG_PHONE:VER_PHONE};
    _phoneInput.textLabel.font = [UIFont systemFontOfSize:16.0];
    _phoneInput.textLabel.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    _phoneInput.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneInput setTextLabel:@"手       机" withSeparator:@":"];
    
    /// password input box
    _paswInput = [ZTInputBox new];
    _paswInput.leftPadding = @15;
    _paswInput.rightPadding = @15;
    _paswInput.borderWidth = 0.5;
    _paswInput.bottomBorder = YES;
    _paswInput.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    _paswInput.textLabel.font = [UIFont systemFontOfSize:16.0];
    _paswInput.textLabel.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    [_paswInput setTextLabel:@"密       码" withSeparator:@":"];
    
    /// repeat password input box
    _repaswInput = [ZTInputBox new];
    _repaswInput.leftPadding = @15;
    _repaswInput.rightPadding = @15;
    _repaswInput.borderWidth = 0.5;
    _repaswInput.bottomBorder = YES;
    _repaswInput.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    _repaswInput.textLabel.font = [UIFont systemFontOfSize:16.0];
    _repaswInput.textLabel.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    [_repaswInput setTextLabel:@"重复密码" withSeparator:@":"];
    
    _yzm = [ZTInputBox new];
    _yzm.leftPadding = @15;
    _yzm.rightPadding = @15;
    _yzm.borderWidth = 0.5;
    _yzm.bottomBorder = YES;
    _yzm.textFieldLimitation = @{REG_YZM:VER_YZM};
    [_yzm setTextLabel:@"验证码" withSeparator:@":"];
    
    _getYzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getYzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getYzmBtn setTitleColor:[UIColor colorWithHex:0x7ac94e] forState:UIControlStateNormal];
    _getYzmBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_getYzmBtn addTarget:self action:@selector(didTapGetYzmBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _registerBtn = [[ZTRoundButton alloc] initWithTitle:@"注册" textcolor:[UIColor whiteColor]
                                           backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    [_registerBtn addTarget:self action:@selector(didTapRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubViews:@[_phoneInput,_paswInput,_repaswInput,_yzm,_getYzmBtn,_registerBtn]];
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - OnClick Events

-(void)didTapRegisterBtn:(UIButton*)btn{
    [self resignInput];
    if ([_phoneInput validate]) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CHECKUSER] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
}

-(void)didTapGetYzmBtn:(UIButton*)btn{
    [self resignInput];
    if ( [_phoneInput validate]){
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETYZM] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
}

#pragma mark - net result delegate
-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETYZM]]) {
        [params addEntriesFromDictionary:@{NET_ARG_LOGIN_MOBILE:[self getPhone]}];
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_REGISTER]]){
        [params addEntriesFromDictionary:@{
                                           NET_ARG_LOGIN_PHONE:[self getPhone],
                                           NET_ARG_LOGIN_PASW:[self getPassword],
                                           NET_ARG_LOGIN_YZM:[self getYzm],
                                           }];
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CHECKUSER]]){
        [params addEntriesFromDictionary:@{NET_ARG_LOGIN_PHONE:[self getPhone]}];
    }
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_REGISTER]]){
        NSDictionary *dataDic = (NSDictionary*)result;
        User *loginUser = [dataDic jsonParseWithType:[User class]];
        ZTDataCenter *dataCenter = [ZTDataCenter sharedInstance];
        [dataCenter loginUser:loginUser];
    }
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    alertShow(errmsg);
    [ZTCoverView dissmiss];
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETYZM]]) {
        alertShow(@"验证码已发送,请耐心等待");
        [ZTCoverView dissmiss];
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CHECKUSER]]){
        if ([_paswInput validate] && [_repaswInput validate] && [_yzm validate]) {
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_REGISTER] delegate:self cancelIfExist:YES];
        }else{
            [ZTCoverView dissmiss];
        }
        
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_REGISTER]]){
        [ZTCoverView dissmiss];
        if ([self.tttag isEqualToString:@"me"]) {
//            [self.navigationController presentViewController:[MeController new] animated:YES completion:^{
//                [self.navigationController popViewControllerAnimated:NO];
//            }];


[self .navigationController popToRootViewControllerAnimated:YES];
//[self.navigationController pushViewController:[[MeController alloc]init] animated:YES];
        }
        if ([self.tttag isEqualToString:@"sale"]) {
            [self .navigationController popToRootViewControllerAnimated:YES];
        }
        
     alertShow(@"注册成功，请继续下一步操作");
    }
   
}

#pragma mark - helpers

-(NSString*)getPhone{
    NSString *phoneNumber = _phoneInput.textField.text;
    return [phoneNumber reverseString];
}

-(NSString*)getPassword{
    NSString *password = _paswInput.textField.text;
    return [password md5];
}

-(NSString*)getYzm{
    return _yzm.textField.text;
}

-(void)resignInput{
    NSArray *inputs = @[_phoneInput,_paswInput,_repaswInput,_yzm];
    for (ZTInputBox *input in inputs) {
        [input resignFirstResponder];
    }
}

@end
