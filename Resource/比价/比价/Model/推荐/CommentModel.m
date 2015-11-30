//
//  CommentModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/28.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

@end
@implementation CommentDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"comments" : [CommentCommentsModel class]};
}

@end


@implementation CommentCommentsModel

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


@implementation CommentDataUserModel

@end


