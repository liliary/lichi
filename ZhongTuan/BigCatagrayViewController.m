//
//  BigCatagrayViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "BigCatagrayViewController.h"
#import "ZTButtonGridView.h"
#import "ZTTitleLabel.h"
#import "ZTButtonCell.h"
#import "dalei.h"
#import "ZTImageLoader.h"
#import "ZTCoverView.h"
#import "Girlclothes.h"
@interface BigCatagrayViewController ()<ZTButtonGridViewDelegate,NetResultProtocol>
{ZTButtonGridView * _cateGoryButton;
    ZTTitleLabel *titleview;
    UIView *topview;
      NSDictionary *_category_source;
    NSMutableArray *leibie;
    NSMutableArray*wenzi;
    NSMutableArray*pic;
    NSMutableArray*picc;
    ZTImageLoader*picture;
    }
@end

@implementation BigCatagrayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initdata];
    [self initTitleBar];
    [self initView];
       // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.tabBarController.tabBar.hidden=YES;
  self.navigationController.navigationBar.hidden=NO;
  [self loaddata];

}
-(void)initTitleBar{
titleview=[[ZTTitleLabel alloc]initWithTitle:@"大类"];
[titleview fitSize];
self.navigationItem.titleView=titleview;

}
-(void)initView{
 
 topview=(UIView*)self.topLayoutGuide;
 self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    _cateGoryButton = [[ZTButtonGridView alloc] initWithIcons:_category_source cell:@"ZTButtonCell" column:4 rowSpace:1.0 columnSpace:1.0 edgeSpace:1.0];
    NSLog(@"dadadada%@",_cateGoryButton);
    _cateGoryButton.tag=@"1";
    _cateGoryButton.bottomBorder = YES;
    _cateGoryButton.borderWidth = 1.0;
    _cateGoryButton.ztButtonViewDelegate=self;
   
    
             [self.view addSubview:_cateGoryButton];
 
}
-(void)didTapCollectionAtIndex:(NSIndexPath*)index{

        
        dalei*daleilei=leibie[index.row];
        Girlclothes*girlvc=[[Girlclothes alloc]init];
        girlvc.gril=daleilei.lbid;
        girlvc.lanamee=daleilei.lbname;
              
        [self.navigationController pushViewController:girlvc animated:YES];
    
    
    NSLog(@"首页哦hah%ld",(long)index.row);
    // [_ztButtonViewDelegate didTapCollectionAtIndex:indexPath];
}

-(void)viewDidLayoutSubviews{
[[[_cateGoryButton fitSize]setRectBelowOfView:topview]heightToEndWithPadding:0.0];
//[[_cateGoryButton wrapContents]setRectBelowOfView:topview];

}
-(void)initdata{
   
    _category_source=@{
                      @"icons": pic,
                      @"titles": wenzi,
    
    
    };
    
[self initView];
}
-(void)loaddata{
    // 获取特卖大类
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMLB] delegate:self cancelIfExist:YES ];
[ZTCoverView alertCover];

}
#pragma mark net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{

    NSLog(@"daleilei%@",result);
    NSArray *leibiee = [(NSArray*)result jsonParseToArrayWithType:[dalei class]];
    leibie=[NSMutableArray array];
     [leibie addObjectsFromArray:leibiee];
    wenzi=[NSMutableArray array];
    pic=[NSMutableArray array];
    for (int i=0; i<leibie.count; i++) {
        dalei*dl=leibie[i];
        wenzi[i]=dl.lbname;
        pic[i]=dl.icon;
        
    }
           [self initdata];
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{}
@end
