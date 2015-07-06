//
//  Adesview.m
//  ZhongTuan
//
//  Created by anddward on 15/5/12.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Adesview.h"

@interface Adesview(){
    id delegate;
    SEL triggerMethod;
}
@end
@implementation Adesview
-(instancetype)initWithFrame:(CGRect)frame Withpicurl:(NSString*)picurl{
    
    

    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapButton:)];
        [self addGestureRecognizer:gesture];
        // _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        self.backgroundColor = [UIColor whiteColor];
        [self.pic setImageFromUrl:picurl];
        self.pic.frame=frame;
        self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
    }
    return self;
}

-(void)buildViews{
    
    _pic=[ZTImageLoader new];
    _pic.backgroundColor=[UIColor whiteColor];
    [self addSubview:_pic];
    
}
//-(void)layoutSubviews{
//
//    if ([self.tagg isEqualToString:@"zsa"]) {
//        [[_pic setRectWidth:156] setRectHeight:166];
//    }if ([self.tagg isEqualToString:@"zsb"]) {
//        [[_pic setRectWidth:162] setRectHeight:83];
//    }if ([self.tagg isEqualToString:@"zsc"]) {
//        [[_pic setRectWidth:82] setRectHeight:82];
//    }if ([self.tagg isEqualToString:@"zsd"]) {
//        [[_pic setRectWidth:82] setRectHeight:82];
//    }
//    
//}
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
