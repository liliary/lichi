//
//  RevivceGoodTableViewCell.m
//  ZhongTuan
//
//  Created by anddward on 15/5/19.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "RevivceGoodTableViewCell.h"
@interface RevivceGoodTableViewCell(){
    UILabel *_dolla;            //价格符号
    UILabel*_shuliang ;            //数量
}
@end
@implementation RevivceGoodTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 140);
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        [self buildViews];
        [self setSelectedView];
    }
    return self;
}
#pragma mark - construct

-(void)buildViews{
NSLog(@"jicia");
    self.dd = [[UILabel alloc] init];
    [self.dd setText:@"定单号:"];
    [self.dd  setFont:[UIFont systemFontOfSize:10.0]];
    [self.dd setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _ordernumber=[[UILabel alloc]init];
    [_ordernumber setFont:[UIFont systemFontOfSize:10.0]];
    [_ordernumber setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _state=[[UILabel alloc]init];
    [_state setFont:[UIFont systemFontOfSize:10.0]];
    [_state setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    _pic = [ZTImageLoader new];
    
    _title = [[UILabel alloc] init];
    [_title setFont:[UIFont systemFontOfSize:12.0]];
    [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    _dolla = [[UILabel alloc] init];
    [_dolla setText:@"总价:￥"];
    [_dolla  setFont:[UIFont systemFontOfSize:11.0]];
    [_dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _totolprice= [[UILabel alloc] init];
    [_totolprice setFont:[UIFont systemFontOfSize:12.0]];
    [_totolprice setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    
    _shuliang = [[UILabel alloc] init];
    [_shuliang setText:@"数量: "];
    [_shuliang  setFont:[UIFont systemFontOfSize:10.0]];
    [_shuliang setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    _quantity = [[UILabel alloc] init];
    [_quantity setFont:[UIFont systemFontOfSize:9.6]];
    [_quantity setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    
    _delivercom= [[UILabel alloc] init];
    [_delivercom setFont:[UIFont systemFontOfSize:10.0]];
    [_delivercom setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    
    self.wudh = [[UILabel alloc] init];
    [self.wudh setText:@"物流单号:"];
    [self.wudh  setFont:[UIFont systemFontOfSize:10.0]];
    [self.wudh setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _delivernumber= [[UILabel alloc] init];
    [_delivernumber setFont:[UIFont systemFontOfSize:10.0]];
    [_delivernumber setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _qrsh= [UIButton new];
    [_qrsh setTitle:@"立即评价" forState: UIControlStateNormal];
    _qrsh.backgroundColor=[UIColor redColor];
    _qrsh.layer.cornerRadius=8.0;
    [_qrsh.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    _qrsh.tag=1;
    [_qrsh addTarget:self action:@selector(showwuliu:) forControlEvents:UIControlEventTouchUpInside];
    
    _showdelier= [UIButton new];
    [_showdelier setTitle:@"查看物流" forState: UIControlStateNormal];
    _showdelier.backgroundColor=[UIColor redColor];
    _showdelier.layer.cornerRadius=8.0;
    [_showdelier.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    _showdelier.titleLabel.textColor=[UIColor redColor];
    _showdelier.tag=0;
    [_showdelier addTarget:self action:@selector(showwuliu:) forControlEvents:UIControlEventTouchUpInside];
    
    //_showdelier.backgroundColor=[UIColor redColor];
    //    _qrsh.labelTop.text = @"确认收货";
    //    _qrsh.alignMode = ZTIconButtonAlignModeCenter;
    //    _qrsh.rightBorder = YES;
    //    _qrsh.bottomBorder = YES;
    //    _qrsh.borderWidth = 0.5;
    //    _qrsh.backgroundColor = [UIColor redColor];
    
//    ZTIconButton*vi=[[ZTIconButton alloc]initWithFrame:CGRectMake(100, 70, 20, 20)];
//    vi.userInteractionEnabled=NO;
//    vi.backgroundColor=[UIColor redColor];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 50, 10, 10)];
//    //label.backgroundColor=[UIColor blueColor];
//    label.text=@"hahahahha";
//    [self.accessoryView addSubview:vi];
//    [self.accessoryView addSubview:label];
    [self addSubViews:@[self.dd,_ordernumber, _state,_pic,_title, _dolla, _totolprice,_shuliang,_quantity,_delivercom,self.wudh,_delivernumber,_showdelier,_qrsh]];
    
}
-(void)showwuliu:(UIButton*)bt{
    if (bt.tag==0) {
        if (self.actionBlock) {
            self.actionBlock();
            //           [ bt setBackgroundImage:[UIImage imageNamed:@"select(2).png"] forState:UIControlStateNormal];
        }
    }
    else{
        if (self.aactionBlock) {
            self.aactionBlock();
        }}
}

-(void)setSelectedView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.selectedBackgroundView = bgView;
}

#pragma mark - layout

-(void)layoutSubviews{
    [[[self.dd fitSize]setRectMarginLeft:10]setRectMarginTop:6];
    [[[_ordernumber fitSize]setRectOnRightSideOfView:self.dd]setRectMarginTop:6];
    [[[[_state fitSize]setRectOnRightSideOfView:_ordernumber]setRectMarginRight:8]setRectMarginTop:10];
    [[[[[_pic setRectWidth:75.0] setRectHeight:73.5] setRectMarginTop:12] setRectMarginLeft:7.5]setRectBelowOfView:_ordernumber];
    [[[[_title fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:30.0];
    [[[[_dolla fitSize] setRectOnRightSideOfView:_pic] addRectX:15.0] setRectMarginTop:65.0];
    [[[_totolprice fitSize] setRectOnRightSideOfView:_dolla]setRectMarginTop:65.0];
    
    [[[[ _shuliang fitSize] setRectMarginTop:68.0] setRectOnRightSideOfView:_totolprice]setRectMarginRight:100];
    [[[_quantity fitSize] setRectMarginTop:68.0] setRectOnRightSideOfView:_shuliang];
    [[[[_delivercom fitSize]setRectMarginLeft:15]setRectBelowOfView:_pic]addRectY:5.0];
    [[[self.wudh fitSize]setRectMarginBottom:30]setRectMarginRight:100];
    [[[_delivernumber fitSize]setRectOnRightSideOfView:self.wudh]setRectMarginBottom:30];
    
    [[[[_showdelier setRectWidth:60]setRectHeight:20]setRectMarginLeft:10]setRectMarginBottom:5];
    [[[[_qrsh setRectWidth:60]setRectHeight:20] setRectMarginBottom:5]setRectMarginRight:35];
    
    [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    
    CGContextStrokePath(cotx);
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_borderWidth);
    
    if (_topBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    
    [super drawRect:rect];
    
    // Configure the view for the selected state
}

@end
