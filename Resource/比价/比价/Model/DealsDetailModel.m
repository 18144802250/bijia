//
//  DealsDetailModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailModel.h"

@implementation DealsDetailModel

@end
@implementation DealsDetailDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"hot_comments" : [DdealDetailDataHotCommentsModel class]};
}

- (void)setPage:(NSString *)page
{
//    NSArray *strArr = [page componentsSeparatedByString:@"<div class=\"Strategy-pic\">"];
    NSArray *strArr = [page componentsSeparatedByString:@"<img alt"];
    NSString *preStr = strArr.firstObject;
    NSMutableString *lasStr = [strArr.lastObject mutableCopy];
//    NSRange range2 = [lasStr rangeOfString:@"\"editor-mod\">"];
    NSRange range2 = [lasStr rangeOfString:@"/>"];
    [lasStr deleteCharactersInRange:NSMakeRange(0, range2.location+range2.length)];
    
    
    _page = [preStr stringByAppendingString:lasStr];
}

@end


@implementation DealsDetailDataHotCommentsModel



@end


@implementation DealsDetailDataUserModel



@end


