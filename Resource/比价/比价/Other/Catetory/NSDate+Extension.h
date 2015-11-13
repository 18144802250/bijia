//
//  NSDate+Extension.h
//  比价
//
//  Created by apple-jd28 on 15/11/12.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (BOOL)isToday;


- (NSDateComponents*)intervalFromNow;

// MM-dd date转字符串
- (NSString*)dateToStr;

@end
