//
//  UIView+ZTFundationAddiction.h
//  ZhongTuan
//
//  Created by anddward on 15/2/28.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZTFundationAddiction)

#pragma mark - add Views
-(void)addSubViews:(NSArray*)views;

#pragma mark - autoLayout
-(void)constraints:(NSString*)vsfm opt:(NSLayoutFormatOptions)opt metrics:(NSDictionary*)mts vs:(NSDictionary*)vs;
-(void)constraintsFromArray:(NSArray*)vsfms opt:(NSLayoutFormatOptions)opt metrics:(NSDictionary*)mts vs:(NSDictionary*)vs;

#pragma mark - setRectPosition
-(UIView*)setRectX:(float)x;
-(UIView*)setRectY:(float)y;
-(UIView*)setRectCenterInParent;
-(UIView*)setRectCenterHorizentail;
-(UIView*)setRectCenterVertical;
-(UIView*)setRectMarginLeft:(float)width;
-(UIView*)setRectMarginRight:(float)width;
-(UIView*)setRectMarginBottom:(float)width;
-(UIView*)setRectMarginTop:(float)width;
-(UIView*)addRectX:(float)x;
-(UIView*)addRectY:(float)y;
-(UIView*)setRectBelowOfView:(UIView*)component;
-(UIView*)setRectOnLeftSideOfView:(UIView*)component;
-(UIView*)setRectOnRightSideOfView:(UIView*)component;
-(UIView*)setRectOnTopOfView:(UIView*)component;
-(UIView*)setCenterOfViewHorizentail:(UIView*)component;
-(UIView*)setCenterOfViewVertical:(UIView*)component;

#pragma mark - setRectSize
-(UIView*)fitSize;
-(UIView*)setScreenWidth;
-(UIView*)setScreenHeight;
-(UIView*)setRectScreen;
-(UIView*)setRectWidth:(float)w;
-(UIView*)setRectHeight:(float)h;
-(UIView*)addRectWidth:(float)w;
-(UIView*)addRectHeight:(float)h;
-(UIView*)setRectSize:(CGSize)size;
-(UIView*)wrapContents;
-(UIView*)scaleToWidth:(float)w;
-(UIView*)scaleToHeight:(float)h;
-(UIView*)scale:(float)sf;
-(UIView*)widthToEndWithPadding:(float)right;
-(UIView*)heightToEndWithPadding:(float)bottom;
-(CGFloat)getviewheight;
-(UIView*)setScreenhalf;
#pragma mark - getSize
-(CGSize)fillSize;
-(float)rowScaleFactor:(float)w;
-(float)colScaleFactor:(float)h;

@end
