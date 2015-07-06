//
//  CommentCell.m
//  ZhongTuan
//
//  Created by anddward on 15/4/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "ZTSessionView.h"
#import "CommentCell.h"
@interface CommentCell(){
ZTSessionView *_infoGrup;           // 信息框

}
@end
@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildView];
        self.backgroundColor=[UIColor clearColor];
    }
return self;
}
-(void)buildView{
    _infoGrup = [ZTSessionView new];
    _infoGrup.topBorder = YES;
    _infoGrup.bottomBorder = YES;
    _infoGrup.borderWidth = 1.0;
   self.name= [[UILabel alloc] initWithFrame:CGRectZero];
   self.time=[[UILabel alloc]initWithFrame:CGRectZero];
    self.start=[[UILabel alloc]initWithFrame:CGRectZero];
    self.content=[[UITextView alloc]initWithFrame:CGRectZero];
    self.pic=[[ZTImageLoader alloc]initWithFrame:CGRectZero];
[_infoGrup addSubViews:@[self.name,self.time ,self.start,self.content,self.pic]];
[self addSubview:_infoGrup];
}
@end
