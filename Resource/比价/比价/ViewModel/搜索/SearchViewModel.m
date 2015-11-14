//
//  SearchViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchNetManager.h"

@implementation SearchViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    NSLog(@"text = %@",_textStr);
    self.dataTask = [SearchNetManager getSearchValueWithTextStr:_textStr completionHandle:^(id model, NSError *error) {
        
        
        
        completionHandle(error);
        
    }];
}

@end
