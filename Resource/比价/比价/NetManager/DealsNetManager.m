//
//  DealsNetManager.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsNetManager.h"
#import "DealsModel.h"

@implementation DealsNetManager
//http://app.huihui.cn/deals/category.json?category=inland&with_user=1&with_merchant=1&since_time=0&max_time=0&app_version=3.3.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4


+ (id)getDealsDataWithSec:(NSString *)secStr completionHandle:(void (^)(id, NSError *))completion
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"category"] = @"inland";
    params[@"with_user"] = @"1";
    params[@"with_merchant"] = @"1";
    params[@"since_time"] = @"0";
    params[@"max_time"] = secStr;
    params[@"app_version"] = @"3.3.1";
    params[@"platform"] = @"android";
    params[@"device_id"] = @"99000629739444";
    params[@"model"] = @"HM+NOTE+1S";
    params[@"vendor"] = @"youdao";
    params[@"appname"] = @"deals_app";
    params[@"system_version"] = @"4.4.4";
    
    return [self GET:@"http://app.huihui.cn/deals/category.json" paramters:params completionHandle:^(id responseObj, NSError *error) {
        
        completion([DealsModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
