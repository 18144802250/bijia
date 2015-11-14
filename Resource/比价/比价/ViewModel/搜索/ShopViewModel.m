//
//  ShopViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ShopViewModel.h"
#import "SearchNetManager.h"

@implementation ShopViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [SearchNetManager getShopDataWithCompletionHandle:^(ShopModel *model, NSError *error) {
        
        [self.dataArr addObjectsFromArray:model.data];
        
        completionHandle(error);
        
    }];
}

@end
