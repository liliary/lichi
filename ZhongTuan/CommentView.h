//
//  CommentView.h
//  ZhongTuan
//
//  Created by anddward on 15/5/21.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyComment.h"
#import "ZTImageLoader.h"
@interface CommentView : UIView
@property(nonatomic,strong)MyComment*mycomment;
@property(nonatomic,strong)UITextView*textview;
@property(nonatomic,strong)ZTImageLoader*imageview;
@end
