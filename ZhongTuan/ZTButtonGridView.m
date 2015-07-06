//
//  ZTButtonGridView.m
//  ZhongTuan
//
//  Created by anddward on 14-11-14.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "ZTButtonGridView.h"
#import "ZTButtonCell.h"

@implementation ZTButtonGridView{
    NSArray *_icons;
    NSArray *_titles;
}
NSString *cellTag = @"ZTCell";

/**
    提供Dictionary【@"titles"=>(NSArray[NSString]),@"icons"=>(NSArray[NSString])】
    titles:包含按钮标题的数组，顺序从左到右
    icons:包含按钮图标名字的数组，顺序从左到右
 */
-(ZTButtonGridView*)initWithIcons:(NSDictionary*)source
                             cell:(NSString*)cellClassName
                           column:(long)col
                         rowSpace:(float)rowSpace
                      columnSpace:(float)colSpace
                        edgeSpace:(float)edgeSpace{
    _icons = [source objectForKey:@"icons"];
    _titles = [source objectForKey:@"titles"];
    _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    long itemCount = [_icons count];                                // 按钮数量
    long row = itemCount%col==0?itemCount/col:itemCount/col+1;      // 行数
    float cellWidth = (screenWidth-(col-1)*colSpace)/col;           // cell 高度
    float gridVieHeight = cellWidth*row+rowSpace*(row-1)+2;        // gridView 高度
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumLineSpacing:rowSpace];
    [layout setMinimumInteritemSpacing:colSpace];
    [layout setItemSize:CGSizeMake(cellWidth, cellWidth)];
    
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, gridVieHeight) collectionViewLayout:layout];
    if (self) {
        if ([NSClassFromString(cellClassName) isSubclassOfClass:[ZTButtonCell class]]) {
            [self registerClass:NSClassFromString(cellClassName) forCellWithReuseIdentifier:cellTag];
        }else{
            //非ZTButton cell
            NSException *e = [[NSException alloc] initWithName:@"NotLeagleCellType" reason:@"not support cell type" userInfo:nil];
            @throw e;
        }
        self.delegate = self;
        self.dataSource = self;
        // 背景色，默认cell间隙颜色
        self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
    }
    return self;
    
}

#pragma mark - collection view delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    // 只有一个session
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // 按钮数量 == 图标数量
    return [_icons count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellTag forIndexPath:indexPath];
    ;
    if ([self.tag isEqualToString:@"1"]) {
    [cell passvule:@"net"];
 [cell.pic setImageFromUrl:[_icons objectAtIndex:indexPath.row]];}
    if ([self.tag isEqualToString:@"0"]) {
        [cell passvule:@"cxad"];
        [cell.pic setImageFromUrl:[_icons objectAtIndex:indexPath.row]];
    }
    
    else{
    
    [cell setImage:[UIImage imageNamed:[_icons objectAtIndex:indexPath.row]]];}          // 设置按钮图片
    [cell setTitle:[_titles objectAtIndex:indexPath.row]];                              // 设置按钮文字
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_ztButtonViewDelegate didTapCollectionAtIndex:indexPath];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
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
}

@end
