//
//  NSString+Extension.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)textSizeWithFontMaxSize:(CGSize)size Size:(CGFloat)fontSize
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

- (NSDateComponents*)dateCmpFormStr
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM-dd";
    
    NSCalendar *calendar = [NSCalendar new];
    int unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    return [calendar components:unit fromDate:[formatter dateFromString:self]];
}

- (NSDate *)strToDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM-dd";
    return [formatter dateFromString:self];
}
/** 返回日期月份天数 没有判断闰年 */
- (NSInteger)myDays:(NSInteger)i, ...
{
    NSDateComponents *cmp = [self dateCmpFormStr];
    if (i>0) {
        cmp.month = i;
    }
    switch (cmp.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:
            return 28;
        default:
            return 0;
    }
}


- (NSInteger)daysToDate:(NSString *)dateStr
{
    NSDateComponents *selfCmp = [self dateCmpFormStr];
    NSDateComponents *toCmp = [dateStr dateCmpFormStr];
    
    
    NSUInteger days = 0;
    if (toCmp.month < selfCmp.month) {
        NSAssert1(NO, @"日期比较错误 %s", __FUNCTION__);
        return 0;
    } else {
        for (NSUInteger i = selfCmp.month; i <= toCmp.month; i++) {
            if (i == selfCmp.month) {
                days += [self myDays:i] - selfCmp.day;
            }
            
            if (i == toCmp.month) {
                days += toCmp.day;
            }
            
            days += [self myDays:i];
        }
    }
    return days;
}

@end
