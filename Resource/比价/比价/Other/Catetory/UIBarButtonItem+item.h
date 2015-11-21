//
//  UIBarButtonItem+item.h
//  我的微博
//
//  Created by apple-jd28 on 15/10/14.
//  Copyright (c) 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+ (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)image hightImage:(UIImage*)hightImage taget:(id)target action:(SEL)action forControlEven:(UIControlEvents)controlEvents;

@end
