

//
//  WRHistoryTool.m
//  比价
//
//  Created by apple-jd28 on 15/11/24.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRHistoryTool.h"

static WRHistory *_history = nil;

@implementation WRHistoryTool

+ (WRHistory *)history
{
    if (!_history) {
        _history = [NSKeyedUnarchiver unarchiveObjectWithFile:WRHistoryFilePath];
        if (!_history) {
            _history = [WRHistory new];
        }
    }
    return _history;
}

+(void)saveHistory:(NSArray *)historyArr
{
    _history.historyArr = historyArr;
    [NSKeyedArchiver archiveRootObject:_history toFile:WRHistoryFilePath];
}

@end
