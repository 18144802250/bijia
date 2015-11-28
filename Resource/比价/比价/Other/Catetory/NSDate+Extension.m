//
//  NSDate+Extension.m
//  比价
//
//  Created by apple-jd28 on 15/11/12.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCmp = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmp = [calendar components:unit fromDate:self];
    
    return (nowCmp.year == selfCmp.year) && (nowCmp.month == selfCmp.month) && (nowCmp.day == selfCmp.day);
}

- (NSDate*)dateWithYMD
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [formatter stringFromDate:self];
    return [formatter dateFromString:selfStr];
}

- (NSDateComponents *)intervalFromNow
{
    NSCalendar *calendar = [NSCalendar new];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSString *)dateToStr
{
    NSDateFormatter *fm = [NSDateFormatter new];
    fm.dateFormat = @"MM-dd";
    return [fm stringFromDate:self];
}


@end
