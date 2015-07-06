//
//  UIView+ZTFundationAddiction.m
//  ZhongTuan
//
//  Created by anddward on 15/2/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "UIView+ZTFundationAddiction.h"
#import <objc/runtime.h>

@implementation UIView (ZTFundationAddiction)

#pragma mark - add Views

// 添加子 views
-(void)addSubViews:(NSArray*)views{
    for (UIView *v  in views) {
        [self addSubview:v];
    }
}

#pragma mark - autoLayout

/**
 short hand for addContraints to view
 */
-(void)constraints:(NSString*)vsfm opt:(NSLayoutFormatOptions)opt metrics:(NSDictionary*)mts vs:(NSDictionary*)vs{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vsfm options:opt metrics:mts views:vs]];
}

/**
 short hand for add constraints from array
 */
-(void)constraintsFromArray:(NSArray*)vsfms opt:(NSLayoutFormatOptions)opt metrics:(NSDictionary*)mts vs:(NSDictionary*)vs{
    for (NSString *vsfm in vsfms) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vsfm options:opt metrics:mts views:vs]];
    }
}

#pragma mark - setRectPosition

/**
 设置x偏移量
 */
-(UIView*)setRectX:(float)x{
    self.center = CGPointMake(x+CGRectGetMidX(self.bounds), self.center.y);
    return self;
}

/**
 设置y偏移量
 */
-(UIView*)setRectY:(float)y{
    self.center = CGPointMake(self.center.x, y+CGRectGetMidY(self.bounds));
    return self;
}

/**
 设置view相对父控件居中
 */
-(UIView*)setRectCenterInParent{
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), CGRectGetMidY(self.superview.bounds));
    return self;
}

/**
 设置veiw相对于父控件水平居中
 */
-(UIView*)setRectCenterHorizentail{
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), self.center.y);
    return self;
}

/**
 设置view相对于父控件垂直居中
 */
-(UIView*)setRectCenterVertical{
    self.center = CGPointMake(self.center.x, CGRectGetMidY(self.superview.bounds));
    return self;
}

/**
 设置view相对于父控件左margin
 */
-(UIView*)setRectMarginLeft:(float)width{
    self.center = CGPointMake(width+CGRectGetMidX(self.bounds),self.center.y);
    return self;
}

/**
 设置view相对于父控件右margin
 */
-(UIView*)setRectMarginRight:(float)width{
    self.center = CGPointMake(CGRectGetMaxX(self.superview.bounds)-width-CGRectGetMidX(self.bounds), self.center.y);
    return self;
}

/**
 设置view相对于父控件底部margin
 */
-(UIView*)setRectMarginBottom:(float)width{
    self.center = CGPointMake(self.center.x, CGRectGetMaxY(self.superview.bounds)-width-CGRectGetMidY(self.bounds));
    return self;
}

/**
 设置view相对于父控件顶部margin
 */
-(UIView*)setRectMarginTop:(float)width{
    self.center = CGPointMake(self.center.x, width+CGRectGetMidY(self.bounds));
    return self;
}

/**
 x的值在原基础上调整x距离
 */
-(UIView *)addRectX:(float)x{
    self.center = CGPointMake(self.center.x+x, self.center.y);
    return self;
}

/**
 y的值在原基础上调整y距离
 */
-(UIView *)addRectY:(float)y{
    self.center = CGPointMake(self.center.x, self.center.y+y);
    return self;
}

/**
 设置View的位置在component底下
 */
-(UIView*)setRectBelowOfView:(UIView*)component{
    self.center = CGPointMake(self.center.x,CGRectGetMaxY(component.frame)+CGRectGetMidY(self.bounds));
    return self;
}

/**
 设置view的位置在component左边
 */
-(UIView*)setRectOnLeftSideOfView:(UIView*)component{
    self.center = CGPointMake(CGRectGetMinX(component.frame)-CGRectGetMidX(self.bounds), self.center.y);
    return self;
}

/**
 设置view的位置在component的右边
 */
-(UIView*)setRectOnRightSideOfView:(UIView*)component{
    self.center = CGPointMake(CGRectGetMaxX(component.frame)+CGRectGetMidX(self.bounds), self.center.y);
    return self;
}

/**
 设置view的位置在component的上面
 */
-(UIView*)setRectOnTopOfView:(UIView*)component{
    self.center = CGPointMake(self.center.x, CGRectGetMinY(component.frame)-CGRectGetMidY(self.bounds));
    return self;
}

/**
 设置view的位置水平居中与某component
 */
-(UIView *)setCenterOfViewHorizentail:(UIView *)component{
    self.center = CGPointMake(CGRectGetMidX(component.frame), self.center.y);
    return self;
}

/**
 设置view的垂直居中与其中某component
 */
-(UIView *)setCenterOfViewVertical:(UIView *)component{
    self.center = CGPointMake(self.center.x, CGRectGetMidY(component.frame));
    return self;
}

#pragma mark - setRectSize

/**
    Resizes and moves the receiver view so it just encloses its subviews.
 */
-(UIView*)fitSize{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)self;
        [label sizeToFit];
        NSDictionary *attr = @{NSFontAttributeName:label.font};
        CGRect rect = [label.text boundingRectWithSize:CGSizeMake(label.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        [self setRectHeight:ceil(rect.size.height)];
    }
    [self sizeToFit];
    return self;
}
-(CGFloat)getviewheight
{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)self;
        [label sizeToFit];
        NSDictionary *attr = @{NSFontAttributeName:label.font};
        CGRect rect = [label.text boundingRectWithSize:CGSizeMake(label.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        
    return  ceil(rect.size.height);

    
}else
return 0;

}
/**
    设置view的宽度为屏幕宽度
 */
-(UIView*)setScreenWidth{
    return [self setRectWidth:screenWidth()];
}
-(UIView*)setScreenhalf{

return [self setRectWidth:screenWidth()*0.5];}
/**
    设置view的高度为屏幕高度
 */
-(UIView*)setScreenHeight{
    return [self setRectHeight:screenHeight()];
}

/**
    设置view的size为屏幕size
 */
-(UIView*)setRectScreen{
    return [self setRectSize:CGSizeMake(screenWidth(), screenHeight())];
}

/**
 设置view宽度
 */
-(UIView*)setRectWidth:(float)w{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, w, self.frame.size.height);
    return self;
}

/**
 设置view高度
 */
-(UIView*)setRectHeight:(float)h{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
    return self;
}

/**
 增加view的宽度
 */
-(UIView *)addRectWidth:(float)w{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+w, self.frame.size.height);
    return self;
}

/**
 增加view的高度
 */
-(UIView *)addRectHeight:(float)h{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+h);
    return self;
}

/**
 设置view的size
 */
-(UIView*)setRectSize:(CGSize)s{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, s.width, s.height);
    return self;
}

/**
    设置view的大小为它的子view的范围
 */
-(UIView *)wrapContents{
    return [self setRectSize:[self fillSize]];
}

/**
    按照宽度对view进行等比例缩放
 */
-(UIView*)scaleToWidth:(float)w{
    float scale = w/self.bounds.size.width;
    float height = self.bounds.size.height * scale;
    return [[self setRectWidth:w] setRectHeight:height];
}

/**
    按照高度对view进行等比例缩放
 */
-(UIView*)scaleToHeight:(float)h{
    float scale = h/self.bounds.size.height;
    float width = self.bounds.size.width*scale;
    return [[self setRectWidth:width] setRectHeight:h];
}

/**
    按照比例对view的size进行缩放
 */
-(UIView*)scale:(float)sf{
    long w = self.bounds.size.width*sf;
    long h = self.bounds.size.height*sf;
    return [[self setRectWidth:w] setRectHeight:h];
}

/**
    延长view的width到右边距位置
 */
-(UIView *)widthToEndWithPadding:(float)right{
    float width = 0.0;
    if (CGRectGetMinX(self.frame) + right> CGRectGetWidth(self.superview.bounds)){
        width = 0.0;
    }else{
        width = CGRectGetWidth(self.superview.bounds) - right -CGRectGetMinX(self.frame);
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,width,self.frame.size.height);
    return self;
}

/**
    增加view的高度到底边距位置
 */
-(UIView *)heightToEndWithPadding:(float)bottom{
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    float height = 0.0;
    if (CGRectGetMinY(self.frame) + bottom> CGRectGetHeight(mainRect)){
        height = 0.0;
    }else{
        height = CGRectGetHeight(mainRect) - bottom - CGRectGetMinY(self.frame);
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,height);
    return self;
}

#pragma mark - getSize

/**
    得到view包含所有子view所需的size
 */
-(CGSize)fillSize{
    float x = 0;
    float y = 0;
    float w = 0;
    float h = 0;
    for (UIView *subView in self.subviews ) {
        x = CGRectGetMinX(subView.frame)<x?CGRectGetMinX(subView.frame):x;
        y = CGRectGetMinY(subView.frame)<y?CGRectGetMinY(subView.frame):y;
        w = CGRectGetMaxX(subView.frame)>w?CGRectGetMaxX(subView.frame):w;
        h = CGRectGetMaxY(subView.frame)>h?CGRectGetMaxY(subView.frame):h;
    }
    return CGSizeMake(w-x, h-y);
}

/**
 获取横向比例因数
 */
-(float)rowScaleFactor:(float)w{
    return  w/self.bounds.size.width;
}

/**
 获取纵向比例因数
 */
-(float)colScaleFactor:(float)h{
    return h/self.bounds.size.height;
}

@end
