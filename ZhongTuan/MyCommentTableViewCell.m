//
//  MyCommentTableViewCell.m
//  ZhongTuan
//
//  Created by anddward on 15/5/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "MyCommentTableViewCell.h"

@implementation MyCommentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buidview];
        self.backgroundColor=[UIColor clearColor];
    }
return self;
}
-(void)buidview{
self.comentview=[[CommentView alloc]initWithFrame:CGRectZero];
self.title=[UILabel new];

    self.title.font = [UIFont systemFontOfSize:10.0];
    //self.title.textColor = [UIColor colorWithHex:0x333333];
     self.title.textColor=[UIColor redColor];
    
self.startbar=[ZTStarBar new];

self.CommentDate=[UILabel new];

    self.CommentDate.font = [UIFont systemFontOfSize:16.0];
    self.CommentDate.textColor = [UIColor colorWithHex:0x333333];
[self addSubViews:@[self.comentview,self.startbar,self.CommentDate,self.title]];
}
-(void)layoutSubviews{
  self.title.text=self.mycomment.cpmc;
self.CommentDate.text=self.mycomment.dateandtime;
self.comentview.mycomment=self.mycomment;
    [[[self.title fitSize]setRectMarginTop:8.0]setRectMarginLeft:10];
    [[[self.startbar fitSize]setRectMarginTop:5.0]setRectMarginRight:7];
    [[[self.CommentDate fitSize]setRectMarginBottom:8.0]setRectMarginRight:10];
    self.comentview.frame=CGRectMake(7, 15, 320, [self.mycomment getCommentcontentAndPicHeight]);
   //  self.comentview.backgroundColor=[UIColor grayColor];
    NSLog(@"qaqaqaq%@",self.comentview);
    [self.comentview setNeedsLayout];
    
    
}
-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _Bordercolor.CGColor);
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_BorderWidth);
    if (_Topborder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_BorderWidth) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
}

@end
