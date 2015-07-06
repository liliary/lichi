//
//  ZTCheckButton.m
//  ZhongTuan
//
//  Created by anddward on 15/2/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTCheckButton.h"
@interface ZTCheckButton(){
    BOOL isSelected;
}
@end

@implementation ZTCheckButton

-(id)initWithTitle:(NSString*)title ImageIcon:(UIImage*)icon selected:(UIImage *)selIcon contentGap:(CGFloat)gap{
    if (self = [self init]) {
        _icon = icon;
        _contentGap = gap;
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:_icon forState:UIControlStateNormal];
        [self setImage:selIcon forState:UIControlStateSelected];
        self.tintColor = [UIColor colorWithHex:0xe9e9e9];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
}

#pragma mark - build views

-(instancetype)init{
    if (self = [super init]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - layouts

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
   CGRect rect = [self titleRectForContentRect:contentRect];
   return CGRectMake(CGRectGetMaxX(rect)+_contentGap,
                     (CGRectGetMaxY(contentRect)-_icon.size.height)/2.0,
                     _icon.size.width,
                     _icon.size.height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect rect =  [super titleRectForContentRect:contentRect];
    rect.origin.x = _leftMarginGap;
    return rect;
}

#pragma mark - onClick Events

-(void)didTapButton{
    if (!isSelected) {
        isSelected = YES;
        self.selected = YES;
    }else{
        isSelected = NO;
        self.selected = NO;
    }
}



@end
