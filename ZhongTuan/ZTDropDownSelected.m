//
//  ZTDropDownSelected.m
//  ZhongTuan
//
//  Created by anddward on 14-11-20.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

/*****************************************************
 * 两列内容选择控件
 *****************************************************/

//TODO: 调整接口结构，实现控件高度、数据自定义。
#import "ZTDropDownSelected.h"
#import "ZTSelectedHolder.h"

@interface ZTDropDownSelected()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    /// views
    UITableView *_tableView1;
    UITableView *_tableView2;
    ZTSelectedHolder *_holder;
    
    /// data
    NSArray *_data;
    NSArray *_segmentKeys;
    NSArray *_categoryList;

    NSArray *_tableSource1;
    NSArray *_tableSource2;
    
    /// UIDanamy
    UIDynamicAnimator *_dropAnimator;
    UIGravityBehavior *_gravityBehavior;
    UICollisionBehavior *_collision;
   
}

@end

@implementation ZTDropDownSelected

//static const int SINGLE_COLUMN = 1;
//static const int DOUBLE_COLUMN = 2;

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        _ztdelegate = delegate;
        [self initHolder];
    }
    return self;
}

//-(id)initWithFrame:(CGRect)frame withData:(NSArray*)data{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _data = data;
//        _segmentKeys = [self getKeysFromData:_data];
//        [self initSegmentView];
//        [self initTableViews];
////        [_segment setSelectedSegmentIndex:0];
//        self.clipsToBounds = YES;
////        [self initTap];
//        self.backgroundColor = [UIColor colorWithHexTransparent:0xcc000000];
//        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMask:)];
//        recognizer.delegate = self;
//        [self addGestureRecognizer:recognizer];
//    }
//    return self;
//}

#pragma mark - build views

-(void)initHolder{
    _holder = [[ZTSelectedHolder alloc] init];
    [_ztdelegate initHolder:_holder];
}

-(void)initTableViews{
    /// tables
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 160, 100) style:UITableViewStylePlain];
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(160, 0, 160, 100) style:UITableViewStylePlain];
    [_tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [_tableView1 setBounces:NO];
    [_tableView2 setBounces:NO];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView2.delegate = self;
    _tableView2.dataSource  = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
}

-(void)initSegmentView{
//    /// segment
//    _segment = [[UISegmentedControl alloc] initWithItems:_segmentKeys];
////    _segment.frame = CGRectMake(0, 0, 320, 20);
//    [_segment setBackgroundColor:[UIColor orangeColor]];
//    [_segment setTintColor:[UIColor whiteColor]];
//    [_segment addTarget:self action:@selector(didTapSegment:) forControlEvents:UIControlEventAllEvents];
//}
//
//-(void)layoutSubviews{
//    addViews(self, @[_segment,_tableView2,_tableView1]);
//
//    CGSize segmentSize = [_ztdelegate sizeForSegment];
//    [_segment setRectSize:segmentSize];
////    self.frame = _segment.frame;
//    [_tableView1 setRectBelowOfView:_segment];
//    [_tableView2 setRectBelowOfView:_segment];
}
#pragma mark -helper

-(NSInteger)numberofSegment{
    return [_data count];
}

-(NSArray*)getKeysFromData:(NSArray*)data{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in data) {
        [array addObject:[dic objectForKey:@"key"]];
    }
    return array;
}

///**
//    初始化点击
// */
//-(void)initTap{
//    [self didTapSegment:_segment];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self perform:_tableView1 didTapAtIndex:indexPath];
//}

/**
    点击某项
 */
-(void)perform:(UITableView*)tableView didTapAtIndex:(NSIndexPath*)indexPath{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - tableView delegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_tableView1]) {
        return [_tableSource1 count];
    }else{
        return [_tableSource2 count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    long row = [indexPath row];
    if ([tableView isEqual:_tableView1]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.textLabel.text = [_tableSource1 objectAtIndex:row];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
        cell.textLabel.text = [_tableSource2 objectAtIndex:row];
    }
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([tableView isEqual:_tableView1]) {
//        long row = [indexPath row];
//        if (DOUBLE_COLUMN == _segment.tag) {
//            _tableSource2 = [[_categoryList objectAtIndex:row] objectForKey:@"val"];
//            [_tableView2 reloadData];
//        }
//    }
//}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

#pragma mark - tap

//-(void)didTapSegment:(UISegmentedControl*)segment{
//    long id = [segment selectedSegmentIndex];
//    NSDictionary *val = [_data objectAtIndex:id];
//    _categoryList = [val objectForKey:@"val"];
//    NSObject *item = [_categoryList objectAtIndex:0];
//    if ([item isKindOfClass:[NSString class]]) {
//        /// one column
//        [_tableView1 setRectWidth:320];
//        _tableSource1 = _categoryList;
//        [_tableView1 reloadData];
//        [_segment setTag:SINGLE_COLUMN];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//        [_tableView1 selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
//        [UIView animateWithDuration:1.0 animations:^{
//            [self heightToEndWithPadding:0.0];
//        }];
//    }else if ([item isKindOfClass:[NSDictionary class]]) {
//        /// two column
//        [_tableView1 setRectWidth:160];
//        _tableSource1 = [self getKeysFromData:_categoryList];
//        [_tableView1 reloadData];
//        [_segment setTag:DOUBLE_COLUMN];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//        [_tableView1 selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
//        [UIView animateWithDuration:1.0 animations:^{
//            [self heightToEndWithPadding:0.0];
//        }];
//    }else{
//        /// unsuport style
//        alertShow(@"不支持的类型");
//    }
//}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (CGRectContainsPoint(_tableView1.bounds,[touch locationInView:_tableView1])) {
        return NO;
    }else if (CGRectContainsPoint(_tableView2.bounds, [touch locationInView:_tableView2])){
        return NO;
    }
    return YES;
}

//-(void)didTapMask:(UITapGestureRecognizer*)recognizer{
//    [UIView animateWithDuration:1.0 animations:^{
//        [self setRectHeight:_segment.frame.size.height];
//    }];
//}

@end
