//
//  AppDelegate.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"

#import "WRTabBarController.h"

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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WRTabBarController *tbVC = [WRTabBarController new];
    self.window.rootViewController = tbVC;
    
    return YES;
}


@end
