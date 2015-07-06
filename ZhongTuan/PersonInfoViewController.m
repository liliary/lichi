//
//  PersonInfoViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "ZTTitleLabel.h"
#import "ZTIconButton.h"
#import "ZTInputBox.h"
#import "ZTDataCenter.h"
#import "User.h"
#import "ZTCheckButton.h"
#import "ZTCoverView.h"
@interface PersonInfoViewController ()<NetResultProtocol,UIActionSheetDelegate>{
UIView*topview;
    ZTTitleLabel* _titleView;
    UIView *_headerView;
   //ZTIconButton *_userInfoArea;
    UIView*_userInfoArea;
    UIView*_contentWrap;
    ZTInputBox*sex;
    ZTInputBox*born;
    ZTInputBox*email;
    ZTInputBox*sign;
    UIButton*pic;
    ZTInputBox*name;
   // ZTInputBox*yue;
    UIButton*_completeBtn;
    User*userer;
    NSString*namee;
   // NSString*yueee;
    NSNumber*sexee;
    NSString*bornee;
    NSString*emailee;
    NSString*singnee;
      User* _currentUser;
    UIDatePicker *datapicker;
    UIButton*databtn;
    UILabel*showdata;
    NSInteger tagg;
    ZTCheckButton *boy;
    ZTCheckButton *gril;
    ZTCheckButton *weizhi;
NSNumber*sexx;
}

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.ScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height + 90);
//    self.ScrollView.contentOffset = CGPointMake(70, 0);
//    self.ScrollView.frame = self.view.frame;
//    self.ScrollView.userInteractionEnabled = YES;
//    self.ScrollView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:self.ScrollView];
//    self.ScrollView.contentInset = UIEdgeInsetsMake(-70, 0, 10, 0);
[self initdata];
    [self initTitleBar];
    [self initHeader];
    [self initViews];
}
//-(UIScrollView*)scrollView{
//NSLog(@"scrollview");
//    if (self.ScrollView==nil) {
//        self.ScrollView=[[UIScrollView alloc]init];
//    }
//    return self.ScrollView;
//}
-(void)initdata{
    _currentUser = [[ZTDataCenter sharedInstance] getCurrentUser];


   
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
  tagg=0;
}

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"个人信息更新"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
    
    
    [self initCompleteBtn];
}
-(void)initCompleteBtn{
    _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _completeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBtn setTitleColor:[UIColor colorWithHex:0xd72522] forState:UIControlStateNormal];
    [_completeBtn addTarget:self action:@selector(didTapcompleteBtnn:) forControlEvents:UIControlEventTouchUpInside];
    [_completeBtn fitSize];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_completeBtn];
}
-(void)didTapcompleteBtnn:(UIButton*)bt{
 [self resignInput];
    if ([name validate]&&[sign validate]) {
         [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_EDITUSER] delegate:self cancelIfExist:YES];
         [ZTCoverView alertCover];
    }else{
    NSString*mss=@"信息填写不全";
    alertShow(mss);
    }
}
-(void)resignInput{
    NSArray *inputs = @[name,sign];
    for (ZTInputBox *input in inputs) {
        [input resignFirstResponder];
    }
}
-(void)initHeader{
    
//        /// user info area
//        _userInfoArea = [ZTIconButton new];
//        _userInfoArea.icon.image = [UIImage imageNamed:@"btn_me_user"];
//        _userInfoArea.labelTop.font = [UIFont systemFontOfSize:16.0];
//        _userInfoArea.labelTop.text = @"小明";
//        _userInfoArea.labelBottom.font = [UIFont systemFontOfSize:12.0];
//        _userInfoArea.labelBottom.text = @"账户余额：0元";
//        _userInfoArea.alignMode = ZTIconButtonAlignModeLeft;
//        _userInfoArea.iconLeftGap = 15.0;
//        _userInfoArea.iconContentGap = 15.0;
//        _userInfoArea.bottomLabelMoveDown = 10.0;
//        _userInfoArea.backgroundColor = [UIColor whiteColor];
//        _userInfoArea.topBorder = YES;
//        _userInfoArea.bottomBorder = YES;
//        _userInfoArea.borderWidth = 0.5;
    
       // [_userInfoArea setTarget:self trigger:@selector(didTapUserInfo:)];
    
    
    
            /// user info area
          _userInfoArea = [UIView new];
            pic=[[UIButton alloc]init];
    [pic setImage:[UIImage imageNamed:@"btn_me_user"] forState: UIControlStateNormal];
    
   [_userInfoArea addSubview:pic];
_userInfoArea.backgroundColor = [UIColor whiteColor];
[self.view addSubview:_userInfoArea];
 //[self.ScrollView addSubview:_userInfoArea];
    
}
-(void)initViews{
    topview = (UIView*)self.topLayoutGuide;
    _contentWrap = [UIView new];
    _contentWrap.backgroundColor = [UIColor whiteColor];
    [self initInPutBoxes];
[_contentWrap addSubViews:@[name,sign]];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.view addSubview:_contentWrap];
  //  [self.ScrollView addSubview:_contentWrap];
    
}
-(void)initInPutBoxes{
//    sex = [ZTInputBox new];
//    [sex setTextLabel:@"性别:" withSeparator:@""];
//    UIView*sexview=[[UIView alloc]initWithFrame:CGRectMake(60, 0, 250, 35)];
//   
//    
//    boy = [[ZTCheckButton alloc] initWithTitle:@"男" ImageIcon:[UIImage imageNamed:@"btn_default_unCheck"] selected:[UIImage imageNamed:@"btn_default_check"] contentGap:5.0];
// [boy setTitleColor:[UIColor colorWithHex:0x656565] forState:UIControlStateNormal];
//    boy.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    
//    
//    gril = [[ZTCheckButton alloc] initWithTitle:@"女" ImageIcon:[UIImage imageNamed:@"btn_default_unCheck"] selected:[UIImage imageNamed:@"btn_default_check"] contentGap:5.0];
//    [gril setTitleColor:[UIColor colorWithHex:0x656565] forState:UIControlStateNormal];
//    gril.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    
//    weizhi = [[ZTCheckButton alloc] initWithTitle:@"未知" ImageIcon:[UIImage imageNamed:@"btn_default_unCheck"] selected:[UIImage imageNamed:@"btn_default_check"] contentGap:5.0];
//    [weizhi setTitleColor:[UIColor colorWithHex:0x656565] forState:UIControlStateNormal];
//    weizhi.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    NSArray*buttonts=@[boy,gril,weizhi];
//     NSInteger i=100;
//    for (ZTCheckButton*bt in buttonts) {
//            bt.tag=i;
//            [bt addTarget:self action:@selector(sexes:) forControlEvents:UIControlEventTouchUpInside];
//
//            i++;
//            }
//    [sexview addSubViews:@[gril,boy,weizhi]];
//    [sex addSubview:sexview];
//    
//    boy.frame=CGRectMake(40, 5, 50, 30);
//     gril.frame=CGRectMake(100, 5, 50, 30);
//    weizhi.frame=CGRectMake(160, 5, 50, 30);
//
//    
//    born = [ZTInputBox new];
//    [born setTextLabel:@"出生日期:" withSeparator:@""];
//    
//    UIView*bornview=[[UIView alloc]initWithFrame:CGRectMake(60, 0, 250, 35)];
//    showdata=[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 250,35)];
//    databtn=[[UIButton alloc]initWithFrame:CGRectMake(220, 5, 25,25)];
//    databtn.tag=0;
//    [databtn addTarget:self action:@selector(showdatepicker:) forControlEvents:UIControlEventTouchUpInside];
//   databtn.backgroundColor=[UIColor grayColor];
//   [databtn setTitle:@"a" forState:UIControlStateNormal];
//   [databtn setTitle:@"b" forState: UIControlStateSelected];
//  bornview.backgroundColor=[UIColor clearColor];
//[bornview addSubview:showdata];
//  [bornview addSubview:databtn];
//  [born addSubview:bornview];
//    email = [ZTInputBox new];
//    [email setTextLabel:@"邮箱:" withSeparator:@""];

  NSString*nickname= _currentUser.nickname;
    NSString*signned=_currentUser.signate;
//    _consignee.textField.text=name;


    name  = [ZTInputBox new];
    [name setTextLabel:@"昵称:" withSeparator:@""];
       name.textField.text=nickname;
           sign = [ZTInputBox new];
        [sign setTextLabel:@"个性签名:" withSeparator:@""];
       sign.textField.text=signned;
    NSArray *boxes = @[sign,name];
    for (ZTInputBox *box in boxes){
        box.bottomBorder = YES;
        box.borderWidth = 1.0;
        box.textField.textAlignment = NSTextAlignmentCenter;
        box.lineColor = [UIColor colorWithHex:COL_LINEBREAK];
        box.textLabel.font = [UIFont systemFontOfSize:14.0];
        box.textLabel.textColor = [UIColor colorWithHex:0x656565];
        box.textField.font = [UIFont systemFontOfSize:12.0];
        box.textField.textColor = [UIColor colorWithHex:0x313131];
    }
}
//-(void)sexes:(ZTCheckButton*)sender{
//NSLog(@"222%ld",sender.tag);
//    if (100==sender.tag) {
//    boy.selected=YES;
//        gril.selected=NO;
//        weizhi.selected=NO;
//        sexx=[NSNumber numberWithInt:0];
//    }
//    if (101==sender.tag) {
//    gril.selected=YES;
//        boy.selected=NO;
//        weizhi.selected=NO;
//        sexx=[NSNumber numberWithInt:1];
//    }if (102==sender.tag) {
//    weizhi.selected=YES;
//        boy.selected=NO;
//        gril.selected=NO;
//        sexx=[NSNumber numberWithInt:2];
//    }
//}
//-(void)showdatepicker:(UIButton*)sender
//{
//
//    if (tagg==sender.tag) {
//        datapicker=[[UIDatePicker alloc]init];
//        datapicker.datePickerMode=UIDatePickerModeDate;
//        
//        NSDate *select =[datapicker date];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];      //设置你需要的时间格式
//        
//        NSString *data =  [dateFormatter stringFromDate:select];  //格式化date为字符串
//        
//        showdata.text=data;
//        
//        
//        [datapicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
//        [self.view addSubview:datapicker];
//        tagg=1;
//    }else{
//    datapicker.hidden=YES;
//    
//    NSLog(@"cacaca");}
//    
//  
//}
//
//-(void)datePickerValueChanged:(UIDatePicker*)sender{
// NSDate *select =sender.date ;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];      //设置你需要的时间格式
//    
//    NSString *data =  [dateFormatter stringFromDate:select];  //格式化date为字符串
//
//showdata.text=data;
//    
//}
-(void)viewDidLayoutSubviews{

[[[pic fitSize] setRectMarginLeft:15.0]setRectMarginTop:5] ;
//[[[[[[name fitSize]setRectOnRightSideOfView:pic]addRectX:12]widthToEndWithPadding:9.0]setRectHeight:3]setRectMarginTop:50];

   // [[[_userInfoArea setScreenWidth]setRectHeight:65.0]setRectBelowOfView:topview];
    [_contentWrap setScreenWidth];
//    [[[[sex fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:37.0];
//    [[[[[born fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectBelowOfView:sex] setRectHeight:35.0];
    [[[[name fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:35.0];
    [[[[[sign fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:35.0]setRectBelowOfView:name];
        [[[[_contentWrap wrapContents] setRectBelowOfView:topview]addRectY:5] setScreenWidth];
    
}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
[ZTCoverView dissmiss];
userer=[[ZTDataCenter sharedInstance]getCurrentUser];
NSLog(@"uese%@",userer);
userer.nickname=namee;
userer.signate=singnee;
    NSUserDefaults* udf = [NSUserDefaults standardUserDefaults];
    NSString* token = [udf objectForKey:UD_KEY_CURRENT_TOKEN];

userer.acctoken=token;
[[ZTDataCenter sharedInstance]loginUser:userer];

[self.navigationController popViewControllerAnimated:YES];

}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_EDITUSER]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_NICKNAME:[NSString stringWithFormat:@"%@",name.textField.text],
                                           NET_ARG_SIGNATE:[NSString stringWithFormat:@"%@",sign.textField.text],
                                           
                                           
                                           }];}}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{

NSLog(@"resultes%@",result);
   namee=[result objectForKey:@"nickname"];
  
  
   singnee=[result objectForKey:@"signate"];


}
@end
