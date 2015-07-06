//
//  CommentView.m
//  ZhongTuan
//
//  Created by anddward on 15/5/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

-(instancetype)initWithFrame:(CGRect)frame{
self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
return self;
}
-(void)initUI{
float with=320;
self.textview=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, with, 0)];
self.textview.userInteractionEnabled=NO;
self.textview.font=[UIFont systemFontOfSize:12];
self.textview.backgroundColor=[UIColor clearColor];

self.imageview=[[ZTImageLoader alloc]initWithFrame:CGRectMake(0, 0, with, 90)];
[self.imageview setContentMode: UIViewContentModeScaleAspectFit];
[self addSubViews:@[self.textview,self.imageview]];
}
-(void)layoutSubviews{
[super layoutSubviews];

 NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
 CGRect rect = [self.mycomment.recmemo boundingRectWithSize:CGSizeMake(320, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
 self.textview.frame=CGRectMake(0, 0, 320, rect.size.height+10);
 self.textview.text=self.mycomment.recmemo;
 
    if (![self.mycomment.recpic isEqualToString:@""]) {
    NSArray*pics=[self.mycomment.recpic componentsSeparatedByString:@"|"];
        self.imageview.hidden=NO;
        self.imageview.frame=CGRectMake(-20, self.textview.frame.size.height+10, 320, 90);
        [self.imageview setImageFromUrl:pics[0]];
    }else{
    self.imageview.hidden=YES;
    }
 }


@end
