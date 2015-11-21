//
//  SharePicNetManager.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SharePicNetManager.h"
#import "TipListModel.h"
#import "TipDetailModel.h"


@implementation SharePicNetManager

//http://app.huihui.cn/guide/app/list.json?type=shared_article&with_user=1&with_merchant=1&since_time=0&max_time=0&app_version=3.4.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4
+ (id)getDataWithType:(ShareType)type Sec:(NSString *)secStr completionHandle:(void (^)(id, NSError *))completion
{
    NSString *typeStr = nil;
    switch (type) {
        case ShareTypePic:
            typeStr = @"shared_article";
            break;
        case ShareTypeTip:
            typeStr = @"guide_list";
            break;
        default:
            break;
    }
    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn/guide/app/list.json?type=%@&with_user=1&with_merchant=1&since_time=0&max_time=%@&app_version=3.4.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4",typeStr,secStr];
    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {
        
        completion([TipListModel mj_objectWithKeyValues:responseObj],error);
             
    }];
}

+ (id)getTipDetailDataWithGuideId:(NSString *)idstr completionHandle:(void (^)(id, NSError *))completion
{
    NSString *path = [NSString stringWithFormat:@"http://app.huihui.cn/guide/app/%@.json?with_detail=1&app_version=3.4.1&platform=android&device_id=99000629739444&model=HM+NOTE+1S&vendor=youdao&appname=deals_app&system_version=4.4.4",idstr];
    return [self GET:path paramters:nil completionHandle:^(id responseObj, NSError *error) {
        completion([TipDetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
