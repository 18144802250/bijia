//
//  WRNaviTool.h
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRNaviTool : NSObject

+ (void)addLeftNaviItemAtViewC:(UIViewController*)vc;

+ (void)setUpNaviBar:(UINavigationController*)navi;

+ (void)addBackItemAtVC:(UIViewController*)vc;

+ (void)addBackItemAtPresentVC:(UIViewController*)vc;

@end
