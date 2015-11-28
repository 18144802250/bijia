//
//  DealsModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsModel.h"

@implementation DealsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DealsDataModel class]};
}

@end
@implementation DealsDataModel

- (void)setPub_time:(NSString *)pub_time
{
    _pub_time = pub_time;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss z yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en-us"];
    NSDate *pulishDate = [formatter dateFromString:pub_time];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dayCmp = [calendar components:unit fromDate:[self dateWithYMD:pulishDate] toDate:[self dateWithYMD:[NSDate date]] options:0];
    
    if (dayCmp.day == [WRTool defaultTool].lastDays) {
        return;
    }
    
    _daysFromToday = dayCmp.day;
    [WRTool defaultTool].lastDays = _daysFromToday;
}

- (NSDate *)dateWithYMD:(NSDate*)date
{
    NSDateFormatter *dateFm = [NSDateFormatter new];
    dateFm.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateFm stringFromDate:date];
    return [dateFm dateFromString:selfStr];
}

@end


@implementation DealsDataUserModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [DealsDataItemsModel class]};
}

@end


@implementation DealsDataMerchantModel

@end

@implementation DealsDataItemsModel

@end



