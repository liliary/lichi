//
//  OrderViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/2/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZTOrderProtocol <NSObject>
-(void)updateUserPhone:(NSString*)phone;
@end

@interface TeambuyOrderViewController : UIViewController
@property (strong,nonatomic) NSNumber* productId;
@end
