//
//  ZTInputBox.m
//  ZhongTuan
//
//  Created by anddward on 14-11-7.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//
//NOTE:
//1.默认只包含一个textField,一个标题,一个分割器(默认为:)
//2.当需要启用图片标题和图片分割器时,使用方法 setImageIcon:withSeporator


#import "ZTInputBox.h"
#import "ZTFundationAddiction.h"
#import <QuartzCore/QuartzCore.h>

@interface ZTInputBox()<UITextFieldDelegate>{
    UILabel *_textLabel;
    UILabel *_textSeparator;
    UIImageView *_imageLabel;
    UIImageView *_imageSeparator;
    
    BOOL isUseImageLabel;
    BOOL isUseTextLabel;
        
    NSArray *_def_HContraint;
    NSArray *_ILabel_HContraint;
    NSArray *_TLabel_HContraint;
}
@end

@implementation ZTInputBox

-(instancetype)init{
    if (self = [super init]) {
        [self initViewSettings];
        [self buildDefaultView];
        self.backgroundColor = [UIColor whiteColor];
        _lineColor = [UIColor colorWithHex:COL_LINEBREAK];
    }
    return self;
}

-(void)layoutSubviews{
    if (isUseImageLabel) {
        [self layoutWithImageIcon];
        return;
    }
    if (isUseTextLabel) {
        [self layoutWithTextIcon];
        return;
    }
    /// default layout
    [[[[_textField fitSize]
    setRectMarginLeft:[_leftPadding floatValue]]
    widthToEndWithPadding:[_rightPadding floatValue]]
    setRectCenterVertical];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_borderWidth);
    CGContextSetStrokeColorWithColor(cotx, _lineColor.CGColor);
    
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    if (_topBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
}

#pragma mark - public methods

-(void)setImageLabel:(UIImage*)image withSeparator:(UIImage*)separator{
    [self initImageLabel];
    [_imageLabel setImage:image];
    [_imageSeparator setImage:separator];
    isUseImageLabel = YES;
    isUseTextLabel = NO;
}

-(void)setTextLabel:(NSString*)title withSeparator:(NSString*)separator{
    [self initTextLabel];
    [_textLabel setText:title];
    [_textSeparator setText:separator];
    isUseImageLabel = NO;
    isUseTextLabel = YES;
    
}

#pragma mark - build views

-(void)initViewSettings{
    _leftPadding = @0;
    _rightPadding = @0;
    _labelGap = @7.5;
    _contentGap = @15;
}


-(void)buildDefaultView{
    _textField = [UITextField new];
    _textField.textColor = [UIColor colorWithHexTransparent:0xff646464];
    _textField.font = [UIFont systemFontOfSize:16.0];
    _textField.delegate = self;     // 默认点击return收起键盘
    
    [self addSubview:_textField];
}

-(void)initImageLabel{
    if (nil == _imageLabel){
        _imageLabel = [UIImageView new];
        [self addSubview:_imageLabel];
    }
    if (nil == _imageSeparator){
        _imageSeparator = [UIImageView new];
        [self addSubview:_imageSeparator];
    }
}

-(void)initTextLabel{
    if (nil == _textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentJustified;
        [self addSubview:_textLabel];
    }
    if (nil == _textSeparator) {
        _textSeparator = [UILabel new];
        [self addSubview:_textSeparator];
    }
}

#pragma mark - layout views

-(void)layoutWithTextIcon{
    [[[_textLabel fitSize]
    setRectMarginLeft:[_leftPadding floatValue]]
    setRectCenterVertical];
    
    [[[[_textSeparator fitSize]
    setRectOnRightSideOfView:_textLabel]
    addRectX:[_labelGap floatValue]]
    setRectCenterVertical];
    
    [[[[[_textField fitSize]
    setRectOnRightSideOfView:_textSeparator]
    addRectX:[_contentGap floatValue]]
    widthToEndWithPadding:[_rightPadding floatValue]]
    setRectCenterVertical];
}

-(void)layoutWithImageIcon{
    [[[_imageLabel fitSize]
    setRectMarginLeft:[_leftPadding floatValue]]
    setRectCenterVertical];
    
    [[[[_imageSeparator fitSize]
    setRectOnRightSideOfView:_imageLabel]
    addRectX:[_labelGap floatValue]]
    setRectCenterVertical];
    
    [[[[[_textField fitSize]
    setRectOnRightSideOfView:_imageSeparator]
    addRectX:[_contentGap floatValue]]
    widthToEndWithPadding:[_rightPadding floatValue]]
    setRectCenterVertical];
}

#pragma mark - events

-(void)closeKeyBoard{
    [_textField resignFirstResponder];
}

-(BOOL)validate{
    NSArray *regulars = [_textFieldLimitation allKeys];
    NSString *str = [_textField text];
    for(NSString *pat in regulars){
        if (![self verification:str withPatten:pat]) {
            alertShow([_textFieldLimitation objectForKey:pat]);
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

#pragma mark - helpers
// TODO: 与 inputbox 关系解耦,写入 utilities
-(BOOL)verification:(NSString*)str withPatten:(NSString*)pat{
    NSRegularExpression *regp = [NSRegularExpression regularExpressionWithPattern:pat options:0 error:nil];
    NSRange searchRange = NSMakeRange(0, str.length);
    if ([regp numberOfMatchesInString:str options:0 range:searchRange] == 0) {
        return NO;
    }
    NSTextCheckingResult *result = [regp firstMatchInString:str options:0 range:searchRange];
    if (![str isEqualToString:[str substringWithRange:[result range]]]) {
        return NO;
    }
    return YES;
}

@end
