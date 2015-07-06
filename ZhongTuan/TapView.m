//
//  TapView.m
//  ZhongTuan
//
//  Created by anddward on 15/5/7.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "TapView.h"
@interface TapView(){
id delegate;
SEL triggerMethod;

}
@end
@implementation TapView



-(instancetype)initWithFrame:(CGRect)frame{




    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapButton:)];
        [self addGestureRecognizer:gesture];
       // _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)buildViews{

        _pic=[ZTImageLoader new];
        _pic.backgroundColor=[UIColor whiteColor];
        [self addSubview:_pic];
        //[self layoutSubviews];

}
-(void)Icons:(NSString*)picurl{

  [self.pic setImageFromUrl:picurl];
  
self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
}
-(void)layoutSubviews{

    if ([self.tagg isEqualToString:@"zsa"]) {
         [[_pic setRectWidth:156] setRectHeight:166];
       self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
              }if ([self.tagg isEqualToString:@"zsb"]) {
            self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
        [[_pic setRectWidth:162] setRectHeight:83];
    }if ([self.tagg isEqualToString:@"zsc"]) {
   self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
         [[_pic setRectWidth:82] setRectHeight:82];
        
    }if ([self.tagg isEqualToString:@"zsd"]) {
     self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
        [[_pic setRectWidth:82] setRectHeight:82];
    }
 
}
#pragma mark - public methods

-(void)setTarget:(id)target trigger:(SEL)selector{
    delegate = target;
    triggerMethod = selector;
}
#pragma mark button click event

-(void)didTapButton:(UITapGestureRecognizer*)recognizer{
    if ([delegate respondsToSelector:triggerMethod]) {
        [delegate performSelector:triggerMethod withObject:self afterDelay:0];
    }
}



@end
