//
//  MyComment.h
//  ZhongTuan
//
//  Created by anddward on 15/5/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface MyComment : Model
@property(nonatomic,strong)NSString*cpmc;//评论标题
@property(nonatomic,strong)NSString*dateandtime;//评论时间
@property(nonatomic,strong)NSString*recmemo;//评论内容
@property(nonatomic,copy)NSNumber*dfen;//得分
@property(nonatomic,copy)NSString*recpic;//评论图片
-(float)getCommentcontentAndPicHeight;
@end
