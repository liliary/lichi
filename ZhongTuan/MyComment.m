//
//  MyComment.m
//  ZhongTuan
//
//  Created by anddward on 15/5/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "MyComment.h"

@implementation MyComment
-(float)getCommentcontentAndPicHeight{
float height=0;
float width=320;
    CGRect frame=[self.recmemo boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil];
height+=frame.size.height;
    if (![self.recpic isEqualToString:@""]) {
        height+=110;
    }
return height;
}
@end
