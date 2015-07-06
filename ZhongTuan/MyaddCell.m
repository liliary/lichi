//
//  MyaddCell.m
//  ZhongTuan
//
//  Created by anddward on 15/2/27.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
// TODO: custom view : []-[]-[] automatically search province id ,city id & area id and show appropriate province/city/area Names


#import "MyaddCell.h"

#import "ZTSessionTitle.h"

@interface MyaddCell(){
   
    UILabel *_dash1;
    UILabel *_dash2;
}

@end

@implementation MyaddCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - build views

-(void)buildViews{
    self._infoGrup = [ZTSessionView new];
    self._infoGrup.topBorder = YES;
    self._infoGrup.bottomBorder = YES;
    self._infoGrup.borderWidth = 1.0;
    
    _expressDate = [ZTSessionTitle new];
    _expressDate.borderWidth = 0.5;
    _expressDate.topBorder = YES;
    [self initLabels:@[@"consignee",@"consigPhone",@"province",@"dash1",@"city",@"dash2",@"area",@"address"]];
    _dash1.text = @"-";
    _dash2.text = @"-";
    
    [self._infoGrup addSubViews:@[_consignee,_consigPhone,_province,_dash1,_city,_dash2,_area,_address,_expressDate]];
    [self addSubview:self._infoGrup];
}

-(void)initLabels:(NSArray*)labels{
    for (NSString* labelName in labels) {
        UILabel *tmpLable = [UILabel new];
        tmpLable.font = [UIFont systemFontOfSize:14.0];
        tmpLable.textColor = [UIColor colorWithHex:0x333333];
        [self setValue:tmpLable forKey:labelName];
    }
}

#pragma mark -layout views

-(void)layoutSubviews{
    [[[_consignee fitSize] setRectMarginLeft:10.0] setRectMarginTop:15.0];
    [[[[_consigPhone fitSize] setRectMarginTop:15.0] setRectOnRightSideOfView:_consignee] addRectX:24.0];
    [[[[_province fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_consignee] addRectY:10.0];
    [[[[_dash1 fitSize] setRectBelowOfView:_consignee] addRectY:10.0] setRectOnRightSideOfView:_province];
    [[[[_city fitSize] setRectOnRightSideOfView:_dash1] setRectBelowOfView:_consignee] addRectY:10.0];
    [[[[_dash2 fitSize] setRectOnRightSideOfView:_city] setRectBelowOfView:_consignee] addRectY:10.0];
    [[[[_area fitSize] setRectOnRightSideOfView:_dash2] setRectBelowOfView:_consignee] addRectY:10.0];
    [[[[_address fitSize] setRectMarginLeft:10.0] setRectBelowOfView:_dash1] addRectY:10.0];
    [[[[[_expressDate fitSize] setScreenWidth] setRectBelowOfView:_address] addRectY:15.0] setRectHeight:33.0];
    [self._infoGrup wrapContents];
}



@end
