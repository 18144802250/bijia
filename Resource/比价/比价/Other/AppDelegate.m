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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _window.backgroundColor = [UIColor whiteColor];
    
    WRCompareViewController *vc = [WRCompareViewController new];
    _window.rootViewController = vc;
    
    [_window makeKeyAndVisible];
    
    return YES;
}


@end
