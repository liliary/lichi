//
//  HomeTabBarController.m
//  ZhongTuan
//
//  Created by anddward on 14-11-4.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import "HomeTabBarController.h"
#import "NearController.h"
#import "ActivitiesController.h"
#import "MeController.h"
#import "SaleController.h"


@interface HomeTabBarController ()

@end

@implementation HomeTabBarController

- (instancetype)init
{
    self = [super init];
    
    if (self) {

        UINavigationController *nearNavigation = [[UINavigationController alloc] initWithRootViewController:[[NearController alloc] init]];
        UINavigationController *saleTabController = [[UINavigationController alloc] initWithRootViewController:[[SaleController alloc] init]];
        UINavigationController *acvivitiesTabController = [[UINavigationController alloc] initWithRootViewController:[[ActivitiesController alloc] init]];
        UINavigationController *meTabController = [[UINavigationController alloc] initWithRootViewController:[[MeController alloc] init]];
        [self setViewControllers:@[saleTabController,nearNavigation,acvivitiesTabController,meTabController]];
        
        [[[[self viewControllers] objectAtIndex:0] tabBarItem] setTitle:@"特卖"];
        [[[[self viewControllers] objectAtIndex:1] tabBarItem] setTitle:@"周边"];
        [[[[self viewControllers] objectAtIndex:2] tabBarItem] setTitle:@"活动"];
        [[[[self viewControllers] objectAtIndex:3] tabBarItem] setTitle:@"我的"];
        
        [[[[self viewControllers] objectAtIndex:0] tabBarItem] setImage:[UIImage imageNamed:@"tab_sale_nol"]];
        [[[[self viewControllers] objectAtIndex:0] tabBarItem] setSelectedImage:[UIImage imageNamed:@"tab_sale_sel"]];
        [[[[self viewControllers] objectAtIndex:1] tabBarItem] setImage:[UIImage imageNamed:@"tab_near_nol"]];
        [[[[self viewControllers] objectAtIndex:1] tabBarItem] setSelectedImage:[UIImage imageNamed:@"tab_near_sel"]];
        [[[[self viewControllers] objectAtIndex:2] tabBarItem] setImage:[UIImage imageNamed:@"tab_activities_nol"]];
        [[[[self viewControllers] objectAtIndex:2] tabBarItem] setSelectedImage:[UIImage imageNamed:@"tab_activities_sel"]];
        [[[[self viewControllers] objectAtIndex:3] tabBarItem] setImage:[UIImage imageNamed:@"tab_me_nol"]];
        [[[[self viewControllers] objectAtIndex:3] tabBarItem] setSelectedImage:[UIImage imageNamed:@"tab_me_sel"]];

        self.tabBar.tintColor = [UIColor redColor];
        self.tabBar.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}


@end
