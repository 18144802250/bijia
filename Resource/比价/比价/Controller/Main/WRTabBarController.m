//
//  WRTabBarController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTabBarController.h"

#import "WRLeftViewController.h"
#import "WRCommendViewController.h"
#import "WRSearchViewController.h"
#import "WRTipViewController.h"

@interface WRTabBarController ()

@property (nonatomic, strong) RESideMenu *sideMenu;

@end

@implementation WRTabBarController

- (RESideMenu *)sideMenu {
    if(_sideMenu == nil) {
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[WRCommendViewController alloc] initWithType:0]];
        
        _sideMenu = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:[WRLeftViewController new] rightMenuViewController:nil];
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
    [self setUpOneVCWithVC:self.sideMenu title:@"推荐" image:nil selectedImage:nil];
    
    //搜索
    WRSearchViewController *searchVC = [WRSearchViewController new];
    [self setUpOneVCWithVC:searchVC title:@"搜索" image:nil selectedImage:nil];
    
    //贴士
    WRTipViewController *tipVC = [WRTipViewController new];
    [self setUpOneVCWithVC:tipVC title:@"贴士" image:nil selectedImage:nil];
}

- (void)setUpOneVCWithVC:(UIViewController*)vc title:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage
{
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:vc];
}

@end
