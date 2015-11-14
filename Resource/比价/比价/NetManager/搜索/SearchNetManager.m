//
//  SearchNetManager.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchNetManager.h"
#import "ShopModel.h"
#import "SearchModel.h"

@implementation SearchNetManager

+ (id)getShopDataWithCompletionHandle:(void (^)(id, NSError *))completion
{
    return [self GET:@"http://app.huihui.cn/suggest_shop/list.json?app_version=3.3.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4" paramters:nil completionHandle:^(id responseObj, NSError *error) {
        
        completion([ShopModel mj_objectWithKeyValues:responseObj],error);
        
    }];
}

+ (id)getSearchValueWithTextStr:(NSString *)str completionHandle:(void (^)(id, NSError *))completion
{
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://gsuggest.ydstatic.com/suggest/suggest.s?count=10&o=_hui_goods&query=%@&app_version=3.4.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4",str];
//    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {

//        completion([SearchModel mj_objectArrayWithKeyValuesArray:responseObj],error);
    
//    }];
    
    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:path] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //正常情况下，解析出来的一定是字典或数组或字符串类型
        str = [str stringByReplacingOccurrencesOfString:@"_hui_goods.updateCall(" withString:@"{\"huigoods\":{"];
        str = [str stringByReplacingOccurrencesOfString:@"q" withString:@"\"q\""];
        str = [str stringByReplacingOccurrencesOfString:@"r" withString:@"\"r\""];
        str = [str stringByReplacingOccurrencesOfString:@");" withString:@"}"];
        str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
        
        completion([SearchModel mj_objectWithKeyValues:jsonData],error);
        
    }];
    [task resume];
    
    return task;
}

@end
