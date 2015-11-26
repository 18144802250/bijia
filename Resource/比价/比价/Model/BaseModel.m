//
//  BaseModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *) mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}


@end
@implementation BaseDetailDataHotCommentsModel

- (NSString *)pub_time
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss z yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en-us"];
    NSDate *publishDate = [formatter dateFromString:_pub_time];
    
    if ([publishDate isToday]) {
        NSDateComponents *cmp = [publishDate intervalFromNow];
        if (cmp.hour > 1) {
            return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
        } else if (cmp.minute > 1) {
            return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
        } else {
            return [NSString stringWithFormat:@"刚刚"];
        }
        
    } else {
        formatter.dateFormat = @"MM:dd HH:mm";
        
        return [NSString stringWithFormat:@"%@",[formatter stringFromDate:publishDate]];
    }
}

@end

@implementation BaseDetailDataUserModel


@end