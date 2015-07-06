//
//  ActivitiesCellTableViewCell.m
//  ZhongTuan
//
//  Created by anddward on 14-11-21.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ActivitiesCell.h"

@interface ActivitiesCell(){
    UIView *_baseView;
    UIImageView *_lace;
    UILabel *_aTimeTag;
    UILabel *_aPhoneTag;
    UILabel *_aQQTag;
    UILabel *_aAddressTag;
}

@end

@implementation ActivitiesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 265.0);
        self.backgroundColor = [UIColor clearColor];
        [self buildViews];
        [self setSelectedView];
    }
    return self;
}

-(void)setSelectedView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.selectedBackgroundView = bgView;
}

-(void)buildViews{
    _baseView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10.0, 10.0)];
    _baseView.backgroundColor = [UIColor whiteColor];
    _baseView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _baseView.layer.shadowOffset = CGSizeMake(1, 3);
    _baseView.layer.shadowRadius = 1.5;
    _baseView.layer.shadowOpacity = 0.1;
    
    _topPic = [[ZTImageLoader alloc] initWithFrame:CGRectMake(0, 0, _baseView.bounds.size.width, 143.0)];
    _topPic.backgroundColor = [UIColor whiteColor];
    
    _lace = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activities_lace"]];
    
    _title = [[UILabel alloc] init];
    _title.textColor = [UIColor colorWithHex:0x333333];
    _title.font = [UIFont systemFontOfSize:12.0];
    _title.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _aTimeTag = [[UILabel alloc] init];
    _aTimeTag.text = @"活动时间：";
    
    _aPhoneTag = [[UILabel alloc] init];
    _aPhoneTag.text = @"咨询电话：";
    
    _aAddressTag = [[UILabel alloc] init];
    _aAddressTag.text = @"活动地点：";
    
    _aQQTag = [[UILabel alloc] init];
    _aQQTag.text = @"QQ客服：";
    
    _aQQ = [[UILabel alloc] init];
    _aPhone = [[UILabel alloc] init];
    _aTime = [[UILabel alloc] init];
    _aAddress = [[UILabel alloc] init];

    
    [self setTextColor:[UIColor colorWithHex:0x9b9b9b] withLabels:@[_aTime,_aTimeTag,_aQQ,_aQQTag,_aPhone,_aPhoneTag,_aAddress,_aAddressTag]];
    [self setFont:[UIFont systemFontOfSize:10.0] withLavels:@[_aTime,_aTimeTag,_aQQ,_aQQTag,_aPhone,_aPhoneTag,_aAddress,_aAddressTag]];
    
    
    [_baseView addSubViews:@[_topPic,_lace,_title,_aTimeTag,_aTime,
                             _aQQ,_aQQTag,_aPhone,_aPhoneTag,_aAddress,_aAddressTag]];
    [self addSubview:_baseView];
}

-(void)layoutSubviews{

    /// position
    [[[_lace fitSize] setRectBelowOfView:_topPic] addRectY:-2.5];
    [[[[[_title fitSize] setRectBelowOfView:_lace]
    addRectY:5.0] setRectX:5.0] setRectWidth:_baseView.bounds.size.width-5.0];
    [[[[_aTimeTag fitSize] setRectBelowOfView:_title] addRectY:10.0] setRectX:5.0];
    [[[[_aTime fitSize] setRectBelowOfView:_title] setRectOnRightSideOfView:_aTimeTag] addRectY:10.0];
    [[[[_aPhoneTag fitSize] setRectBelowOfView:_aTimeTag] addRectY:5.0] setRectX:5.0];
    [[[[_aPhone fitSize] setRectBelowOfView:_aTimeTag] setRectOnRightSideOfView:_aPhoneTag] addRectY:5.0];
    [[[[_aQQTag fitSize] setRectBelowOfView:_aPhoneTag] addRectY:5.0] setRectX:5.0];
    [[[[_aQQ fitSize] setRectBelowOfView:_aPhoneTag] setRectOnRightSideOfView:_aQQTag] addRectY:5.0];
    [[[[_aAddressTag fitSize] setRectBelowOfView:_aQQTag] addRectY:5.0] setRectX:5.0];
    [[[[_aAddress fitSize] setRectBelowOfView:_aQQTag] setRectOnRightSideOfView:_aAddressTag] addRectY:5.0];
}

#pragma mark - helpers

-(void)setFont:(UIFont *)font withLavels:(NSArray*)labels{
    for (UILabel* label in labels) {
        label.font = font;
    }
}

-(void)setTextColor:(UIColor *)textColor withLabels:(NSArray*)labels{
    for (UILabel* label in labels) {
        label.textColor = textColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
