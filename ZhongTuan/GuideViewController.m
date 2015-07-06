//
//  GuideViewController.m
//  ZhongTuan
//
//  Created by anddward on 14/12/27.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//
// NOte:
// 引导图配置文件:Supporting Files/Configure/guidePageConfigure.plist
// 最后一张的按钮尺寸调整

#import "GuideViewController.h"
#import "LoginViewController.h"
#import "HomeTabBarController.h"


@interface GuideViewController (){
    UIScrollView *_sv;
    UIButton *_entryButton;
    
    NSArray *_guidePages;               // guidePage ImageNames
    UIImage *_entry_btn_lightBG;        // lightButton background
    UIImage *_entry_btn_darkBG;         // darkButton background
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self buildViews];
}

-(void)viewDidLayoutSubviews{
    [_sv setRectScreen];
    NSArray *pages = [_sv subviews];
    for(int i=0; i< pages.count; i++){
        float sf = [[pages[i] fitSize] rowScaleFactor:screenWidth()];
        [[pages[i] scale:sf] setRectX:i*screenWidth()];
        if (i+1 == pages.count){
            // the last page
            [[[[_entryButton fitSize]
             scale:sf]
             setRectCenterHorizentail]
             setRectMarginBottom:132.5*sf];
        }
    }
    [_sv setContentSize:[_sv fillSize]];
}

#pragma mark - build Views

-(void)buildViews{
    [self initScrollView];
    [self initPageViews];
    [self initEntryButton];
}

-(void)initScrollView{
    _sv = [UIScrollView new];
    _sv.pagingEnabled = YES;
    _sv.bounces = NO;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_sv];
}

-(void)initPageViews{
    for(NSString *picName in _guidePages){
        UIImageView *pv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:picName]];
        [_sv addSubview:pv];
    }
}

-(void)initEntryButton{
    _entryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_entryButton setImage:_entry_btn_lightBG forState:UIControlStateNormal];
    [_entryButton addTarget:self action:@selector(didTapEntryBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *lastPage = [[_sv subviews] lastObject];
    lastPage.userInteractionEnabled = YES;
    [lastPage addSubview:_entryButton];
}

#pragma mark - Button Tap Events

-(void)didTapEntryBtn:(UIButton*)btn{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setBool:YES forKey:UD_KEY_GUID_HAD_SHOWN];
    HomeTabBarController *home = [HomeTabBarController new];
   // UINavigationController *rootController = [[UINavigationController new] initWithRootViewController:home];
    [self presentViewController:home animated:YES completion:nil];
    
    //[self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - helpers

-(void)initData{
    NSString *guideConfigurePath = [[NSBundle mainBundle] pathForResource:FGUI_CONF ofType:@"plist"];
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:guideConfigurePath];
    _guidePages = config[FGUI_KEY_PAGES];
    _entry_btn_lightBG = [UIImage imageNamed:config[FGUI_KEY_ENTRY_BTN][FGUI_KEY_BG_BLIGHT]];
    _entry_btn_darkBG = [UIImage imageNamed:config[FGUI_KEY_ENTRY_BTN][FGUI_KEY_BG_DARK]];
}

@end
