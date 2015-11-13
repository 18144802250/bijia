//
//  NSString+Extension.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)textSizeWithFontMaxSize:(CGSize)size Size:(CGFloat)fontSize;


- (NSInteger)myDays:(NSInteger)i ,...;

- (NSDateComponents*)dateCmpFormStr;

- (NSDate*)strToDate;

- (NSInteger)daysToDate:(NSString*)dateStr;

@end
