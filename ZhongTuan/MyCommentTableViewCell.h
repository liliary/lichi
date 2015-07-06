//
//  MyCommentTableViewCell.h
//  ZhongTuan
//
//  Created by anddward on 15/5/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
#import "ZTStarBar.h"
#import "CommentView.h"
#import "MyComment.h"
@interface MyCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)CommentView*comentview;
@property(nonatomic,strong)MyComment*mycomment;
@property(nonatomic,strong)UILabel*title;
@property(nonatomic,strong)UILabel*CommentDate;
@property(nonatomic,strong)ZTStarBar*startbar;
@property(nonatomic,strong)UIColor*Bordercolor;
@property(nonatomic,assign)BOOL Topborder;
@property(nonatomic,assign)BOOL BottomBorder;
@property(nonatomic,assign)CGFloat BorderWidth;

@end
