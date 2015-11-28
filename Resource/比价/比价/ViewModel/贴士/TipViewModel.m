//
//  TipViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TipViewModel.h"
#import "TipListModel.h"

@implementation TipViewModel

- (instancetype)initWithType:(ShareType)type
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
    self.dataTask = [SharePicNetManager getDataWithType:_type Sec:_secStr completionHandle:^(TipListModel *model, NSError *error) {
        
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
        
        NSTimeInterval sec = [self publishDateWithRow:self.dataArr.count-1].timeIntervalSince1970;
        
        _secStr = [NSString stringWithFormat:@"%ld",(NSInteger)sec];
    }
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (NSDate*)publishDateWithRow:(NSInteger)row
{
    NSDateFormatter *formatter = [NSDateFormatter new];//Tue Nov 10 08:30:28 +0800 2015
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en-us"];

    TipListDataModel *tipModel = self.dataArr.lastObject;
    return [formatter dateFromString:tipModel.update_date];
}

@end
