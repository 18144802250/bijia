
//
//  WRHistory.m
//  比价
//
//  Created by apple-jd28 on 15/11/24.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRHistory.h"

#define WRHistoryKey @"histroyArr"

@implementation WRHistory

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_historyArr forKey:WRHistoryKey];
}
//解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init]) {
        
        _historyArr = [aDecoder decodeObjectForKey:WRHistoryKey];
        
    }
    return self;
}

- (NSArray *)historyArr
{
    if (!_historyArr) {
        _historyArr = [NSArray new];
    }
    return _historyArr;
}

@end
