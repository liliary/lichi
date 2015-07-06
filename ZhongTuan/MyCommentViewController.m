//
//  MyCommentViewController.m
//  ZhongTuan
//
//  Created by anddward on 15/5/18.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "MyCommentViewController.h"
#import "ZTTitleLabel.h"
#import "ZTCoverView.h"
#import "MyComment.h"
#import "MyCommentTableViewCell.h"
@interface MyCommentViewController()<NetResultProtocol,UITableViewDataSource,UITableViewDelegate>
{
UIView*topview;
ZTTitleLabel*titlelabel;
UITableView*Commenttableview;
//data
NSMutableArray*CommentArr;
}
@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initTitle];
    [self initView];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{[super viewWillAppear:animated];
self.tabBarController.tabBar.hidden = YES;
self.navigationController.navigationBar.hidden=NO;
 [self initData];

}
-(void)initTitle{
titlelabel=[[ZTTitleLabel alloc]initWithTitle:@"我的评价"];
[titlelabel fitSize];
self.navigationItem.titleView=titlelabel;


}
-(void)initView{

self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"app_bg"]];
    topview=(UIView*)self.topLayoutGuide;
    [self initTableView];
    [self.view addSubview:Commenttableview];
    }

-(void)initTableView{
Commenttableview=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds]style:UITableViewStylePlain];
Commenttableview.showsHorizontalScrollIndicator=NO;
Commenttableview.showsHorizontalScrollIndicator=NO;
Commenttableview.delegate=self;
Commenttableview.dataSource=self;
Commenttableview.backgroundColor=[UIColor clearColor];
Commenttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
//Commenttableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
[Commenttableview registerClass:[MyCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)initData{
    [[ZTNetWorkUtilities sharedInstance] doPost:[NSString stringURLWithAppendex:NET_API_GETTMRECM_MY] delegate:self cancelIfExist:YES];
    [ZTCoverView alertCover];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  MyComment*comment=CommentArr[indexPath.row];
    NSLog(@"height%f",[comment getCommentcontentAndPicHeight]+60);
  return [comment getCommentcontentAndPicHeight]+60;
//return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
MyCommentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCommentTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];//会放入到队列中的
    }
cell.mycomment=CommentArr[indexPath.row];
cell.Topborder=YES;
cell.BottomBorder=YES;
cell.BorderWidth=3.0;
return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
return CommentArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
return 1;
}
#pragma net work
-(void)requestUrl:(NSString*)request resultSuccess:(id)result{
[ZTCoverView dissmiss];
[Commenttableview reloadData];
}
-(void)requestUrl:(NSString*)request resultFailed:(NSString*)errmsg{
[ZTCoverView dissmiss];
}
-(void)requestUrl:(NSString*)request processParamsInBackground:(NSMutableDictionary*)params{
}
-(void)requestUrl:(NSString*)request processResultInBackground:(id)result{

NSLog(@"comment%@",result);

    if ([request isEqualToString:[NSString stringURLWithAppendex:NET_API_GETTMRECM_MY]])
    {
    
        NSArray *commentarr = [(NSArray*)result jsonParseToArrayWithType:[MyComment class]];
        MyComment*a=CommentArr[0];
        NSLog(@"aa%@bb",a.recpic);
        CommentArr=[NSMutableArray array];
        [CommentArr removeAllObjects];
        [CommentArr addObjectsFromArray:commentarr];
        NSLog(@"dai%@daishouhuo",CommentArr);}


}
@end
