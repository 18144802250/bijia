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
#import "SearchResultModel.h"
#import "SearchDetailModel.h"

@implementation SearchNetManager

+ (id)getShopDataWithCompletionHandle:(void (^)(id, NSError *))completion
{
    return [self GET:@"http://app.huihui.cn/suggest_shop/list.json?app_version=3.3.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4" paramters:nil completionHandle:^(id responseObj, NSError *error) {
        
        completion([ShopModel mj_objectWithKeyValues:responseObj],error);
        
    }];
}

+ (void)getSearchValueWithTextStr:(NSString *)str completionHandle:(void (^)(id, NSError *))completion
{
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://gsuggest.ydstatic.com/suggest/suggest.s?count=10&o=_hui_goods&query=%@&app_version=3.4.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4",str];
//    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {

//        completion([SearchModel mj_objectArrayWithKeyValuesArray:responseObj],error);
    
//    }];
    
    NSURLSessionDataTask *task=[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:path] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if ([str containsString:@"Error"] || [str isEqualToString:@""]) {
            NSError *err = [NSError errorWithDomain:@"error" code:404 userInfo:nil];
            completion(nil,err);
            return;
        }
        
        //正常情况下，解析出来的一定是字典或数组或字符串类型
        str = [str stringByReplacingOccurrencesOfString:@"_hui_goods.updateCall(" withString:@"{\"huigoods\":"];
        NSRange range = [str rangeOfString:@"q"];
        str = [str stringByReplacingCharactersInRange:range withString:@"\"q\""];
        range = [str rangeOfString:@"r"];
        str = [str stringByReplacingCharactersInRange:range withString:@"\"r\""];
        str = [str stringByReplacingOccurrencesOfString:@");" withString:@"}"];
        str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
             
            completion([SearchModel mj_objectWithKeyValues:jsonData],error);
        });
        
        
    }];
    [task resume];

}

+ (id)getSearchResultWithQuest:(NSString *)quest page:(NSInteger)page completionHandle:(void (^)(id, NSError *))completion
{
    //http://app.huihui.cn/app/search/inland?page=0&q=%E5%90%B8%E5%B0%98%E5%99%A8&app_version=3.5&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=xiaomi&appname=deals_app&system_version=4.4.4
    quest = [quest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn/app/search/inland?page=%ld&q=%@&app_version=3.5&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=xiaomi&appname=deals_app&system_version=4.4.4",page,quest];
    
    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {
        
        completion([SearchResultModel mj_objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getItemsPriceWithID:(NSString *)idStr completionHandle:(void (^)(id, NSError *))completion
{
    
    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn/m/detail.json?id=%@&app_version=3.4.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4",idStr];
    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {
        
        completion([SearchDetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}


//+ (void)getShopURLWithPurchaseURL:(NSString *)urlStr completionHandle:(void (^)(NSURL *, NSError *))completion
//{
//    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn%@",urlStr];
//    [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {
//        
//        completion((NSURL*)responseObj,error);
//        
//    }];
//}

@end
