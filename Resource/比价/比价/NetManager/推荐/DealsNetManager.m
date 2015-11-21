//
//  DealsNetManager.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsNetManager.h"
#import "DealsModel.h"
#import "DealsDetailModel.h"
#import "DealsPriceInfoModel.h"
#import "NSString+WREncode.h"

@implementation DealsNetManager

+ (id)getDealsDataWithType:(CategoryType)type Sec:(NSString *)secStr completionHandle:(void (^)(id, NSError *))completion
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    switch (type) {
        case CategoryTypeInland:
            params[@"category"] = @"inland";
            break;
        case CategoryTypeDaily:
            params[@"category"] = @"daily";
            break;
        case CategoryTypeFood:
            params[@"category"] = @"food";
            break;
        case CategoryTypeDresses:
            params[@"category"] = @"dresses";
            break;
        case CategoryTypeCosmetics:
            params[@"category"] = @"cosmetics";
            break;
        case CategoryTypeSport:
            params[@"category"] = @"sport";
            break;
        case CategoryTypeDigital:
            params[@"category"] = @"digital";
            break;
        case CategoryTypeBaby:
            params[@"category"] = @"baby";
            break;
        case CategoryTypeGoodlist:
            params[@"category"] = @"goods_list";
            break;

        default:
            NSAssert1(NO, @"%s 请输入类别", __FUNCTION__);
            break;
    }
    
    
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

+ (id)getDealsDetailDataWithContentId:(NSString *)contentId completionHandle:(void (^)(id, NSError *))completion
{
    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn/deals/deal/%@.json",contentId];
    return [self GET:path paramters:@{@"with_detail":@"1"} completionHandle:^(id responseObj, NSError *error) {
        completion([DealsDetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getDealsDataPriceWithPurchaseURL:(NSString*)URL completionHandle:(void (^)(id, NSError *))completion
{
    
//    NSString *purchaseUrl = [URL encodeToPercentEscapeString:URL];
    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn/price_info.json?product_url=%@&app_version=3.3.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4",URL];
//
//    NSMutableDictionary *params = [NSMutableDictionary new];
//    
//    params[@"product_url"] = @"https%3A%2F%2Fdetail.tmall.com%2Fitem.htm%3Fspm%3D608.7065813.ne.1.lil56w%26id%3D20878779465";
//
//    params[@"app_version"] = @"3.3.1";
//    params[@"platform"] = @"android";
//    params[@"device_id"] = @"99000629739444";
//    params[@"model"] = @"HM+NOTE+1S";
//    params[@"vendor"] = @"youdao";
//    params[@"appname"] = @"deals_app";
//    params[@"system_version"] = @"4.4.4";
    
    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {
        
        completion([DealsPriceInfoModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
