//
//  WRNaviTool.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRNaviTool.h"

@implementation WRNaviTool

+ (void)addLeftNaviItemAtViewC:(UIViewController *)vc
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn bk_addEventHandler:^(id sender) {
        [vc.sideMenuViewController presentLeftMenuViewController];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,leftItem];
}

+ (void)setUpNaviBar:(UINavigationController *)navi
{
    
}

+ (void)addBackItemAtVC:(UIViewController *)vc
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn bk_addEventHandler:^(id sender) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,leftItem];
}

+ (void)addBackItemAtPresentVC:(UIViewController *)vc
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
//    btn.backgroundColor = kNaviTitleColor;
    
    btn.frame = CGRectMake(10, 20, 35, 35);
    
//    btn.layer.cornerRadius = 35/2;
    
    [btn bk_addEventHandler:^(id sender) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [vc.view addSubview:btn];
}



@end
