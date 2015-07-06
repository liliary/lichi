//
//  OrderViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "TeambuyOrderViewController.h"
#import "ZTTitleLabel.h"
#import "ZTSessionView.h"
#import "ZTRoundButton.h"
#import "ZTIconLabel.h"
#import "TeamBuyProduct.h"
#import "ChangeUserPhoneController.h"
#import "User.h"
#import "PurchaseViewController.h"

@interface TeambuyOrderViewController ()<ZTOrderProtocol>{
    TeamBuyProduct *_product;
    User* _user;
    CGFloat _totalPrice;
    NSInteger _totalCount;
    
    UIView* _topLayout;
    /// Price
    ZTSessionView* _checkoutCounterView;
    UILabel* _productName;
    UILabel* _priceIcon_top;
    UILabel* _price;
    UILabel* _countTitle;
    UITextField* _totalCountLabel;
    UILabel* _totalPriceTitle;
    UILabel* _totalPriceLabel;
    UILabel* _priceIcon_bottom;
    
    // phoneNumber
    ZTSessionView* _phoneBar;
    UILabel* _phoneTitle;
    UILabel* _phone;
    UIButton* _changePhoneBtn;
    
    UIButton* _substructionBtn;
    UIButton* _addBtn;
    
    ZTIconLabel* _guaranteeLabel;
    
    ZTSessionView* _payBar;
    UILabel* _orderTitle;
    UILabel* _orderPrice;
    UILabel* _priceIcon_order;
    ZTRoundButton* _createOrderBtn;
}

@end

@implementation TeambuyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTitleBar];
    [self buildViews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

-(void)viewDidLayoutSubviews{
    [[[_productName fitSize] setRectMarginLeft:10.0] setRectMarginTop:20.0];
    [[[_price fitSize] setRectMarginRight:10.0] setRectMarginTop:20.0];
    [[[_priceIcon_top fitSize] setRectMarginTop:24.0] setRectOnLeftSideOfView:_price];
    [[[[_countTitle fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_productName] addRectY:28.0];
    [[[[_totalPriceTitle fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_countTitle] addRectY:20.0];
    [[[[_substructionBtn fitSize] setRectMarginRight:10.0] setRectBelowOfView:_price] addRectY:20.0];
    [[[[[[_totalCountLabel fitSize] setRectWidth:45.0]
        setRectOnLeftSideOfView:_substructionBtn]
        setRectBelowOfView:_price]
        addRectX:-5.0]
        addRectY:22.0];
    [[[[[_addBtn fitSize]
       setRectOnLeftSideOfView:_totalCountLabel]
       setRectBelowOfView:_price]
       addRectX:-5.0]
       addRectY:20.0];
    [[[[_totalPriceLabel fitSize] setRectMarginRight:10.0] setRectBelowOfView:_totalCountLabel] addRectY:20.0];
    [[[[_priceIcon_bottom fitSize] setRectOnLeftSideOfView:_totalPriceLabel] setRectBelowOfView:_totalCountLabel] addRectY:24.0];
    [[[[_checkoutCounterView wrapContents] setScreenWidth] setRectBelowOfView:_topLayout] addRectHeight:30.0];

    [[[[_phoneBar setScreenWidth] setRectHeight:35.0] setRectBelowOfView:_checkoutCounterView] addRectY:8.0];
    [[[_phoneTitle fitSize] setRectMarginLeft:10.0] setRectCenterVertical];
    [[[_phone fitSize] setRectOnRightSideOfView:_phoneTitle] setRectCenterVertical];
    [[[_changePhoneBtn fitSize] setRectMarginRight:10.0] setRectCenterVertical];
    
    [[[[_guaranteeLabel fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_phoneBar] addRectY:10.0];
    
    [[[_payBar setScreenWidth] setRectHeight:50.0] setRectMarginBottom:0.0];
    [[[_orderTitle fitSize] setRectMarginLeft:10.0] setRectCenterVertical];
    
    [[[[_priceIcon_order fitSize]
        setRectOnRightSideOfView:_orderTitle]
        addRectX:5.0]
        setRectCenterVertical];
    [[[_orderPrice fitSize] setRectOnRightSideOfView:_priceIcon_order] setRectCenterVertical];
    [[[[_createOrderBtn fitSize] setRectWidth:142.5] setRectMarginRight:10.0] setRectCenterVertical];
    
}

#pragma mark - buildViews

-(void)initTitleBar{
    ZTTitleLabel* titleView = [[ZTTitleLabel alloc] initWithTitle:@"提交订单"];
    [titleView fitSize];
    self.navigationItem.titleView = titleView;
}

-(void)buildViews{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    
    _topLayout = (UIView*)self.topLayoutGuide;
    _checkoutCounterView = [ZTSessionView new];
    _checkoutCounterView.topBorder = YES;
    _checkoutCounterView.bottomBorder = YES;
    _checkoutCounterView.borderWidth = 1.0;
    
    _productName = [UILabel new];
    _productName.font = [UIFont systemFontOfSize:14.0];
    _productName.textColor = [UIColor colorWithHex:0x323232];
    
    _priceIcon_top = [UILabel new];
    _priceIcon_top.textColor = [UIColor redColor];
    _priceIcon_top.text =@"￥";
    _priceIcon_top.font = [UIFont systemFontOfSize:10.0];
    
    _price = [UILabel new];
    _price.font = [UIFont systemFontOfSize:14.0];
    _price.textColor = [UIColor redColor];
    
    _countTitle = [UILabel new];
    _countTitle.text = @"数量:";
    _countTitle.font = [UIFont systemFontOfSize:12.0];
    _countTitle.textColor = [UIColor colorWithHex:0x323232];
    
    _substructionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_substructionBtn setImage:[UIImage imageNamed:@"btn_sub"] forState:UIControlStateNormal];
    [_substructionBtn addTarget:self action:@selector(didTapSubBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(didTapAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _totalCountLabel = [UITextField new];
    _totalCountLabel.textAlignment = NSTextAlignmentCenter;
    _totalCountLabel.background = [UIImage imageNamed:@"bg_price"];
    _totalCountLabel.enabled = NO;
    
    _totalPriceTitle = [UILabel new];
    _totalPriceTitle.text = @"小计";
    _totalPriceTitle.font = [UIFont systemFontOfSize:12.0];
    
    _totalPriceLabel = [UILabel new];
    _totalPriceLabel.font = [UIFont systemFontOfSize:14.0];
    _totalPriceLabel.textColor = [UIColor redColor];
    
    _priceIcon_bottom = [UILabel new];
    _priceIcon_bottom.font = [UIFont systemFontOfSize:10.0];
    _priceIcon_bottom.textColor = [UIColor redColor];
    _priceIcon_bottom.text =@"￥";

    /// phoneBar
    _phoneBar = [ZTSessionView new];
    _phoneBar.topBorder = YES;
    _phoneBar.bottomBorder = YES;
    _phoneBar.borderWidth = 1.0;
    
    _phoneTitle = [UILabel new];
    _phoneTitle.text = @"手机:";
    _phoneTitle.font = [UIFont systemFontOfSize:12.0];
    _phoneTitle.textColor = [UIColor colorWithHex:0x333333];
    
    _phone = [UILabel new];
    _phone.textColor = [UIColor colorWithHex:0x646464];
    _phone.font = [UIFont systemFontOfSize:12.0];
    
    _changePhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changePhoneBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_changePhoneBtn setTitle:@"更换手机号" forState:UIControlStateNormal];
    [_changePhoneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_changePhoneBtn addTarget:self
                        action:@selector(didTapChangeUserPhone:) forControlEvents:UIControlEventTouchUpInside];
    _guaranteeLabel = [[ZTIconLabel alloc] initWithIcon:[UIImage imageNamed:@"icon_guarantee"] title:@"7天包退承诺"];
    _guaranteeLabel.contentGap = 10.0;
    
    _payBar = [ZTSessionView new];
    _payBar.topBorder = YES;
    _payBar.borderWidth = 1.0;
    
    _orderTitle = [UILabel new];
    _orderTitle.text = @"应付总价:";
    _orderTitle.font = [UIFont systemFontOfSize:12.0];
    
    _orderPrice = [UILabel new];
    _orderPrice.font = [UIFont systemFontOfSize:12.0];
    _orderPrice.textColor = [UIColor redColor];
    
    _priceIcon_order = [UILabel new];
    _priceIcon_order.textColor = [UIColor redColor];
    _priceIcon_order.text =@"￥";
    _priceIcon_order.font = [UIFont systemFontOfSize:10.0];
    
    _createOrderBtn = [[ZTRoundButton alloc] initWithTitle:@"提交订单" textcolor:[UIColor whiteColor] backgroundImage:[UIImage imageNamed:@"btn_buy"]];
    [_createOrderBtn addTarget:self  action:@selector(didTapCreateOrderBtn:) forControlEvents:UIControlEventTouchUpInside    ];
    
    [_checkoutCounterView addSubViews:@[_productName,_price,_priceIcon_top,_countTitle,_totalCountLabel,_substructionBtn,_addBtn,_totalPriceTitle,_totalPriceLabel,_priceIcon_bottom]];
    [_phoneBar addSubViews:@[_phoneTitle,_phone,_changePhoneBtn]];
    [_payBar addSubViews:@[_orderTitle,_orderPrice,_createOrderBtn,_priceIcon_order]];

    [self.view addSubViews:@[_checkoutCounterView,_phoneBar,_guaranteeLabel,_payBar]];
}

#pragma mark - on Click Events
-(void)didTapAddBtn:(UIButton*)btn{
    _totalCount += 1;
    [self updatePrice];
}

-(void)didTapSubBtn:(UIButton*)btn{
    if (_totalCount == 1) return;
    _totalCount -= 1;
    [self updatePrice];
}

-(void)didTapChangeUserPhone:(UIButton*)btn{
    ChangeUserPhoneController* controller = [ChangeUserPhoneController new];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)didTapCreateOrderBtn:(UIButton*)btn{
//    // TODO: 返回凭证再跳转到支付界面
    PurchaseViewController *controller = [PurchaseViewController new];
    [self.navigationController presentViewController:controller animated:YES completion:^{
        [self.tabBarController setSelectedViewController:[self.tabBarController.viewControllers lastObject]];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}
#pragma mark - helpers
-(void)initData{
    [self updateUserPhone:_user.mobile];
   _product = [[ZTDataCenter sharedInstance] getProductWithPid:_productId forType:CKEY_TEAMBUY];
   _user = [[ZTDataCenter sharedInstance] getCurrentUser];
   _totalCount = 1.0;
   _totalPrice = [_product.dj2 floatValue];
}

-(void)loadData{
    _productName.text = _product.cpmc;
    _price.text = [NSString stringWithFormat:@"%@",_product.dj2];
    [self updatePrice];
}

-(void)updatePrice{
    _totalPrice = _totalCount*[_product.dj2 floatValue];
    _totalCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_totalCount];
    _totalPriceLabel.text = [NSString stringWithFormat:@"%9.2f",_totalPrice];
    _orderPrice.text = [NSString stringWithFormat:@"%9.2f",_totalPrice];
    [self.view setNeedsLayout];
}

-(void)updateUserPhone:(NSString*)phone{
    _phone.text = phone;
}

@end
