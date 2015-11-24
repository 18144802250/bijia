

//
//  WRNavigationController.m
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRNavigationController.h"

@interface WRNavigationController ()

@end

@implementation WRNavigationController

+ (void)initialize
{
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBackgroundImage:[UIImage imageWithStretchableName:@"bg"] forBarMetrics:0];
    
    [naviBar setTranslucent:NO];
    
    NSMutableDictionary *attribute = [NSMutableDictionary new];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:kNaviTitleFontSize];
    
    [naviBar setTitleTextAttributes:attribute];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        //左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] hightImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] taget:self action:@selector(popToPre) forControlEven:UIControlEventTouchUpInside];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] hightImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] taget:self action:@selector(popToRoot) forControlEven:UIControlEventTouchUpInside];
    }

    [super pushViewController:viewController animated:animated];
}

- (void)popToPre {
    [self popViewControllerAnimated:YES];
}

- (void)popToRoot {
    [self popToRootViewControllerAnimated:YES];
}

@end
