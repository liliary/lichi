//
//  AlterPaswViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "AlterPaswViewController.h"
#import "ZTSessionTitle.h"
#import "ZTTitleLabel.h"
#import "ZTInputBox.h"
#import "ZTCoverView.h"
#import "ZTRoundButton.h"

@interface AlterPaswViewController()<NetResultProtocol>{
    ZTSessionTitle *_greetingMsg;
    ZTTitleLabel *_titleView;
    UIView *_topLayout;
    ZTInputBox *_newpasw;
    ZTInputBox *_repasw;
    ZTInputBox *_yzm;
    ZTRoundButton *_getYzmBtn;
    ZTRoundButton *_submitBtn;
}
@end

@implementation AlterPaswViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTitleBar];
    [self buildViews];
}

#pragma mark - buildViews

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"修改密码"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

-(void)buildViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    
    _greetingMsg = [[ZTSessionTitle alloc] initWithTitle:@"请设置你的新密码"];
    _greetingMsg.topBorder = YES;
    _greetingMsg.bottomBorder = YES;
    _greetingMsg.borderWidth = 1.0;
    _greetingMsg.titleInsets = UIEdgeInsetsMake(0, 12.0, 0, 12.0);
    _greetingMsg.backgroundColor = [UIColor whiteColor];
    
    _newpasw = [ZTInputBox new];
    _newpasw.leftPadding = @30.0;
    _newpasw.textField.placeholder = @"请输入新的密码";
    _newpasw.textField.font = [UIFont systemFontOfSize:11.0];
    _newpasw.textField.textColor = [UIColor colorWithHex:0x656565];
    _newpasw.textField.keyboardType = UIKeyboardTypeDefault;
    _newpasw.bottomBorder = YES;
    _newpasw.borderWidth = 1.0;
    _newpasw.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    
    _repasw = [ZTInputBox new];
    _repasw.leftPadding = @30.0;
    _repasw.textField.placeholder = @"请再次输入你的密码";
    _repasw.textField.font = [UIFont systemFontOfSize:11.0];
    _repasw.textField.textColor = [UIColor colorWithHex:0x656565];
    _repasw.textField.keyboardType = UIKeyboardTypeDefault;
    _repasw.bottomBorder = YES;
    _repasw.borderWidth = 1.0;
    _repasw.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    
    _yzm = [ZTInputBox new];
    _yzm.leftPadding = @30.0;
    _yzm.textField.placeholder = @"验证码";
    _yzm.textField.textColor = [UIColor colorWithHex:0x656565];
    _yzm.textField.font = [UIFont systemFontOfSize:11.0];
    _yzm.textField.keyboardType = UIKeyboardTypeDefault;
    _yzm.bottomBorder = YES;
    _yzm.borderWidth = 1.0;
    _yzm.textFieldLimitation = @{REG_YZM:VER_YZM};
    
    _getYzmBtn = [[ZTRoundButton alloc] initWithTitle:@"点击获取验证码" textcolor:[UIColor blackColor]];
    _getYzmBtn.titleLabel.textColor = [UIColor colorWithHex:0x797979];
    _getYzmBtn.titleLabel.font = [UIFont systemFontOfSize:7.0];
    _getYzmBtn.backgroundColor = [UIColor colorWithHex:0xededed];
    [_getYzmBtn addTarget:self  action:@selector(didTapGetYzmBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _submitBtn = [[ZTRoundButton alloc] initWithTitle:@"提交" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    [_submitBtn addTarget:self action:@selector(didTapSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.view addSubViews:@[_greetingMsg,_newpasw,_repasw,_yzm,_getYzmBtn,_submitBtn]];
}

#pragma mark - onClick Events
-(void)didTapGetYzmBtn:(UIButton*)btn{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETYZM] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];
}

-(void)didTapSubmitBtn:(UIButton*)btn{
    if ([_newpasw validate] && [_repasw validate] && [_yzm validate]) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CHPWD] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
}

#pragma mark - status Events
/**
    设置请求参数
 */
-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETYZM]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_LOGIN_MOBILE:_phoneNum,
                                           }];
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CHPWD]]){
        [params addEntriesFromDictionary:@{
                                           NET_ARG_LOGIN_PHONE:_phoneNum,
                                           NET_ARG_LOGIN_PASW:[self getPswd],
                                           NET_ARG_LOGIN_YZM:[self getYzm]
                                           }];
    }
}
/**
    结果成功
 */
-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    [ZTCoverView dissmiss];
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETYZM]]) {
        alertShow(@"验证码已经发送,请耐心等待");
    }else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CHPWD]]){
        alertShow(@"密码修改成功,请记住新密码");
    }
}
/**
    结果失败
 */
-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    [ZTCoverView dissmiss];
    alertShow(errmsg);
}

#pragma mark - layout views

-(void)viewDidLayoutSubviews{
    [[[[[_greetingMsg fitSize] setScreenWidth] setRectBelowOfView:_topLayout] addRectY:7.5] setRectHeight:39.0];
    [[[[_newpasw fitSize] setScreenWidth] setRectBelowOfView:_greetingMsg] setRectHeight:30.0];
    [[[[_repasw fitSize] setScreenWidth] setRectBelowOfView:_newpasw] setRectHeight:30.0];
    [[[[_yzm fitSize] setScreenWidth] setRectBelowOfView:_repasw] setRectHeight:30.0];
    [[[[_getYzmBtn fitSize] addRectWidth:8.0] setRectMarginRight:15.0] setCenterOfViewVertical:_yzm];
    [[[[[_submitBtn fitSize] setRectWidth:103.0] setRectBelowOfView:_yzm] addRectY:22.0] setRectCenterHorizentail];
}

#pragma mark - helpers
-(NSString*)getPswd{
    NSString* pswd = _newpasw.textField.text;
    return [pswd md5];
}

-(NSString*)getYzm{
    return _yzm.textField.text;
}
@end
