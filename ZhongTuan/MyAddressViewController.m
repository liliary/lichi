//
//  MyAddressViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// TODO: 修改地址按钮颜色

#import "MyAddressViewController.h"
#import "ZTTitleLabel.h"
#import "ZTItemButton.h"
#import "AddressAlterViewController.h"
#import "MyaddCell.h"
#import "ZTCoverView.h"
#import "Address.h"
#import "ZTDataCenter.h"

@interface MyAddressViewController ()<UITableViewDataSource,UITableViewDelegate,NetResultProtocol>{
    UIView *_topLayout;
    // title bar
    ZTTitleLabel* _titleView;
    // tableView
    UITableView *_addressListView;
    // header view
    UIView *_headerView;
    ZTItemButton *_newAddBtn;
    // Data
    NSMutableArray *_address;
    NSNumber*selectcell;
    NSNumber*delteaddressuaid;
}

@end

@implementation MyAddressViewController

- (void)viewDidLoad {

       [super viewDidLoad];
       [self initTitleBar];
       [self initViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    self.tabBarController.tabBar.hidden = YES;
    [self initData];
}

#pragma mark - buildViews

-(void)initViews{
//self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editContact:)];
    _topLayout = (UIView*)self.topLayoutGuide;
    [self initTableView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.view addSubview:_addressListView];
}

-(void)editContact:(UIBarButtonItem *)sender{
    
    [_addressListView setEditing:!_addressListView.editing animated:YES];
    sender.title=_addressListView.editing?@"确定":@"编辑";
    
}
-(void)initTableView{
_addressListView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];

    //_addressListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _addressListView.showsHorizontalScrollIndicator = NO;
    _addressListView.showsVerticalScrollIndicator = NO;
    _addressListView.delegate = self;
    _addressListView.dataSource = self;
    _addressListView.backgroundColor = [UIColor clearColor];
    _addressListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // init headerView
    [self initTableHeaderView];
    _addressListView.tableHeaderView = _headerView;
    
    [_addressListView registerClass:[MyaddCell class] forCellReuseIdentifier:@"cell"];
}

-(void)initTableHeaderView{
    _headerView = [UIView new];
    _headerView.backgroundColor = [UIColor clearColor];
    
    // init & add "newAddressBtn"
    [self initNewAddressBtn];
    [_headerView addSubview:_newAddBtn];
    
    // layout
    [self layoutTableHeaderView];
}

-(void)initNewAddressBtn{
    _newAddBtn = [[ZTItemButton alloc] initWithTitle:@"新增地址"];
    _newAddBtn.topBorder = YES;
    _newAddBtn.bottomBorder = YES;
    _newAddBtn.borderWidth = 1.0;
    _newAddBtn.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    _newAddBtn.backgroundColor = [UIColor whiteColor];
    _newAddBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _newAddBtn.indicatorRightPadding = 15.0;
    _newAddBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15.0, 0, 0);
    [_newAddBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_newAddBtn addTarget:self action:@selector(didTapNewAddBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"我的地址"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

#pragma mark - layout views

-(void)layoutTableHeaderView{
    [[_headerView setScreenWidth] setRectHeight:83.0];
    [[[_newAddBtn setScreenWidth] setRectHeight:45.0] setRectCenterVertical];
}

//-(void)viewDidLayoutSubviews{
//    [[[_addressListView setScreenWidth] setRectBelowOfView:_topLayout] heightToEndWithPadding:0.0];
//}

#pragma mark - tableview Delegate

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
NSLog(@"celldegaoma");
    return 154.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyaddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
         cell = [[MyaddCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];//会放入到队列中的
    }
        NSInteger row = [indexPath row];
    UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(250, 50, 30, 30)];
    [bt setTitle:@"选" forState:UIControlStateNormal];
    bt.backgroundColor=[UIColor grayColor];
    if ([self.ttag isEqualToString:@"order"]) {
        [cell._infoGrup addSubview:(UIView*)bt];
    }
    bt.tag=row;
    [bt addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
   
    Address *address = _address[row];
    delteaddressuaid=address.uaid;
    NSString*proname= [[ZTDataCenter sharedInstance] getProvinceNameByPid:[address.province intValue ]];
    NSString*cityname= [[ZTDataCenter sharedInstance] getCityNameByCid:[address.city intValue ]];
    NSString*area= [[ZTDataCenter sharedInstance] getAreaNameByAid:[address.carea intValue ]];
    cell.consignee.text = address.truename;
       cell.consigPhone.text = [address.tel stringValue];
    cell.province.text = proname;
    cell.city.text=cityname;
    cell.area.text=area;
    cell.address.text = address.address;
    NSInteger sendtime=[address.sendid  integerValue];
    if (sendtime==0) {
        cell.expressDate.text=@"所有时间";
        
    }else if(sendtime==1)
    {
    cell.expressDate.text=@"工作日即可收货";
    }
    else
    cell.expressDate.text = @"周六周日及节假日可收货";
    
    // addgesture
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPressGR.numberOfTouchesRequired = 1;
    longPressGR.minimumPressDuration =0.5;
    longPressGR.allowableMovement = 10.0f;
    [cell addGestureRecognizer:longPressGR];
    
   selectcell= [NSNumber numberWithLong:[indexPath row]];
    
      NSLog(@"1celldegao%f",cell._infoGrup.frame.size.height);
    return cell;
}
-(void)onclick:(UIButton*)sender
{    NSLog(@"qqqqqqqqqqqqqqqqqqqqqqqqq%ld", (long)sender.tag);
    self.delegate.reviseaddress=[[Address alloc]init];
    self.delegate.reviseaddress=_address[sender.tag];
    NSLog(@"cacacaca%@",self.delegate.reviseaddress.truename);
    
    //SaleOrderViewController*vc=[[SaleOrderViewController alloc]init];
    //[self.navigationController popToViewController:vc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)longPress:(UILongPressGestureRecognizer*)press{

    if (press.state == UIGestureRecognizerStateEnded) {
        
        return;
        
    } else if (press.state == UIGestureRecognizerStateBegan) {
        
        
        NSLog(@"长按手势");
        UIAlertView*deleaddress=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除地址？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil, nil];
        [deleaddress show];
        //TODO
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
            //delete address
            [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_DELTE_ADDRESS] delegate:self cancelIfExist:YES];
            
            [ZTCoverView alertCover];
          
            break;
        
        default:
            NSLog(@"取消1");
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _address.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressAlterViewController *con = [AddressAlterViewController new];
    con.addressId = [indexPath row];
    con.addre=_address[con.addressId];
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - onClick Events
-(void)didTapNewAddBtn:(UIButton*)btn{
    AddressAlterViewController *con = [AddressAlterViewController new];
    con.addressId = -1;
    NSLog(@" go to addressalterviewcontroller");
    [self.navigationController pushViewController:con animated:YES];
}
#pragma edit cell


#pragma mark - status Events


-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params
{if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_DELTE_ADDRESS]]) {
    [params addEntriesFromDictionary:@{NET_ARG__UAID:delteaddressuaid}];
    NSLog(@"%@tap uaid",delteaddressuaid);


}
}

-(void)requestUrl:(NSString *)request processResultInBackground:(id)result{
NSLog(@"%@result",result);
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_DELTE_ADDRESS]]) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_MY_ADDRESS_ALL] delegate:self cancelIfExist:YES];
        
        [ZTCoverView alertCover];
        
    }
    else{
    NSLog(@"addreqq%@addreqq",result);
    NSArray *addresses = [(NSArray*)result jsonParseToArrayWithType:[Address class]];
    _address=[NSMutableArray array];
    [[ZTDataCenter sharedInstance] saveUserAddresses:addresses];
    [_address removeAllObjects];
   [_address addObjectsFromArray:addresses];
     NSLog(@"111111q%@",addresses);
        NSLog(@"111111q%@",_address);}
   // [_address addObjectsFromArray:[[ZTDataCenter sharedInstance] getUserAddresses]];
}

-(void)requestUrl:(NSString *)request resultFailed:(NSString *)errmsg{
    [ZTCoverView dissmiss];
    alertShow(errmsg);
}

-(void)requestUrl:(NSString *)request resultSuccess:(id)result{
    [ZTCoverView dissmiss];
    [_addressListView reloadData];
}



#pragma mark - helpers
-(void)initData{
////    _address = [NSMutableArray arrayWithArray:[[ZTDataCenter sharedInstance] getUserAddresses]];
////    NSLog(@" address in  cache %ld %@",_address.count,_address);
//   
//    if (_address.count == 0) {
   

        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_MY_ADDRESS_ALL] delegate:self cancelIfExist:YES];
        NSLog(@"11111111111");
                        [ZTCoverView alertCover];
//    }
}

@end
