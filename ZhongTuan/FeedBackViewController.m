//
//  FeedBackViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//  TODO: 底部使用scrollview

#import "FeedBackViewController.h"
#import "ZTTitleLabel.h"
#import "ZTSessionView.h"
#import "ZTTextContentView.h"
#import "ZTRoundButton.h"

@interface FeedBackViewController(){
    UIScrollView *_sv;
    UIView *_topLayout;
    
    ZTTitleLabel *_titleView;
    ZTSessionView *_feedBackArea;
    
    UILabel *_greetingTitle;
    UILabel *_titleLable;
    UITextField *_titleInput;
    UILabel *_contentLabel;
    ZTTextContentView *_contentInput;
    
    ZTRoundButton *_submit;
}
@end

@implementation FeedBackViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTitleBar];
    [self buildViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerKeyboardNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unRegisterKeyboardNotification];
}

#pragma mark - build Views

-(void)buildViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    
    _sv = [UIScrollView new];
    _sv.bounces = NO;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    _sv.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *grz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapScrollViewArea)];
    [_sv addGestureRecognizer:grz];
    
    _greetingTitle = [UILabel new];
    _greetingTitle.text = @"请你反馈对中团的意见和建议";
    _greetingTitle.textColor = [UIColor colorWithHex:0x333333];
    _greetingTitle.font = [UIFont systemFontOfSize:15.0];
    
    _titleLable = [UILabel new];
    _titleLable.text = @"标题:";
    _titleLable.textColor = [UIColor colorWithHex:0x505050];
    _titleLable.font = [UIFont systemFontOfSize:14.0];
    
    _titleInput = [UITextField new];
    _titleInput.borderStyle = UITextBorderStyleRoundedRect;
    _titleInput.placeholder = @"一句话概括你宝贵的意见或建议";
    _titleInput.textColor = [UIColor colorWithHex:0x636363];
    _titleInput.font = [UIFont systemFontOfSize:12.0];
    _titleInput.keyboardType = UIKeyboardTypeDefault;
    
    _contentLabel = [UILabel new];
    _contentLabel.text = @"内容:";
    _contentLabel.textColor = [UIColor colorWithHex:0x505050];
    _contentLabel.font = [UIFont systemFontOfSize:14.0];

    _contentInput = [ZTTextContentView new];
    _contentInput.leftBorder = YES;
    _contentInput.rightBorder = YES;
    _contentInput.bottomBorder = YES;
    _contentInput.topBorder = YES;
    _contentInput.borderWidth = 1.0;
    _contentInput.editable = YES;
    _contentInput.scrollEnabled = YES;
    _contentInput.font = [UIFont systemFontOfSize:14.0];
    _contentInput.textColor = [UIColor colorWithHex:0x505050];
    _contentInput.keyboardType = UIKeyboardTypeDefault;
    
    _feedBackArea = [[ZTSessionView alloc] init];
    _feedBackArea.borderWidth = 1.0;
    _feedBackArea.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    _feedBackArea.topBorder = YES;
    _feedBackArea.bottomBorder = YES;
    
    _submit = [[ZTRoundButton alloc] initWithTitle:@"提交" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_bg_nomal"]];
    
    [_feedBackArea addSubViews:@[_greetingTitle,_titleLable,_titleInput,_contentLabel,_contentInput]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [_sv addSubViews:@[_feedBackArea,_submit]];
    [self.view addSubview:_sv];
    
}

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"客户反馈"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

#pragma mark - layout Views

-(void)viewDidLayoutSubviews{
    [[[_sv setScreenWidth] setRectBelowOfView:_topLayout] heightToEndWithPadding:0.0];
    [_feedBackArea setScreenWidth];
    [[[_greetingTitle fitSize] setRectMarginLeft:12.0] addRectY:7.0];
    [[[[_titleLable fitSize] setRectMarginLeft:27.0] setRectBelowOfView:_greetingTitle] addRectY:12.0];
    [[[[[[_titleInput fitSize] setRectMarginLeft:27.0] widthToEndWithPadding:27.0] setRectBelowOfView:_titleLable]
        addRectY:12.0] setRectHeight:22.0];
    [[[[_contentLabel fitSize] setRectMarginLeft:27.0] setRectBelowOfView:_titleInput] addRectY:12.0];
    [[[[[[_contentInput fitSize] setRectMarginLeft:27.0] widthToEndWithPadding:27.0] setRectBelowOfView:_contentLabel]
        addRectY:12.0] setRectHeight:134.0];
    [[[[_feedBackArea wrapContents] setScreenWidth] addRectY:11.0] addRectHeight:7.0+15.0];
    [[[[[_submit fitSize] setRectBelowOfView:_feedBackArea] addRectY:23.0] setRectWidth:103.0] setRectCenterHorizentail];
    _sv.contentSize = [_sv fillSize];
}

#pragma mark - onClick Events

-(void)didTapScrollViewArea{
    [_titleInput resignFirstResponder];
    [_contentInput resignFirstResponder];
}

#pragma mark - Status Events

-(void)keyBoardWillShow:(NSNotification*)notf{
    NSDictionary *info = [notf userInfo];
    CGRect keyBoardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIEdgeInsets edge = _sv.contentInset;
    edge.bottom = keyBoardRect.size.height;
    _sv.contentInset = edge;
}

-(void)keyBoardWillHidde:(NSNotification*)notf{
    _sv.contentInset = UIEdgeInsetsZero;
}

#pragma mark - helpers



-(void)registerKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidde:) name:UIKeyboardWillHideNotification object:self.view.window];
}

-(void)unRegisterKeyboardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
