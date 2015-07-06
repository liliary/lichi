//
//  AddressAlterViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "AddressAlterViewController.h"
#import "ZTInputBox.h"
#import "ZTTitleLabel.h"
#import "ZTChoiceItem.h"
#import "ZTCheckButton.h"
#import "ZTDataCenter.h"
#import "ZTCoverView.h"
#import "Province.h"
#import "City.h"
#import "Area.h"
#import "Sendid.h"
@interface AddressAlterViewController()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol,UIAlertViewDelegate>{
    BOOL isNewAddress;

    // titleBar
    ZTTitleLabel *_titleView;
    UIButton *_completeBtn;

    UIView *_topLayout;
    UIView *_contentWrap;
    ZTInputBox *_consignee;
    ZTInputBox *_consigPhone;
    ZTChoiceItem *_expressDateSelectedBtn;
    ZTChoiceItem *_provinceSelectedBtn;
    ZTChoiceItem *_citySelectedBtn;
    ZTChoiceItem *_areaSelectedBtn;
    ZTInputBox *_address;
    ZTCheckButton *_setDefaultBtn;
    UIView *_maskView;
    NSString*moren;
}

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UITableView *tpicker;
@property (strong,nonatomic) UITableView *proPicker;
@property (strong,nonatomic) UITableView *cityPicker;
@property (strong,nonatomic) UITableView *areaPicker;
@property (strong,nonatomic) NSArray *provinceArr;
@property (strong,nonatomic) NSArray *cityArr;
@property (strong,nonatomic) NSArray *areaArr;
@property(strong,nonatomic)NSArray *sendidArr;
@property (weak,nonatomic) UIButton *btn;
@property(nonatomic,strong) Province *selectedprovonce;
@property(nonatomic,strong) City *selectcity;
@property(nonatomic,strong)Area*selectarea;
@property(nonatomic,strong)Sendid*senddid;
//@property (strong,nonatomic) ZTDataCenter *center;
@end

@implementation AddressAlterViewController

-(void)viewDidLoad{
    [super viewDidLoad];
       //添加scrollView
    self.scrollView.contentSize = CGSizeMake(0, self.view.frame.size.height + 90);
    self.scrollView.contentOffset = CGPointMake(70, 0);
    self.scrollView.frame = self.view.frame;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentInset = UIEdgeInsetsMake(-70, 0, 10, 0);
    [self initData];
    [self initTitleBar];
    [self initViews];
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

#pragma mark - build Views

/*          title bar       */

-(void)initTitleBar{
    [self initTitleView];
    [self initCompleteBtn];
}

-(void)initCompleteBtn{
    _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _completeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBtn setTitleColor:[UIColor colorWithHex:0xd72522] forState:UIControlStateNormal];
    [_completeBtn addTarget:self action:@selector(didTapcompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_completeBtn fitSize];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_completeBtn];
}
#pragma mark - OnClick  完成 Events

-(void)didTapcompleteBtn:(UIButton*)btn{
    [self resignInput];
    
    if([[_consignee.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]||![_consigPhone validate]||[_address.textField.text isEqualToString:@""])
    {
        alertShow(@"地址格式错误");
    
    }
    
    else
 
    {
        if (self.addre!=nil) {
        
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_EDITADDRESS] delegate:self cancelIfExist:YES];
        }
       else
         {
     [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_ADDADDRESS] delegate:self cancelIfExist:YES];
         [ZTCoverView alertCover];
             }
       
    }
}
-(void)resignInput{
    NSArray *inputs = @[_consignee,_consigPhone,_address];
    for (ZTInputBox *input in inputs) {
        [input resignFirstResponder];
    }
}








-(void)initTitleView{
    if (isNewAddress) {
        _titleView = [[ZTTitleLabel alloc] initWithTitle:@"添加新地址"];
    }else{
        _titleView = [[ZTTitleLabel alloc] initWithTitle:@"地址管理"];
    }
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

/*      content views       */

-(void)initViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    _contentWrap = [UIView new];
    _contentWrap.backgroundColor = [UIColor whiteColor];
    [self initInputBoxes];
    [self initSelectedItems];
    [self initDefaultBtn];
    
    [_contentWrap addSubViews:@[_consignee,_consigPhone,_expressDateSelectedBtn,_provinceSelectedBtn,_citySelectedBtn,_areaSelectedBtn,_address,_setDefaultBtn]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.scrollView addSubview:_contentWrap];
}

-(void)initInputBoxes{
       NSString*name = self.addre.truename;
        NSString* phone = [self.addre.tel stringValue];
    NSString*addresses=self.addre.address;
    _consignee = [ZTInputBox new];
    [_consignee setTextLabel:@"收货人姓名:" withSeparator:@""];
    
    _consigPhone = [ZTInputBox new];
    [_consigPhone setTextLabel:@"电话号码:" withSeparator:@""];
    
    _address = [ZTInputBox new];
    [_address setTextLabel:@"详细地址:" withSeparator:@""];
    if (self.addre!=nil) {
        _consignee = [ZTInputBox new];
        [_consignee setTextLabel:@"收货人姓名:" withSeparator:@""];
        _consignee.textField.text=name;
        
        _consigPhone = [ZTInputBox new];
        [_consigPhone setTextLabel:@"电话号码:" withSeparator:@""];
        _consigPhone.textField.text=phone;
        _address = [ZTInputBox new];
        [_address setTextLabel:@"详细地址:" withSeparator:@""];
     _address.textField.text=addresses;
    }
    
    NSArray *boxes = @[_consignee,_consigPhone,_address];
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

-(void)initSelectedItems{
    // 收货时间选择
    NSString*proname= [[ZTDataCenter sharedInstance] getProvinceNameByPid:[self.addre.province intValue ]];
    NSString*cityname= [[ZTDataCenter sharedInstance] getCityNameByCid:[self.addre.city intValue ]];
    NSString*area= [[ZTDataCenter sharedInstance] getAreaNameByAid:[self.addre.carea intValue ]];
    
    

    NSString*expresstime=nil;
  if (self.addre!=nil) {
  NSInteger idd=[self.addre.sendid integerValue];
  
    if (idd==0) {
        expresstime=@"所有时间";
       
        }else if(idd==1)
        {
           expresstime=@"工作日即可收货";

        }        else{
            expresstime = @"周六周日及节假日可收货";}
  }
            _expressDateSelectedBtn = [[ZTChoiceItem alloc] initWithTitle:@"收货时间:" content:expresstime tag:100];
    // 省份选择
    _provinceSelectedBtn = [[ZTChoiceItem alloc] initWithTitle:@"选择省份:" content:proname tag:101];
    // 城市选择
    _citySelectedBtn = [[ZTChoiceItem alloc] initWithTitle:@"选择城市:" content:cityname tag:102];
    // 选择区域
    _areaSelectedBtn = [[ZTChoiceItem alloc] initWithTitle:@"选择县/区:" content:area tag:103];
    
    NSArray *items = @[_expressDateSelectedBtn,_provinceSelectedBtn,_citySelectedBtn,_areaSelectedBtn];
    for (ZTChoiceItem *item in items) {
        item.choiseContentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [item.choiseContentBtn setTitleColor:[UIColor colorWithHex:0x313131] forState:UIControlStateNormal] ;
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseClicked)];
        [item.choiseContentBtn addTarget:self action:@selector(chooseClicked:) forControlEvents:UIControlEventTouchUpInside];
        item.choiseTitleLable.font = [UIFont systemFontOfSize:14.0];
        item.choiseTitleLable.textColor = [UIColor colorWithHex:0x656565];
        item.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        item.borderWidth = 1.0;
        item.indicatorRightMargin = 7.5;
        item.bottomBorder = YES;
    }
}

-(void)chooseClicked:(UIButton *)button{
self.btn = button;
//    switch (button.tag) {
//        case 100:
//            _expressDateSelectedBtn.choiseContentBtn.tag = button.tag;
//            break;
//            case 101:
//            _provinceSelectedBtn.choiseContentBtn.tag = button.tag;
//            break;
//            case 102:
//            _citySelectedBtn.choiseContentBtn.tag = button.tag;
//            break;
//            case 103:
//            _areaSelectedBtn.choiseContentBtn.tag = button.tag;
//            break;
//            
//        default:
//            break;
//    }
//_expressDateSelectedBtn.choiseContentBtn.tag = button.tag;

  ZTDataCenter *center = [[ZTDataCenter alloc]init];
    if (button.tag == 100) {
        UITableView *tpicker  = [[UITableView alloc]init];
        [self.view addSubview:tpicker];
        self.tpicker = tpicker;
        
        CGFloat tx = 10;
        CGFloat th = 81;
        CGFloat tw = self.view.frame.size.width - 2 * tx;
        CGFloat ty = 124;
        tpicker.frame = CGRectMake(tx, ty, tw, th);
        tpicker.separatorStyle = UITableViewCellSeparatorStyleNone;
        tpicker.delegate = self;
        tpicker.dataSource = self;
        tpicker.rowHeight = 27;
    }else if (button.tag == 101){
        NSArray *provinceArr = [center getProvinceList];
        

        self.provinceArr = provinceArr;
        UITableView *proPicker  = [[UITableView alloc]init];
        [self.view addSubview:proPicker];
        self.proPicker = proPicker;
        
        CGFloat px = 10;
        CGFloat pw = self.view.frame.size.width - 2 * px;
        CGFloat py = 124;
        CGFloat ph = 200;
        proPicker.frame = CGRectMake(px, py, pw, ph);
        proPicker.separatorStyle = UITableViewCellSeparatorStyleNone;
        proPicker.delegate = self;
        proPicker.dataSource = self;
        proPicker.rowHeight = 27;

        
    }else if (button.tag == 102){
       NSArray *cityArr = [center getCityListByProvinceId:[self.selectedprovonce._id intValue]];
        self.cityArr = cityArr;
        UITableView *cityPicker  = [[UITableView alloc]init];
        cityPicker.backgroundColor=[UIColor redColor];
        [self.view addSubview:cityPicker];
        self.cityPicker = cityPicker;
        if (self.cityArr.count==1) {
            CGFloat px = 10;
            CGFloat pw = self.view.frame.size.width - 2 * px;
            CGFloat py = 180;
            CGFloat ph = 50;
            cityPicker.frame = CGRectMake(px, py, pw, ph);
            cityPicker.separatorStyle = UITableViewCellSeparatorStyleNone;
            cityPicker.delegate = self;
            cityPicker.dataSource = self;
            cityPicker.rowHeight = 27;
            [cityPicker reloadData];
        }else{
        
        CGFloat px = 10;
        CGFloat pw = self.view.frame.size.width - 2 * px;
        CGFloat py = 124;
        CGFloat ph = 200;
       cityPicker.frame = CGRectMake(px, py, pw, ph);
       cityPicker.separatorStyle = UITableViewCellSeparatorStyleNone;
        cityPicker.delegate = self;
        cityPicker.dataSource = self;
        cityPicker.rowHeight = 27;
            [cityPicker reloadData];}
        

    }
    else if (button.tag==103){
        NSArray *areaArr = [center getAreaListByCityId:[self.selectcity._id intValue]];
        
      
        self.areaArr = areaArr;
        UITableView *areaPicker  = [[UITableView alloc]init];
        
        [self.view addSubview:areaPicker];
        self.areaPicker = areaPicker;
        self.areaPicker.backgroundColor=[UIColor redColor];
        CGFloat px = 10;
        CGFloat pw = self.view.frame.size.width - 2 * px;
        CGFloat py = 124;
        CGFloat ph = 200;
        areaPicker.frame = CGRectMake(px, py, pw, ph);
        areaPicker.separatorStyle = UITableViewCellSeparatorStyleNone;
       areaPicker.delegate = self;
        areaPicker.dataSource = self;
        areaPicker.rowHeight = 27;
    
    }
}

/**tableView代理和数据源方法*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.btn.tag == 100) {
        return 3;
    }else if (self.btn.tag == 101){
        return self.provinceArr.count;
    }else if (self.btn.tag == 102){
        return self.cityArr.count;
    }else{
        return self.areaArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *ID = @"address";
UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor grayColor];
    if (self.btn.tag == 100) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"所有时间";
                break;
            case 1:
                cell.textLabel.text = @"工作日即可收货";
                break;
            case 2:
                cell.textLabel.text = @"周六周日及节假日可收货";
            default:
                break;
        }
    }else if(self.btn.tag == 101){
    Province * province = self.provinceArr[indexPath.row];
   
    [_provinceSelectedBtn.choiseContentBtn setTitle:province.ProName forState:UIControlStateNormal];
    cell.textLabel.text = _provinceSelectedBtn.choiseContentBtn.titleLabel.text;
        }else if (self.btn.tag == 102){
        
            City * city = self.cityArr[indexPath.row];
            
            [_citySelectedBtn.choiseContentBtn setTitle:city.CityName forState:UIControlStateNormal];
            cell.textLabel.text = _citySelectedBtn.choiseContentBtn.titleLabel.text;
        
    }
    else if(self.btn.tag == 103)
    {   Area* area = self.areaArr[indexPath.row];
        
        [_areaSelectedBtn.choiseContentBtn setTitle:area.ZoneName forState:UIControlStateNormal];
        cell.textLabel.text = _areaSelectedBtn.choiseContentBtn.titleLabel.text;
    
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.btn.tag == 100) {
        NSString *timeChoice = [self.tpicker cellForRowAtIndexPath:indexPath].textLabel.text;
        self.senddid=[Sendid new];
        self.senddid._id=indexPath.row;
        [_expressDateSelectedBtn.choiseContentBtn setTitle:timeChoice forState:UIControlStateNormal];
        [self.tpicker removeFromSuperview];
        self.tpicker = nil;
    }else if (self.btn.tag == 101){
    
         NSString *provonceChoice = [self.proPicker cellForRowAtIndexPath:indexPath].textLabel.text;
         self.selectedprovonce=self.provinceArr[indexPath.row];
        
        [_provinceSelectedBtn.choiseContentBtn setTitle:provonceChoice forState:UIControlStateNormal];
        [self.proPicker removeFromSuperview];
        self.proPicker = nil;
    }else if (self.btn.tag == 102){
        NSString *cityChoice = [self.cityPicker cellForRowAtIndexPath:indexPath].textLabel.text;
        self.selectcity=self.cityArr[indexPath.row];
        
        [_citySelectedBtn.choiseContentBtn setTitle:cityChoice forState:UIControlStateNormal];
        [self.cityPicker removeFromSuperview];
        self.cityPicker = nil;
    
    
    }else if (self.btn.tag == 103){
    NSString *areaChoice = [self.areaPicker cellForRowAtIndexPath:indexPath].textLabel.text;
     self.selectarea=self.areaArr[indexPath.row];
    [_areaSelectedBtn.choiseContentBtn setTitle:areaChoice forState:UIControlStateNormal];
    [self.areaPicker removeFromSuperview];
    self.areaPicker = nil;
    
    }}

-(void)dealloc{
NSLog(@"deallo");
}


-(void)initDefaultBtn{
    _setDefaultBtn = [[ZTCheckButton alloc] initWithTitle:@"设为默认地址" ImageIcon:[UIImage imageNamed:@"btn_default_unCheck"] selected:[UIImage imageNamed:@"btn_default_check"] contentGap:10.0];
    _setDefaultBtn.bottomBorder = YES;
    _setDefaultBtn.borderWidth = 1.0;
    _setDefaultBtn.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    _setDefaultBtn.leftMarginGap = 9.0;
    [_setDefaultBtn setTitleColor:[UIColor colorWithHex:0x656565] forState:UIControlStateNormal];
    _setDefaultBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_setDefaultBtn  addTarget:self action:@selector(Tapmoren:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma layout views

-(void)viewDidLayoutSubviews{
    [_contentWrap setScreenWidth];
    [[[[_consignee fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:41.0];
    [[[[[_consigPhone fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectBelowOfView:_consignee] setRectHeight:35.0];
    [[[[[_expressDateSelectedBtn fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:35.0] setRectBelowOfView:_consigPhone];
    [[[[[_provinceSelectedBtn fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:35.0] setRectBelowOfView:_expressDateSelectedBtn];
    [[[[[_citySelectedBtn fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:35.0] setRectBelowOfView:_provinceSelectedBtn];
    [[[[[_areaSelectedBtn fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:35.0] setRectBelowOfView:_citySelectedBtn];
    [[[[[_address fitSize] setRectMarginLeft:9.0] widthToEndWithPadding:9.0] setRectHeight:55.0] setRectBelowOfView:_areaSelectedBtn];
    [[[[_setDefaultBtn fitSize] setScreenWidth] setRectHeight:35.0] setRectBelowOfView:_address];
    [[[_contentWrap wrapContents] setRectBelowOfView:_topLayout] setScreenWidth];
}

#pragma mark - helpers
-(void)initData{
    if (_addressId == -1) {
    
        isNewAddress = YES;
    }else{
    //NSLog(@"xiugaimougedizhi%lu  %@",self.addressId,self.addre);
    
    
        // TODO:根据地址id查询地址内容
    }
}
#pragma mark - net result delegate


-(void)requestUrl:(NSString *)request processParamsInBackground:(NSMutableDictionary *)params{
   
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDADDRESS]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_TURENAME:[NSString stringWithFormat:@"%@",[self getname]],
                                           NET_ARG_TEL:[NSString stringWithFormat:@"%@",[self gettel]],
                                           NET_ARG_ADDRESS:[NSString stringWithFormat:@"%@",[self getaddress]],
                                          NET_ARG_PROVINCE:[NSString stringWithFormat:@"%@",[self getprovince]],
                                             NET_ARG_CITY:[NSString stringWithFormat:@"%@",[self getcity]],
                                           NET_ARG_CAREA:[NSString stringWithFormat:@"%@",[self getcarea]],
                                           NET_ARG_SENDID:[NSString stringWithFormat:@"%@",[self getsendid]],                               NET_ARG_ZIPCODE:[NSString stringWithFormat:@"%@",[self getzipcode]],
                                           NET_ARG_ISDEF:[NSString stringWithFormat:@"%@",[self getisdef]],
                                           
        
        }];
        
    }
    else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_EDITADDRESS]]) {
    
        [params addEntriesFromDictionary:@{
                                           NET_ARG_UAIDEDIT:[NSString stringWithFormat:@"%@",self.addre.uaid],
                                           NET_ARG_TRUENAMEEDIT:[NSString stringWithFormat:@"%@",[self getname]],
                                           NET_ARG_TELEDIT:[NSString stringWithFormat:@"%@",[self gettel]],
                                           NET_ARG_ADDRESSEDIT:[NSString stringWithFormat:@"%@",[self getaddress]],
                                           NET_ARG_PROVINCEEDIT:[NSString stringWithFormat:@"%@",[self getprovince]],
                                           NET_ARG_CITYEDIT:[NSString stringWithFormat:@"%@",[self getcity]],
                                          NET_ARG_CAREAEDIT:[NSString stringWithFormat:@"%@",[self getcarea]],                               NET_ARG_ZIPCODEEDIT:[NSString stringWithFormat:@"%@",[self getzipcode]],
                                          NET_ARG_ISDEFEDIT:[NSString stringWithFormat:@"%@", [self getisdef]],
                                            NET_ARG_SENDIDEDIT:[NSString stringWithFormat:@"%@",[self getsendid]],
                                           }];

        

    }
    
    
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{

if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDADDRESS]])
{
  
}else if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_EDITADDRESS]])
    {
       
        
    }

    
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    alertShow(errmsg);
    [ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultSuccess:(id)result
{if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_ADDADDRESS]]) {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"地址添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil, nil];
    [alertView show];
    //    alertShow(@"添加地址成功");
    [ZTCoverView dissmiss];
}else
{if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_EDITADDRESS]]){


[self.navigationController popViewControllerAnimated:YES];
[ZTCoverView dissmiss];
}
}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 1:
            NSLog(@"用户选择了1");
            break;
        case 2:
            NSLog(@"用户选择了2");
            break;
        default:
            NSLog(@"用户选择了0");
            [self.navigationController popViewControllerAnimated:YES];
            //要发请求地址刷新我的地址数据
            break;
    }
}

#pragma mark - helpers
-(NSString*)getname{
NSString*truename=_consignee.textField.text;

return truename;
}
-(NSString*)gettel{
NSString*tel=_consigPhone.textField.text;
return tel;
}
-(NSString*)getaddress{
    NSString*address=_address.textField.text;
    return address;
}
-(NSNumber*)getprovince{
    if (isNewAddress) {
        NSNumber*province=self.selectedprovonce._id;
        return province;
    }else{
        if (self.selectedprovonce!=nil) {
            NSNumber*province=self.selectedprovonce._id;
            return province;
        }
    NSNumber*proedit=self.addre.province;
    return proedit;
    
    }
    }
-(NSNumber*)getcity{
    if (isNewAddress) {
        NSNumber*city=self.selectcity._id;
        return city;
    }else{
        if (self.selectcity!=nil) {
            NSNumber*city=self.selectcity._id;
            return city;
        }
        
    NSNumber*cityedit=self.addre.city;
    return cityedit;
    
    }
    
    
}
-(NSNumber*)getcarea{
    if (isNewAddress) {
        NSNumber*carea=self.selectarea._id;
        return carea;
    }else{
        if (self.selectarea!=nil) {
            NSNumber*carea=self.selectarea._id;
            return carea;
        }
    
    NSNumber*careaedit=self.addre.carea;
    return careaedit;
    }


}
-(NSNumber*)getsendid{
    NSInteger sendiid=self.senddid._id;

    return [NSNumber numberWithInteger:sendiid];

}
-(NSString*)getzipcode{
    
    return @"none";
}
-(NSString*)getisdef{
   
    return moren;
}
-(void)Tapmoren:(UIButton*)bt{
if(bt.selected)
{moren =@"1";
}else{

moren=@"0";
}


}
@end
