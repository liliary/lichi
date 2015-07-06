//
//  ZTCoverView.m
//  ZhongTuan
//
//  Created by anddward on 15/1/31.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTCoverView.h"

@implementation ZTCoverView
static UIView *coverView;
static UIImageView *loadingIndicator;

+(void)alertCover{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.3;
        NSMutableArray *animates = [[NSMutableArray alloc] initWithCapacity:20];
        for (int i=1; i<=20; i++) {
            NSString *imageName = @"loading{n}";
            UIImage *im = [UIImage imageNamed:[imageName stringByReplacingOccurrencesOfString:@"{n}" withString:[NSString stringWithFormat:@"%d",i]]];
            [animates addObject:im];
        }
        UIImage *loadImage = [UIImage animatedImageWithImages:animates duration:4];
        loadingIndicator = [[UIImageView alloc] initWithImage:loadImage];
        loadingIndicator.alpha = 1.0;
    });
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:coverView];
    [window addSubview:loadingIndicator];
    [loadingIndicator setRectCenterInParent];
}

+(void)dissmiss{
    [loadingIndicator removeFromSuperview];
    [coverView removeFromSuperview];
}


@end
