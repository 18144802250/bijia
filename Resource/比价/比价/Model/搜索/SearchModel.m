//
//  SearchModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"name":@"value",
             @"shopUrl":@"url"};
}

@end
