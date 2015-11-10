//
//  AppDelegate.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "WRCompareViewController.h"
#import "WRLeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIWindow *)window {
    if(_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (RESideMenu *)sideMenu {
    if(_sideMenu == nil) {
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[WRCompareViewController alloc] initWithType:0]];
        
        _sideMenu = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:[WRLeftViewController new] rightMenuViewController:nil];
    }
    return _sideMenu;
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = self.sideMenu;
    
    
    return YES;
}


@end
