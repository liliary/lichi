//
//  ZTSelectedButton.m
//  ZhongTuan
//
//  Created by anddward on 14-11-28.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTSelectedButton.h"
@interface ZTSelectedButton(){
    UILabel *_label;
    UIImageView *_rIcon;         // the rightIndicator
    UIImageView *_bIcon;         // the bottomIndicator
    UILabel *_labelrIcon;    // label indicator,label模式下使用。
    
    /// view controll
    ZTSelecctedButtonStatus _currentStatus;         // 当前状态
}
@end

@implementation ZTSelectedButton

#pragma mark - public methods

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

// 初始化
-(instancetype)initWithTitle:(NSString*)title rightIndicatorImage:(UIImage*)rIcon bottomIndicatorImage:(UIImage*)bIcon{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _labelTitleForNol = title;
        _rIconImageForNol = rIcon;
        _bIconImageForNol = bIcon;
        [self createViews];
    }
    return self;
}

// 设置按钮状态
-(void)setButtonState:(ZTSelecctedButtonStatus)status{
    _currentStatus = status;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


// 构建view
-(void)createViews{
    _label = [[UILabel alloc] init];
    _rIcon = [[UIImageView alloc] init];
    _bIcon = [[UIImageView alloc] init];
    [self addSubViews:@[_label,_rIcon,_bIcon]];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSelf)];
    [self addGestureRecognizer:recognizer];
}

#pragma mark - build views
/**
    布局
 */
-(void)layoutSubviews{
    // size
    if(nil != _label)[self layoutLabel];
    if(nil != _rIcon)[self layoutrIcon];
    if(nil != _bIcon)[self layoutbIcon];
}

/**
    布局label标签
 */
-(void)layoutLabel{
    if(nil == _label)return;
    switch (_currentStatus) {
        case ZTSelectedButtonStatusSel:
            _label.text = _labelTitleForSel==nil?_labelTitleForNol==nil?@"":_labelTitleForNol:_labelTitleForSel;
            _label.textColor = _labelColorForSel;
            CGFloat fontSizeSel = _labelFontSizeForSel == 0 ? 14.0 : _labelFontSizeForSel;
            _label.font = [UIFont systemFontOfSize:fontSizeSel];
            break;
        case ZTSelectedButtonStatusNol:
            _label.text = _labelTitleForNol==nil?_labelTitleForSel==nil?@"":_labelTitleForSel:_labelTitleForNol;
            _label.textColor = _labelColorForNol;
            CGFloat fontSizeNol = _labelFontSizeForNol == 0 ? 14.0 : _labelFontSizeForNol;
            _label.font = [UIFont systemFontOfSize:fontSizeNol];
            break;
        default:
            break;
    }
    [_label sizeToFit];
    CGFloat rightPadding = _rIconMarginRight==0?-15.0:(-1)*_rIconMarginRight;
    [[_label setRectCenterInParent] addRectX:rightPadding];
}

/**
    布局右边的指示器
 */
-(void)layoutrIcon{
    switch (_rIconType) {
        case ZTSelectedButtonRightIndicatorTypeRotate:
            [self layoutRotaterIcon];
            break;
        case ZTSelectedButtonRightIndicatorTypeReplace:
            [self layoutReplacerIcon];
            break;
        case ZTSelectedButtonRightIndicatorTypeLabel:
            [self layoutLabelrIcon];
            return;
        default:
            break;
    }
    [_rIcon sizeToFit];
    CGFloat rightPadding = _rIconMarginRight==0?-15.0:(-1)*_rIconMarginRight;
    [[_rIcon setRectCenterVertical] setRectMarginRight:rightPadding];
}
/**
    底部indicator布局
 */
-(void)layoutbIcon{
    //TODO: 未完成
}
/**
    处于rotate模式时，右边indicator的旋转控制
 */
-(void)layoutRotaterIcon{
    if(nil == _rIcon.image){
        _rIcon.image = _rIconImageForNol;
    }else if(_currentStatus == ZTSelectedButtonStatusSel){
        [self rotaterIndicator:180.0];
    }else{
        [self rotaterIndicator:0];
    }
}

/**
    处于replace模式时，右边indicator的旋转控制
 */
-(void)layoutReplacerIcon{
    if (_currentStatus == ZTSelectedButtonStatusSel) {
        _rIcon.image = _rIconImageForSel;
    }else{
        _rIcon.image = _rIconImageForNol;
    }
}

/**
    处于label模式时，右边indicator的旋转控制
 */
-(void)layoutLabelrIcon{
    if (nil != _rIcon && [_rIcon.superview isEqual:self]) {
        [_rIcon removeFromSuperview];
    }
    if(nil == _labelrIcon){
        _labelrIcon = [[UILabel alloc] init];
        _labelrIcon.font = [UIFont fontWithName:@"iconfont" size:16.0];
        _labelrIcon.text = @"\U0000e661";
        [self addSubview:_labelrIcon];
    }else if (_currentStatus == ZTSelectedButtonStatusSel){
        [self rotaterIndicator:180.0];
    }else{
        [self rotaterIndicator:0.0];
    }
    [_labelrIcon sizeToFit];
    [[_labelrIcon setRectCenterVertical] setRectMarginRight:_rIconMarginRight==0?15.0:_rIconMarginRight];
}

#pragma mark - helpers

/**
    旋转indicator
    @args du:旋转的角度。
 */
-(void)rotaterIndicator:(CGFloat)du{
    [UIView animateWithDuration:0.5 animations:^{
        if ( _rIconType == ZTSelectedButtonRightIndicatorTypeLabel) {
            _labelrIcon.transform = CGAffineTransformMakeRotation(du*M_PI/180.0);
        }else{
            _rIcon.transform = CGAffineTransformMakeRotation(du*M_PI/180.0);
        }
    }completion:^(BOOL finished) {
        _rIcon.tintColor = [UIColor redColor];
        if (_currentStatus == ZTSelectedButtonStatusNol) {
            _labelrIcon.textColor = _labelColorForNol;
        }else{
            _labelrIcon.textColor = _labelColorForSel;
        }
    }];
}

#pragma mark - button click events
/**
    当点击按钮的响应
 */
-(void)didTapSelf{
    [_ztDelegate didTapZTSelectedButton:_index];
}

@end
