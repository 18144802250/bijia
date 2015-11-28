//
//  WRTabBarTool.m
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTabBarTool.h"

@implementation WRTabBarTool

+ (void)hideTabBar:(UIViewController*)vc
{
   
    if (vc.tabBarController.tabBar.hidden == YES) {
            return;
    }
    UIView *contentView;
    if ( [[vc.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [vc.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [vc.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + vc.tabBarController.tabBar.frame.size.height);
    vc.tabBarController.tabBar.hidden = YES;
}

+ (void)showTabBar:(UIViewController *)vc
{
    if (vc.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[vc.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [vc.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [vc.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - vc.tabBarController.tabBar.frame.size.height);
    vc.tabBarController.tabBar.hidden = NO;
}

@end
