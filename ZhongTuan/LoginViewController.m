//
//  LoginViewController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-6.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeTabBarController.h"
#import "ZTInputBox.h"
#import "ZTDropDownSelected.h"
#import "ZTIconButton.h"
#import "User.h"
#import "AppDelegate.h"
#import "ForgetPaswViewController.h"
#import "ZTNetWorkUtilities.h"
#import "ZTDataCenter.h"
#import "GuideViewController.h"
#import "TestViewController.h"
#import "ZTRoundButton.h"
#import "ZTCoverView.h"
#import "MeController.h"

@interface LoginViewController()<NetResultProtocol>
@end

@implementation LoginViewController{
    UIImageView *_coverView;
    UIScrollView *_sv;
    UIImageView *_topBanner;
   // UIView*_topBanner;
    ZTInputBox *_phoneInput;
    ZTInputBox *_paswInput;
    ZTRoundButton *_loginButton;
    ZTRoundButton *_registerButton;
    UIButton *_forgetButton;
    UIView*top;
   UILabel*label;
    ZTNetWorkUtilities *_server;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    /* FOR DEBUG */
    _DEBUG_GUIDE = NO;
    _DEBUG_PAGE = NO;
    /* DEBUG END */
    [self initTitleBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self initPhoneNumberPlaceHolder];
    [self registerKeyBoardEvent];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self dispatchLogin];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    
    [self unRegisterKeyBoardEvent];
    [_server popTask:[NSString stringURLWithAppendex:NET_API_LOGIN]];
}

-(void)viewDidLayoutSubviews{
    [_sv setRectScreen];
    [[[top fitSize]setScreenWidth]setRectHeight:56];
     [[[label fitSize]setRectCenterInParent]addRectY:7.0];
   // [[[_topBanner fitSize]setRectBelowOfView:top]setRectHeight:80];
     [[_topBanner fitSize]setRectBelowOfView:top];

    [[[_phoneInput
    setScreenWidth]
    setRectHeight:45.0]
    setRectBelowOfView:_topBanner];
    
    [[[[_paswInput
    setScreenWidth]
    setRectHeight:45.0]
    setRectBelowOfView:_phoneInput]
    addRectY:1.0];
    
    [[[[[_loginButton fitSize]
    setRectMarginLeft:15.0]
    widthToEndWithPadding:15.0]
    setRectBelowOfView:_paswInput]
    addRectY:20.0];
    
    [[[[_registerButton fitSize]
    setRectMarginLeft:15.0]
    setRectWidth:94.5]
    setRectMarginBottom:15.0];
    
    [[[_forgetButton fitSize]
    setRectMarginRight:15.0]
    setRectMarginBottom:15.0];
    
    [_sv setContentSize:[_sv fillSize]];
    
    [[_coverView setScreenWidth] setScreenHeight];
}


#pragma mark - Build Views

-(void)initTitleBar{


    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.topItem.title = @"返回";
  }
/**
    组装view
 */
-(void)buildViews{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    /// build scroll view
    _sv = [UIScrollView new];
    _sv.bounces = NO;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapNonInput:)];
    [self.view addGestureRecognizer:tapGeture];
    
    //// build top banner
    top=[[UIView alloc]init];
    UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 40, 40)];
   label=[[UILabel alloc]init];
    label.text=@"登陆";
   [bt setImage:[UIImage imageNamed:@"backlogin"] forState:UIControlStateNormal];
    [top addSubViews:@[bt,label]];
    //layout
    [bt addTarget:self action:@selector(backrefresh:) forControlEvents:UIControlEventTouchUpInside ];
    
    _topBanner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    //_topBanner=[[UIView alloc]init];
   _topBanner.userInteractionEnabled=YES;

    
    //// build name_input
    _phoneInput = [ZTInputBox new];
    _phoneInput.leftPadding = @35;
    _phoneInput.rightPadding = @35;
    _phoneInput.bottomBorder = YES;
    _phoneInput.borderWidth = 0.5;
    _phoneInput.textFieldLimitation = @{REG_PHONE:VER_PHONE};
    _phoneInput.textField.placeholder = PH_PHONE;
    _phoneInput.textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneInput.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneInput.textField.font = [UIFont systemFontOfSize:16.0];
    _phoneInput.textField.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    [_phoneInput setImageLabel:[UIImage imageNamed:@"lab_user"] withSeparator:[UIImage imageNamed:@"lab_separator"]];
    
    //// build password_input
    _paswInput = [ZTInputBox new];
    _paswInput.leftPadding = @35;
    _paswInput.rightPadding = @35;
    _paswInput.bottomBorder = YES;
    _paswInput.borderWidth = 0.5;
    _paswInput.textFieldLimitation = @{REG_PASW:VER_PASSWORD};
    _paswInput.textField.placeholder = PH_PSWD;
    _paswInput.textField.secureTextEntry = YES;
    _paswInput.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _paswInput.textField.font = [UIFont systemFontOfSize:16.0];
    _paswInput.textField.textColor = [UIColor colorWithHex:COL_INPUTBOX];
    [_paswInput setImageLabel:[UIImage imageNamed:@"lab_pasw"] withSeparator:[UIImage imageNamed:@"lab_separator"]];
    
    //// build login button
    _loginButton =
    [[ZTRoundButton alloc] initWithTitle:@"登陆"
            textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    [_loginButton addTarget:self action:@selector(didTapLoginButton) forControlEvents:UIControlEventTouchUpInside];

    
    //// build register button
    _registerButton = [[ZTRoundButton alloc] initWithTitle:@"新用户"
            textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    [_registerButton addTarget:self action:@selector(didTapRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    
    //// build forget button
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetButton setTitleColor:[UIColor colorWithHexTransparent:0xff646464] forState:UIControlStateNormal];
    [_forgetButton addTarget:self action:@selector(didTapForgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    _forgetButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    _forgetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //// cover View
    _coverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome"]];

    [_sv addSubViews:@[top,_topBanner,_phoneInput,_paswInput,_registerButton,_loginButton,_forgetButton]];
    [self.view addSubview:_sv];
    [self.view addSubview:_coverView];
}



#pragma mark - On Click Events
-(void)backrefresh:(UIButton*)sender{
NSLog(@"hahahah");
[self dismissViewControllerAnimated:YES completion:nil];

}

-(void)didTapNonInput:(UITapGestureRecognizer*)tapGesture{
    [_phoneInput closeKeyBoard];
    [_paswInput closeKeyBoard];
}

-(void)didTapRegisterButton{
    [self didTapNonInput:nil];
    NSLog(@"newuser");
    RegisterViewController*registervc=[RegisterViewController new];
    
    registervc.tttag=self.ttag;
       [self.navigationController pushViewController:registervc animated:YES];
}

-(void)didTapLoginButton{
    [self didTapNonInput:nil];
    if([_phoneInput validate] && [_paswInput validate]){
        _server = [ZTNetWorkUtilities sharedInstance];
        [_server doPost:[NSString stringURLWithAppendex:NET_API_LOGIN] delegate:self cancelIfExist:YES];
        [ZTCoverView alertCover];
    }
}

-(void)didTapForgetBtn:(UIButton*)button{
    [self didTapNonInput:nil];
    if (_DEBUG_PAGE) {
        [self.navigationController pushViewController:[TestViewController new] animated:NO];
    }else{
        [self.navigationController pushViewController:[ForgetPaswViewController new] animated:YES];
    }
}

-(void)initPhoneNumberPlaceHolder{
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] stringForKey:UD_KEY_CURRENT_PHONE];
    if (nil == phoneNumber) {
        _phoneInput.textField.text = @"";
    }else{
        _phoneInput.textField.text = (NSString*)phoneNumber;
    }
    _paswInput.textField.text = @"";
}

#pragma mark - Status Events

-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
    [params addEntriesFromDictionary:
     @{
       NET_ARG_LOGIN_PHONE:[self getPhone],
       NET_ARG_LOGIN_PASW:[self getPassword],
    }];
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)data{
    NSDictionary *dataDic = (NSDictionary*)data;
    NSLog(@"zidiana%@zidian",dataDic);
    User *loginUser = [dataDic jsonParseWithType:[User class]];
    ZTDataCenter *dataCenter = [ZTDataCenter sharedInstance];
    [dataCenter loginUser:loginUser];
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    [ZTCoverView dissmiss];
    alertShow(errmsg);
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    _paswInput.textField.text = @"";
    [self dispatchLogin];
    NSString*message=@"登陆成功请继续下一步操作";
    alertShow(message);
    [ZTCoverView dissmiss];
}

-(void)keyBoardDidShow:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    CGRect keyBoardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInset = _sv.contentInset;
    contentInset.bottom = keyBoardRect.size.height;
    _sv.contentInset = contentInset;
}

-(void)keyBoardDidHide:(NSNotification*)notification{
    _sv.contentInset = UIEdgeInsetsZero;
}

#pragma mark - helpers
-(void)registerKeyBoardEvent{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}

-(void)unRegisterKeyBoardEvent{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString*)getPhone{
    NSString *phoneNumber = _phoneInput.textField.text;
    return [phoneNumber reverseString];
}

-(NSString*)getPassword{
    NSString *password = _paswInput.textField.text;
    return [password md5];
}

#pragma mark - dispatch Event

-(void)dispatchLogin{
//    BOOL guide_is_shown = [[NSUserDefaults standardUserDefaults] boolForKey:UD_KEY_GUID_HAD_SHOWN];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
//    
//    if (!guide_is_shown || _DEBUG_GUIDE) {
//        GuideViewController *controller = [GuideViewController new];
//        [self.navigationController presentViewController:controller animated:YES completion:nil];
//        return;
//    }
    //第二次登陆
    if (nil != token) {
        if ([self.ttag isEqualToString:@"me"]) {
        NSLog(@"qunimamama");
        
        
       [self dismissViewControllerAnimated:YES completion:nil];
                    return;
        }
        if ([self.ttag isEqualToString:@"sale"]) {
            NSLog(@"qunimamama");
            
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }

        
    }
    
    [_coverView removeFromSuperview];
}

@end
