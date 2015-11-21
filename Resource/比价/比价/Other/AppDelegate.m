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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initializeWithApplication:application];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    WRTabBarController *tbVC = [WRTabBarController new];
    _window.rootViewController = tbVC;
    
    [_window makeKeyAndVisible];
    
    return YES;
}


@end
