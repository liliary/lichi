//
//  MeController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-4.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//  TODO:添加页面切换的网络取消

#import "MeController.h"
#import "MeCell.h"
#import "ZTIconButton.h"
#import "ZTTitleLabel.h"
#import "ZTDataCenter.h"
#import "SettingViewController.h"
#import "User.h"
#import "WaitForExpressViewController.h"
#import "NoPayViewController.h"
#import "PayedViewController.h"
#import "MyAddressViewController.h"
#import "MyCollectionViewController.h"
#import "PersonInfoViewController.h"
#import "ZTQViewController.h"
#import "LoginViewController.h"
#import "RevivceGoodViewController.h"
#import "MysuggestViewController.h"
#import "MyCommentViewController.h"
#import "User.h"
#import "ZTImageLoader.h"
@interface MeController ()<NetResultProtocol,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    /// header views
    UIView *_headerView;
    ZTIconButton *_userInfoArea;
    ZTIconButton *_ZTQuan;
    ZTIconButton *_WaitToPay;
    /// data
    NSArray* _iconNames;
    NSArray* _titleNames;
    NSArray* _btnCallBack;
    User* _currentUser;
    NSNumber*coll;
   NSNumber*nopay;
    NSNumber*quan;
  UIImage*image;
  NSData*upimagedata;
  NSString*Headurl;
  User*userr;
  ZTImageLoader*pichead;
}

@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self initHeader];
    [self initTableView];
    NSLog(@"one");
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"xiaoshil");
}

-(void)viewWillAppear:(BOOL)animated{
NSLog(@"two");
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

  NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (token) {
    NSLog(@"token12%@",token);
         [self upDateDataIfNeed];
        _userInfoArea = [ZTIconButton new];
        if (!image) {
             _userInfoArea.icon.image = [UIImage imageNamed:@"btn_me_user"];
            userr=[[ZTDataCenter sharedInstance]getCurrentUser];
            NSLog(@"hahahhaha%@",userr);
            NSLog(@"picccc%@",userr.avatar);
            pichead=[ZTImageLoader new];
            [pichead fitSize];
//            [pichead setImageFromUrl:userr.avatar];
//            NSLog(@"pichead%@",pichead);
//            _userInfoArea.icon.image=pichead.image;
            dispatch_async(dispatch_get_main_queue(), ^{
                 [pichead setImageFromUrl:userr.avatar];
                NSLog(@"pichead%@",pichead);
                _userInfoArea.icon.image=pichead.image;
                });
        }
        else{ _userInfoArea.icon.image =image;
        }
       UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChangeImage:)];
        [_userInfoArea.icon addGestureRecognizer:tapGeture];
         _userInfoArea.labelTop.font = [UIFont systemFontOfSize:16.0];
                    //_userInfoArea.labelTop.text = @"还没有昵称哦";
        
        _currentUser = [[ZTDataCenter sharedInstance] getCurrentUser];
        NSLog(@"wwwwwwwww%@",_currentUser);
                _userInfoArea.labelTop.text = _currentUser.nickname;

        
        
        _userInfoArea.labelBottom.font = [UIFont systemFontOfSize:12.0];
                    _userInfoArea.labelBottom.text = @"账户余额：0元";
                    _userInfoArea.alignMode = ZTIconButtonAlignModeLeft;
                    _userInfoArea.iconLeftGap = 15.0;
                    _userInfoArea.iconContentGap = 15.0;
                    _userInfoArea.bottomLabelMoveDown = 10.0;
                    _userInfoArea.backgroundColor = [UIColor whiteColor];
                    _userInfoArea.topBorder = YES;
                    _userInfoArea.bottomBorder = YES;
                    _userInfoArea.borderWidth = 0.5;
                    [_userInfoArea setTarget:self trigger:@selector(didTapUserInfo:)];

        // wait to pay button
                    _WaitToPay = [ZTIconButton new];
                    _WaitToPay.icon.image = [UIImage imageNamed:@"icon_me_waitToPay"];
                    _WaitToPay.labelTop.text = @"待支付";
                    _WaitToPay.labelBottom.text =@"   0   ";
                    _WaitToPay.alignMode = ZTIconButtonAlignModeCenter;
                    _WaitToPay.iconLeftGap = 15.0;
                    _WaitToPay.iconContentGap = 15.0;
                    _WaitToPay.bottomBorder = YES;
                    _WaitToPay.borderWidth = 0.5;
                    _WaitToPay.backgroundColor = [UIColor whiteColor];
                    [_WaitToPay setTarget:self trigger:@selector(didTapNoPayBtn:)];
        
                    /// layouts
                    [[_userInfoArea setScreenWidth]
                     setRectHeight:80.0];
        
                    [[[_ZTQuan setRectWidth:160.0]
                      setRectHeight:60.0]
                     setRectBelowOfView:_userInfoArea];
        
                    [[[[_WaitToPay setRectWidth:160.0]
                       setRectHeight:60.0]
                      setRectBelowOfView:_userInfoArea]
                     setRectOnRightSideOfView:_ZTQuan];
                    
                    [_headerView addSubViews:@[_userInfoArea,_ZTQuan,_WaitToPay]];
                    [[[_headerView wrapContents] addRectHeight:10.0] setBackgroundColor:[UIColor clearColor]];



    }
//    if (token) {
//        [self upDateDataIfNeed];
//            NSLog(@"onetime");
//            _userInfoArea = [ZTIconButton new];
//            _userInfoArea.icon.image = [UIImage imageNamed:@"btn_me_user"];
//            _userInfoArea.labelTop.font = [UIFont systemFontOfSize:16.0];
//            _userInfoArea.labelTop.text = @"还没有昵称哦";
//        
//        _currentUser = [[ZTDataCenter sharedInstance] getCurrentUser];
//        NSLog(@"1huancun%@",_currentUser.nickname);
//        _userInfoArea.labelTop.text = _currentUser.nickname;
//        
//            _userInfoArea.labelBottom.font = [UIFont systemFontOfSize:12.0];
//            _userInfoArea.labelBottom.text = @"账户余额：0元";
//            _userInfoArea.alignMode = ZTIconButtonAlignModeLeft;
//            _userInfoArea.iconLeftGap = 15.0;
//            _userInfoArea.iconContentGap = 15.0;
//            _userInfoArea.bottomLabelMoveDown = 10.0;
//            _userInfoArea.backgroundColor = [UIColor whiteColor];
//            _userInfoArea.topBorder = YES;
//            _userInfoArea.bottomBorder = YES;
//            _userInfoArea.borderWidth = 0.5;
//            [_userInfoArea setTarget:self trigger:@selector(didTapUserInfo:)];
//            
//            //// ZTQuan button
//            _ZTQuan = [ZTIconButton new];
//            _ZTQuan.icon.image = [UIImage imageNamed:@"icon_me_quan"];
//            _ZTQuan.labelTop.text = @"中团券";
//            _ZTQuan.labelBottom.text = @"   0   ";
//            _ZTQuan.alignMode = ZTIconButtonAlignModeCenter;
//            _ZTQuan.iconLeftGap = 15.0;
//            _ZTQuan.iconContentGap = 25.0;
//            _ZTQuan.rightBorder = YES;
//            _ZTQuan.bottomBorder = YES;
//            _ZTQuan.borderWidth = 0.5;
//            _ZTQuan.backgroundColor = [UIColor whiteColor];
//            [_ZTQuan setTarget:self trigger:@selector(didTapZTQBtn:)];
//            
//            //// wait to pay button
//            _WaitToPay = [ZTIconButton new];
//            _WaitToPay.icon.image = [UIImage imageNamed:@"icon_me_waitToPay"];
//            _WaitToPay.labelTop.text = @"待支付";
//            _WaitToPay.labelBottom.text =@"   0   ";
//            _WaitToPay.alignMode = ZTIconButtonAlignModeCenter;
//            _WaitToPay.iconLeftGap = 15.0;
//            _WaitToPay.iconContentGap = 15.0;
//            _WaitToPay.bottomBorder = YES;
//            _WaitToPay.borderWidth = 0.5;
//            _WaitToPay.backgroundColor = [UIColor whiteColor];
//            [_WaitToPay setTarget:self trigger:@selector(didTapNoPayBtn:)];
//            
//            /// layouts
//            [[_userInfoArea setScreenWidth]
//             setRectHeight:80.0];
//            
//            [[[_ZTQuan setRectWidth:160.0]
//              setRectHeight:60.0]
//             setRectBelowOfView:_userInfoArea];
//            
//            [[[[_WaitToPay setRectWidth:160.0]
//               setRectHeight:60.0]
//              setRectBelowOfView:_userInfoArea]
//             setRectOnRightSideOfView:_ZTQuan];
//            
//            [_headerView addSubViews:@[_userInfoArea,_ZTQuan,_WaitToPay]];
//            [[[_headerView wrapContents] addRectHeight:10.0] setBackgroundColor:[UIColor clearColor]];
        
   // }
    if (nil==token) {
        NSLog(@"twotime");
        UIImageView*nologin=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background2"]];
        nologin.userInteractionEnabled=YES;
        //_topBanner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        UILabel*tishi=[[UILabel alloc]init];
        tishi.font = [UIFont systemFontOfSize:15.0];
        tishi.textColor = [UIColor colorWithHex:0x9b9b9b];
        tishi.text=@" 亲！你还没有登录咯~~~";
        UIButton*denglu=[[UIButton alloc]init];
        denglu.backgroundColor=[UIColor redColor];
        [denglu setTitle:@"请登录" forState:UIControlStateNormal ];
         
        [denglu.layer setMasksToBounds:YES];
        [denglu.layer setCornerRadius:5.0];//设置矩形四个圆角半径
        [denglu.layer setBorderWidth:0.3];//边框宽度
        
        //// ZTQuan button
        _ZTQuan = [ZTIconButton new];
        _ZTQuan.icon.image = [UIImage imageNamed:@"icon_me_quan"];
        _ZTQuan.labelTop.text = @"中团券";
        _ZTQuan.labelBottom.text = @"    0    ";
        _ZTQuan.alignMode = ZTIconButtonAlignModeCenter;
        _ZTQuan.iconLeftGap = 15.0;
        _ZTQuan.iconContentGap = 25.0;
        _ZTQuan.rightBorder = YES;
        _ZTQuan.bottomBorder = YES;
        _ZTQuan.borderWidth = 0.5;
        _ZTQuan.backgroundColor = [UIColor whiteColor];
        [_ZTQuan setTarget:self trigger:@selector(didTapZTQBtn:)];
        //// wait to pay button
        _WaitToPay = [ZTIconButton new];
        _WaitToPay.icon.image = [UIImage imageNamed:@"icon_me_waitToPay"];
        _WaitToPay.labelTop.text = @"待支付";
        _WaitToPay.labelBottom.text =@"    0    ";
        _WaitToPay.alignMode = ZTIconButtonAlignModeCenter;
        _WaitToPay.iconLeftGap = 15.0;
        _WaitToPay.iconContentGap = 15.0;
        _WaitToPay.bottomBorder = YES;
        _WaitToPay.borderWidth = 0.5;
        _WaitToPay.backgroundColor = [UIColor whiteColor];
        [_WaitToPay setTarget:self trigger:@selector(didTapNoPayBtn:)];
        [nologin addSubViews:@[tishi,denglu]];
        [[nologin setScreenWidth]
         setRectHeight:80.0];
        [[[tishi fitSize]setRectMarginTop:7.0]setRectCenterInParent];
        [[denglu fitSize]setRectBelowOfView:tishi];
        
        denglu.frame=CGRectMake(117, 55, 80, 20);
        [denglu addTarget:self action:@selector(loginin:) forControlEvents: UIControlEventTouchUpInside];
        
        [[[_ZTQuan setRectWidth:160.0]
          setRectHeight:60.0]
         setRectBelowOfView:nologin];
        [[[[_WaitToPay setRectWidth:160.0]
           setRectHeight:60.0]
          setRectBelowOfView:nologin]
         setRectOnRightSideOfView:_ZTQuan];
        [_headerView addSubViews:@[nologin,_ZTQuan,_WaitToPay]];
        [[[_headerView wrapContents] addRectHeight:10.0] setBackgroundColor:[UIColor clearColor]];
        
    }

    
}

#pragma mark - build views

-(void)initTitleBar{

    ZTTitleLabel *titleView = [[ZTTitleLabel alloc] initWithTitle:@"我的中团"];
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"btn_me_setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(didTapSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView fitSize];
    [settingButton fitSize];
    
   self.navigationController.navigationBar.tintColor = [UIColor redColor];
     self.navigationController.navigationBar.topItem.title = @"返回";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];;
    self.navigationItem.titleView = titleView;
}
 /**
    初始化header
 */
-(void)initHeader{
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    /// user info area
    _userInfoArea = [ZTIconButton new];
    _userInfoArea.icon.image = [UIImage imageNamed:@"btn_me_user"];
    _userInfoArea.labelTop.font = [UIFont systemFontOfSize:16.0];
    _userInfoArea.labelTop.text = @"还没有昵称哦";
    
    _userInfoArea.labelBottom.font = [UIFont systemFontOfSize:12.0];
    _userInfoArea.labelBottom.text = @"账户余额：0元";
    _userInfoArea.alignMode = ZTIconButtonAlignModeLeft;
    _userInfoArea.iconLeftGap = 15.0;
    _userInfoArea.iconContentGap = 15.0;
    _userInfoArea.bottomLabelMoveDown = 10.0;
    _userInfoArea.backgroundColor = [UIColor whiteColor];
    _userInfoArea.topBorder = YES;
    _userInfoArea.bottomBorder = YES;
    _userInfoArea.borderWidth = 0.5;
    [_userInfoArea setTarget:self trigger:@selector(didTapUserInfo:)];
    
    //// ZTQuan button
    _ZTQuan = [ZTIconButton new];
    _ZTQuan.icon.image = [UIImage imageNamed:@"icon_me_quan"];
    _ZTQuan.labelTop.text = @"中团券";
    _ZTQuan.labelBottom.text = @"   0   ";
    _ZTQuan.alignMode = ZTIconButtonAlignModeCenter;
    _ZTQuan.iconLeftGap = 15.0;
    _ZTQuan.iconContentGap = 25.0;
    _ZTQuan.rightBorder = YES;
    _ZTQuan.bottomBorder = YES;
    _ZTQuan.borderWidth = 0.5;
    _ZTQuan.backgroundColor = [UIColor whiteColor];
    [_ZTQuan setTarget:self trigger:@selector(didTapZTQBtn:)];
    
    //// wait to pay button
    _WaitToPay = [ZTIconButton new];
    _WaitToPay.icon.image = [UIImage imageNamed:@"icon_me_waitToPay"];
    _WaitToPay.labelTop.text = @"待支付";
    _WaitToPay.labelBottom.text =@"   0   ";
    _WaitToPay.alignMode = ZTIconButtonAlignModeCenter;
    _WaitToPay.iconLeftGap = 15.0;
    _WaitToPay.iconContentGap = 15.0;
    _WaitToPay.bottomBorder = YES;
    _WaitToPay.borderWidth = 0.5;
    _WaitToPay.backgroundColor = [UIColor whiteColor];
    [_WaitToPay setTarget:self trigger:@selector(didTapNoPayBtn:)];
    
    /// layouts
    [[_userInfoArea setScreenWidth]
     setRectHeight:80.0];
    
    [[[_ZTQuan setRectWidth:160.0]
      setRectHeight:60.0]
     setRectBelowOfView:_userInfoArea];
    
    [[[[_WaitToPay setRectWidth:160.0]
       setRectHeight:60.0]
      setRectBelowOfView:_userInfoArea]
     setRectOnRightSideOfView:_ZTQuan];
    
    [_headerView addSubViews:@[_userInfoArea,_ZTQuan,_WaitToPay]];
    [[[_headerView wrapContents] addRectHeight:10.0] setBackgroundColor:[UIColor clearColor]];
    
    
}

/**
    初始化tableview
 */
-(void)initTableView{

    [self.tableView registerClass:[MeCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = _headerView;
}

#pragma mark - table delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_iconNames count];
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
NSLog(@"diyicithird");
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MeCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];//会放入到队列中的
    }
    NSLog(@"66666666");
    cell.bottomBorder = YES;
    cell.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    cell.borderWidth = 1.0;
    long row = [indexPath row];
    if (row == [_iconNames count]-1) {
        /// 最后一项
        cell.borderMargin = 0.0;
    }else{
        cell.borderMargin = 15.0;
    }
    cell.icon.image = [UIImage imageNamed:[_iconNames objectAtIndex:row]];
    cell.title.text = [_titleNames objectAtIndex:row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    [self performSelector:NSSelectorFromString(_btnCallBack[row]) withObject:nil afterDelay:0];
}

#pragma mark - Button Click Event
-(void)loginin:(UIButton*)sender{

    LoginViewController*loginView=[[LoginViewController alloc]init];
    loginView.ttag=@"me";

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
//    [self presentViewController:nav animated:YES completion:NULL]


[self presentViewController:nav animated:YES completion:nil];



}
-(void)ChangeImage:(UITapGestureRecognizer*)sender{
UIActionSheet*pic=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开照相机" otherButtonTitles:@"从手机相册中获取", nil];
[pic showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

NSLog(@"%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController*ipc=[[UIImagePickerController alloc]init];
                [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
                ipc.delegate=self;
                ipc.allowsEditing=YES;
                [self presentViewController:ipc animated:YES completion:nil];
            }else{
            NSLog(@"no xiangji");
            }
        }
            break;
        case 1:{
        UIImagePickerController*ipc=[[UIImagePickerController alloc]init];
        [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        ipc.delegate=self;
        ipc.allowsEditing=YES;
        [self presentViewController:ipc animated:YES completion:nil];
        }
        default:
            break;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
UIImage* imagee=[info objectForKey:@"UIImagePickerControllerEditedImage"];
NSString*url=[[info objectForKey:UIImagePickerControllerReferenceURL]description];
NSData*imageData=[[NSData alloc]init];
    if ([url hasSuffix:@"JPG"]) {
        imageData=UIImageJPEGRepresentation(imagee, 1);
    }else{
    imageData=UIImagePNGRepresentation(imagee);
    }
UIImage* imaged=[UIImage imageWithData:imageData];
     image= [self scaleToSize:imaged size:CGSizeMake(65, 65)];
    _userInfoArea.icon.image=image;
    upimagedata=UIImagePNGRepresentation(image);
    NSLog(@"nizaima%@",_userInfoArea.icon.image);
        NSDictionary * _paramss = @{@"userCode":NET_ARG_AVANAME};
    
    [self  uploadPhoto:NET_API_SETAVATAR params:_paramss serviceName:@"imgFile" NotiName:@"uploadPhoto" imageD:upimagedata];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
///////////////////////
- (void)uploadPhoto:(NSString *)method params:(NSDictionary *)_params serviceName:(NSString *)name NotiName:(NSString *)nName imageD:(NSData *)imageData

{
//  上传接口
    NSString * url = [NSString stringWithFormat:@"%@%@",@"http://app.teambuy.com.cn/apnc/m/",method];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
       //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
       //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //	//要上传的图片
    //	UIImage *image=[params objectForKey:@"pic"];
    //得到图片的data
//NSData *data = UIImagePNGRepresentation(self.image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [_params allKeys];
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        if(![key isEqualToString:@"pic"])
        {
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[_params objectForKey:key]];
        }
    }
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"head.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:imageData];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", (int)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //建立连接，设置代理
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //设置接受response的data
    if (conn) {
        _mResponseData = [[NSMutableData alloc] init];
  
    }}
#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_mResponseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mResponseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
NSLog(@"121212%@ 21%@",connection,_mResponseData);
    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:_mResponseData options:kNilOptions error:nil];
   Headurl=[dic objectForKey:@"data"];
   NSLog(@"headurl%@",Headurl);
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

//////////////////
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


//-(UIImage *)getImageFromImage:(UIImage*) superImage subImageSize:(CGSize)subImageSize subImageRect:(CGRect)subImageRect {
//    //    CGSize subImageSize = CGSizeMake(WIDTH, HEIGHT); //定义裁剪的区域相对于原图片的位置
//    //    CGRect subImageRect = CGRectMake(START_X, START_Y, WIDTH, HEIGHT);
//    CGImageRef imageRef = superImage.CGImage;
//        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
//        UIGraphicsBeginImageContext(subImageSize);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//       CGContextDrawImage(context, subImageRect, subImageRef);
//        UIImage* returnImage = [UIImage imageWithCGImage:subImageRef];
//         UIGraphicsEndImageContext(); //返回裁剪的部分图像
//        return returnImage;
//    }



-(void)didTapSettingBtn:(UIButton*)btn{

    SettingViewController *controller = [SettingViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)didTapUserInfo:(ZTIconButton*)button{
    [self.navigationController pushViewController:[PersonInfoViewController new] animated:YES];
}

-(void)didTapZTQBtn:(ZTIconButton*)button{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    [self.navigationController pushViewController:[ZTQViewController new] animated:YES];
    }}

-(void)didTapNoPayBtn:(ZTIconButton*)button{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[NoPayViewController new] animated:YES];}
}

-(void)didTapPayedBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }
    
    else{
    [self.navigationController pushViewController:[PayedViewController new] animated:YES];
    }}

-(void)didTapWaitForExpress{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    [self.navigationController pushViewController:[WaitForExpressViewController new] animated:YES];
    }}

-(void)didTapRevivceGood{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[RevivceGoodViewController new] animated:YES];
    }}

-(void)didTapMyComment{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[MyCommentViewController new] animated:YES];
    }}

-(void)didTapMyCollectionBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    [self.navigationController pushViewController:[MyCollectionViewController new] animated:YES];
    }}

-(void)didTapMyAddressBtn{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
    [self.navigationController pushViewController:[MyAddressViewController new] animated:YES];
    }}

-(void)didTapMysuggest{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_CURRENT_TOKEN];
    if (nil==token) {
        alertShow(@" 请先登录");
    }else{
        [self.navigationController pushViewController:[MysuggestViewController new] animated:YES];
    }}

#pragma mark - helpers

-(void)initData{

    _iconNames = @[@"icon_me_payed",@"icon_me_receipit",@"have_wait_good",@"my_evlution",@"icon_me_collection",@"icon_me_address",@"feedback"];
    /// ToDo: when array provide index is out of range ,return the last one by default.
    _titleNames = @[@"已支付",@"待收货",@"已收货",@"我的评价",@"我的收藏",@"我的地址",@"我的建议"] ;
    _btnCallBack = @[@"didTapPayedBtn",@"didTapWaitForExpress",@"didTapRevivceGood",@"didTapMyComment",@"didTapMyCollectionBtn",@"didTapMyAddressBtn",@"didTapMysuggest"];}

-(void)upDateDataIfNeed{

[[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETMYINFO] delegate:self cancelIfExist:YES];

 
    
}
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{


 _WaitToPay.labelBottom.text = [nopay stringValue] ;
 _ZTQuan.labelBottom.text = [NSString stringWithFormat:@"%@",quan];
 
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{
NSLog(@"getinfo%@",result);
nopay=[result objectForKey:@"nopay"];
quan=[result objectForKey:@"quan"];

}
@end
