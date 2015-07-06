//
//  ChangeUserPhoneController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ChangeUserPhoneController.h"
#import "TeambuyOrderViewController.h"
#import "ZTSessionView.h"
#import "ZTTitleLabel.h"
#import "ZTInputBox.h"
#import "ZTRoundButton.h"

@interface ChangeUserPhoneController (){
    ZTSessionView* topBar;
    ZTTitleLabel* titleView;
    ZTInputBox* phoneInput;
    ZTRoundButton* cancelBtn;
    ZTRoundButton* conformBtn;
}

@end

@implementation ChangeUserPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildViews];
}

#pragma mark - buildViews
-(void)buildViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];

    topBar = [ZTSessionView new];
    topBar.bottomBorder = YES;
    topBar.borderWidth = 1.0;
    topBar.backgroundColor = [UIColor colorWithHex:0xf7f7f7];
    
    titleView = [[ZTTitleLabel alloc] initWithTitle:@"更换收货手机号码"];
    
    phoneInput = [ZTInputBox new];
    phoneInput.textField.placeholder = @"请输入更换的手机号码";
    phoneInput.leftPadding = @15.0;
    phoneInput.rightPadding = @15.0;
    phoneInput.bottomBorder = YES;
    
    cancelBtn = [[ZTRoundButton alloc]
              initWithTitle:@"取消" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_buy"]];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [cancelBtn addTarget:self action:@selector(didTapCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    conformBtn = [[ZTRoundButton alloc]
               initWithTitle:@"确认" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_buy"]];
    conformBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [conformBtn addTarget:self action:@selector(didTapConformBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [topBar addSubview:titleView];
    [self.view addSubViews:@[topBar,phoneInput,conformBtn,cancelBtn]];
}

-(void)viewDidLayoutSubviews{
    [[topBar setScreenWidth] setRectHeight:68.0];
    [[[titleView fitSize] setRectCenterInParent] addRectY:10.0];
    [[[phoneInput setScreenWidth] setRectHeight:45.0] setRectBelowOfView:topBar];
    [[[[[cancelBtn setRectWidth:80.0] setRectHeight:25.0]
        setRectBelowOfView:phoneInput] setRectMarginLeft:30.0] addRectY:20.0];
    [[[[[conformBtn setRectWidth:80.0] setRectHeight:25.0]
        setRectBelowOfView:phoneInput] setRectMarginRight:30.0] addRectY:20.0];
}

-(void)didTapConformBtn:(UIButton*)btn{
    [_delegate updateUserPhone:phoneInput.textField.text];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)didTapCancelBtn:(UIButton*)btn{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
