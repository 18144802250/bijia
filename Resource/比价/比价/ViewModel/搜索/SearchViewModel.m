//
//  SearchViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchNetManager.h"
#import "SearchModel.h"

@implementation SearchViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    [self.dataArr removeAllObjects];
    self.dataTask = [SearchNetManager getSearchValueWithTextStr:_textStr completionHandle:^(SearchModel *model, NSError *error) {
        [self.dataArr addObjectsFromArray:model.huigoods.r];
        
        completionHandle(error);
        
    }];
}

@end
