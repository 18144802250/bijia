//
//  WRTabBarController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTabBarController.h"
#import "WRNavigationController.h"

#import "WRLeftViewController.h"
//#import "CommendViewController.h"
#import "WRCommendViewController.h"
#import "WRSearchViewController.h"
//#import "WRTipViewController.h"
#import "TipViewController.h"

#import "WRProfileViewController.h"

@interface WRTabBarController ()

@property (nonatomic, strong) RESideMenu *sideMenu;

@end

@implementation WRTabBarController

+ (void)initialize
{
    if (self == [WRTabBarController class]) {
        UITabBar *tabBaar = [UITabBar appearance];        
        
        [tabBaar setBackgroundImage:[UIImage imageWithStretchableName:@"tabbarBkg"]];
        UITabBarItem *item = [UITabBarItem appearance];
        
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        attributes[NSForegroundColorAttributeName] = kRGBColor(40, 137, 59);
        
        [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
    }
}

- (RESideMenu *)sideMenu {
    if (!_sideMenu) {
        WRCommendViewController *vc = [WRCommendViewController new];
        WRNavigationController *navi = [[WRNavigationController alloc] initWithRootViewController:vc];
        
        _sideMenu = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:[WRLeftViewController new] rightMenuViewController:nil];
        _sideMenu.backgroundImage = [UIImage imageNamed:@"sideMenuBg"];
    }
    return _sideMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加 subVC
    [self addSubVC];
}

- (void)addSubVC
{
    //推荐
    self.sideMenu.title = @"推荐";
    self.sideMenu.tabBarItem.image = [UIImage imageWithOriginName:@"tabbar_commend"];
    self.sideMenu.tabBarItem.selectedImage = [UIImage imageWithOriginName:@"tabbar_commend_select"];
    [self addChildViewController:self.sideMenu];
    
    //搜索
    WRSearchViewController *searchVC = [WRSearchViewController new];
    [self setUpOneVCWithVC:searchVC title:@"搜索" image:[UIImage imageWithOriginName:@"tabbar_search"] selectedImage:[UIImage imageWithOriginName:@"tabbar_search_selected"]];
    
    //贴士
    UIViewController *tipVC = [TipViewController standardTip];
    
//    WRTipViewController *tipVC = [WRTipViewController new];
//    
    [self setUpOneVCWithVC:tipVC title:@"分享" image:[UIImage imageWithOriginName:@"tabbar_share"] selectedImage:[UIImage imageWithOriginName:@"tabbar_share_selected"]];
    //设置
    WRProfileViewController *profileVC = [WRProfileViewController new];
    [self setUpOneVCWithVC:profileVC title:@"我的" image:[UIImage imageWithOriginName:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginName:@"tabbar_profile_selected"]];
    
}

- (void)setUpOneVCWithVC:(UIViewController*)vc title:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage
{
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
    
    
    WRNavigationController *navi = [[WRNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
}

@end
