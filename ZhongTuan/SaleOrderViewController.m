//
//  SaleOrderViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "SaleOrderViewController.h"
#import "TeMaiProduct.h"
#import "MyAddressViewController.h"
#import "ZTNetWorkUtilities.h"
#import "ZTCoverView.h"
@interface SaleOrderViewController ()<NetResultProtocol>{
    UIView *_topLayout;
    // data
    TeMaiProduct* _product;
    NSInteger count;
    CGFloat price;
    
}

@end

@implementation SaleOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self initTitleBar];
    
    [self initViews];
    //[self loadData];

    NSLog(@"%@ha%@ha%@",self.reviseaddress.truename,[self.reviseaddress.tel stringValue],self.reviseaddress.address);
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadData];
      if (self.reviseaddress==nil) {
        NSLog(@"%@oooooooooooooo",self.reviseaddress);
        
       _addItem.nameLabel.text = @"                  ";
        _addItem.phoneLabel.text = @"                                  ";
        _addItem.addLabel.text = @"                    点击新增地址";
    }
    else{
        _addItem.nameLabel.text =self.reviseaddress.truename;
        
        _addItem.phoneLabel.text = [self.reviseaddress.tel stringValue];
        _addItem.addLabel.text =self.reviseaddress.address;
    }
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark - build views
-(void)initTitleBar{
    _titleView = [[ZTTitleLabel alloc] initWithTitle:@"提交订单"];
    [_titleView fitSize];
    self.navigationItem.titleView = _titleView;
}

-(void)initViews{
    _topLayout = (UIView*)self.topLayoutGuide;
    _productItem = [ZTProductItem new];
    [self initNumberItem];
    [self initAddItem];
    [self initBuyItem];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    [self.view addSubViews:@[_addItem,_productItem,_numberItem,_buyItem]];
    
    
    UITapGestureRecognizer*revisetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaddress)];
    revisetap.numberOfTapsRequired=1;
    [_addItem addGestureRecognizer:revisetap];
    
    
    //    _addItem.nameLabel.text = @"小宋";
    //    _addItem.phoneLabel.text = @"13620901006";
    //    _addItem.addLabel.text = @"黄埔大道西中山三路33号瑞达大厦15b";
    
    
}



-(void)tapaddress
{
    NSLog(@"dianjil");
    MyAddressViewController*MyAddress=[[MyAddressViewController alloc]init];
    MyAddress.ttag=@"order";
    MyAddress.delegate=self;
    [self.navigationController pushViewController:MyAddress animated:YES];
}

-(void)initNumberItem{
    _numberItem = [ZTNumberItem new];
    _numberItem.backgroundColor=[UIColor whiteColor];
    __weak id safeSelf = self;
    NSNumber __weak*time=self.buynumbers;
    _numberItem.didTapAddBtn = ^(){
                 NSLog(@"cout%@cout",time);
        if ([time intValue]) {
            if (count>=[time integerValue])
            {
                NSString*mess=@"已达到最大购买量";
                alertShow(mess);
        
            }
        }
             else{
               NSLog(@"cout");
                   [safeSelf onClickAddBtn];}
    };
    _numberItem.didTapSubBtn = ^(){
        [safeSelf onClickSubBtn];
    };
}

-(void)initAddItem{
    _addItem = [ZTAddressItem new];
    _addItem.leftPadding = 11.0;
    _addItem.lineGap = 13.0;
    _addItem.contentGap = 9.0;
    _addItem.indicatorRightPadding = 15.0;
    _addItem.borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    _addItem.borderWidth = 1.0;
    _addItem.backgroundColor = [UIColor colorWithHex:0xfbfbfb];
}

-(void)initBuyItem{
    _buyItem = [ZTBuyItem new];
    __weak id safeSelf = self;
    _buyItem.didTapOrder = ^(){
        [safeSelf onClickOrderBtn];
    };
}
#pragma mark - layout views

-(void)viewDidLayoutSubviews{
    [[[_productItem setScreenWidth] setRectHeight:80.0] setRectBelowOfView:_topLayout];
    [[[[_numberItem setScreenWidth] setRectHeight:80.0] setRectBelowOfView:_productItem] addRectY:10.0];
    [[[[_addItem setScreenWidth] setRectHeight:65.0] setRectBelowOfView:_numberItem] addRectY:10.0];
    [[[[_buyItem setScreenWidth] setRectHeight:60.0] setRectBelowOfView:_addItem] addRectY:10.0];
}

-(void)initData{
    _product = [[ZTDataCenter sharedInstance] getProductWithPid:_productId forType:CKEY_TE_MAI];
    NSLog(@"product%@product",_product.shopid);
    count = 1;
    price = [_product.tmdj floatValue];
}

-(void)loadData{
    _productItem.title.text = _product.title;
    [_productItem.pic setImageFromUrl:_product.picurl];
    NSString*tedjj=[NSString stringWithFormat:@"%@",_product.tmdj];
        _productItem.price.text  =tedjj;
    _numberItem.countLabel.text = @"1";
    _numberItem.kc.text = @"50";
    _buyItem.total.text = @"1";
    _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",price];
    if (_product==nil) {
        NSLog(@"dashab");
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETATEMAI] delegate:self cancelIfExist:YES ];
        _productItem.title.text =@"setrdhftxgfdzszfxghcnbvcxzxcbvvxczxSAgdvxczcnvcxv";
         _buyItem.totalPrice.text=@"00000000000";
        _productItem.price.text  =@"1233456789";
        [ZTCoverView alertCover];
    }
    
    
}

#pragma mark - onClick Events
/**
 点击下单按钮
 */
-(void)onClickOrderBtn{
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.reviseaddress.uaid!=nil&&count>0) {
        [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER] delegate:self cancelIfExist:YES];
        
        [ZTCoverView alertCover];
    }
    else{
        
        alertShow(@"地址未设置或数量为空");
    }
}

/**
 点击加按钮
 */
-(void)onClickAddBtn{
    count ++;
       _numberItem.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.total.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",count*price];
    [_buyItem setNeedsLayout];
    [_buyItem layoutIfNeeded];
}

/**
 点击减按钮
 */
-(void)onClickSubBtn{
    if (count != 1) {
        count --;
    }
    _numberItem.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.total.text = [NSString stringWithFormat:@"%ld",(long)count];
    _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",count*price];
    [_buyItem setNeedsLayout];
    [_buyItem layoutIfNeeded];
}
# pragma mark  net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result
{
    if([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI]]){
    
        _productItem.title.text = _product.title;
        [_productItem.pic setImageFromUrl:_product.picurl];
        NSString*tedjj=[NSString stringWithFormat:@"%@",_product.tmdj];
        _productItem.price.text  =tedjj;
        
        _numberItem.countLabel.text = @"1";
        _numberItem.kc.text = @"50";
        _buyItem.total.text = @"1";
       
        _buyItem.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",price];
    
           }
  else if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER]])
{self.ordernumber=[result objectForKey:@"ordno"];
    //NSArray*num=[self.ordernumber componentsSeparatedByString:@" = "];
    NSLog(@"%@dindan",self.ordernumber);
    PurchaseViewController*purchaseviewcontroller=[[PurchaseViewController alloc]init];
    purchaseviewcontroller.paymoney=[ NSNumber  numberWithFloat:[ _product.tmdj floatValue] *count];
    purchaseviewcontroller.payproduct=_product;
    purchaseviewcontroller.ordno=self.ordernumber;
    [self.navigationController pushViewController:purchaseviewcontroller animated:YES];}
    
    [ZTCoverView dissmiss];
    
   }
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result
{if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER]])
{ NSLog(@"wwq%@wwq",result);}
  if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI] ])
  {     NSLog(@"wwq%@wwq",result);
  _product=[[TeMaiProduct alloc]init];
      _product.picurl=[result objectForKey:@"picurl"];
      
      _product.tmdj=[result objectForKey:@"tmdj"];
      
      _product.title=[result objectForKey:@"title"];
        _product.tmid=[result objectForKey:@"tmid"];
      _product.shopid=[result objectForKey:@"shopid"];
      
      
      
      count = 1;
      price = [_product.tmdj floatValue];
    
      
      

  }

}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg
{
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params
{
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_CREATE_ORDER]]) {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_ADDRESSIDD:[self getaddressuid],
                                           NET_ARG_SENDIDD:[self getsendidd],
                                           NET_ARG_INVOICE:[self getinvoice],
                                           NET_ARG_LNGO:[self getlngo],
                                           NET_ARG_LATO:[self getlato],
                                           NET_ARG_SHOPIDD:[self getshopidd],
                                           NET_ARG_SPSU:[self getshangpingshuju],
                                                                                                                     }];
        
        
    }
    
    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETATEMAI] ])
    {
        [params addEntriesFromDictionary:@{
                                           NET_ARG_TEMAI_TMID:[NSString stringWithFormat:@"%@",self.productId],                                                                          }];
    }

}
-(NSNumber*)getaddressuid
{
    
    
    return self.reviseaddress.uaid;
    
}
-(NSNumber*)getsendidd
{
    return [NSNumber numberWithInt:100];
}
-(NSNumber*)getinvoice
{
    return [NSNumber numberWithInt:100];
}
-(NSNumber*)getlngo
{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"long"];
    
}
-(NSNumber*)getlato
{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
}
-(NSNumber*)getshopidd{
    
    return _product.shopid;
}
-(NSString*)getshangpingshuju
{
    NSArray*keys=[[NSArray alloc]initWithObjects:@"sl",@"cpmc",@"je",@"cppic", @"dj",@"cm",nil];
    NSArray*values=[[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:count],_product.title,[ NSNumber  numberWithFloat:[ _product.tmdj floatValue] *count],_product.picurl,_product.tmdj,[NSString stringWithFormat:@"%@",self.cimaid], nil];
    NSDictionary*spxq=[[NSDictionary alloc]initWithObjects:values forKeys:keys];
    
    NSMutableDictionary*sp=[[NSMutableDictionary alloc]init];
    //[sp setObject:spxq forKey:[_product.tmid stringValue]];
    [sp setObject:spxq forKey:[NSString stringWithFormat:@"%@",_product.tmid]];
    NSMutableDictionary*sd=[[NSMutableDictionary alloc]init];
    //[sd setObject:sp forKey:[_product.shopid stringValue]];
    [sd setObject:sp forKey:[NSString stringWithFormat:@"%@",_product.shopid]];
    NSData*jsondata=[NSJSONSerialization dataWithJSONObject:sd options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@sb ",[[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding]);
    
    return [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
}



@end
