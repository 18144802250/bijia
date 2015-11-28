
//
//  DealsViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsViewModel.h"
#import "WRTool.h"

@interface DealsViewModel ()

@end

@implementation DealsViewModel

- (instancetype)initWithType:(CategoryType)type
{
    if (self = [super init]) {
        
        _type = type;
        
    }
    return self;
}

/** 预防init */

- (instancetype)init
{
    if (self = [super init]) {
        
        NSAssert1(NO, @"%s 请使用initWithType初始化", __FUNCTION__);
        
    }
    return self;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [DealsNetManager getDealsDataWithType:_type Sec:_secStr completionHandle:^(DealsModel *model, NSError *error) {
        
        if ([_secStr isEqualToString:@"0"]) {
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray:model.data];
        
        completionHandle(error);
    }];
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    _secStr = @"0";
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    if (self.dataArr.count) {
        
        NSTimeInterval sec = [self publishDateWithLastSec].timeIntervalSince1970;
        
        _secStr = [NSString stringWithFormat:@"%ld000",(NSInteger)sec];
    }
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (NSDate*)publishDateWithLastSec
{
    NSDateFormatter *formatter = [NSDateFormatter new];//Tue Nov 10 08:30:28 +0800 2015
    formatter.dateFormat = @"EEE MMM d HH:mm:ss z yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en-us"];
    DealsDataModel *model = self.dataArr.lastObject;
    
    return [formatter dateFromString:model.pub_time];
}










@end
