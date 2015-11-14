
//
//  SearchResultViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchResultViewModel.h"
#import "SearchNetManager.h"
#import "SearchResultModel.h"

@implementation SearchResultViewModel

- (instancetype)initWithQuest:(NSString *)quest
{
    if (self = [super init]) {
        
        _quest = quest;
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
    self.dataTask = [SearchNetManager getSearchResultWithQuest:_quest page:_page completionHandle:^(SearchResultModel *model, NSError *error) {
        
        if (_page == 1) {
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray:model.data.items];
        
        completionHandle(error);
    }];
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    _page = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    _page += 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

@end
