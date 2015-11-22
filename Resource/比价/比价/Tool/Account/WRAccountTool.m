//
//  WRAccountTool.m
//  我的微博
//
//  Created by apple-jd28 on 15/10/23.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRAccountTool.h"

#define WRClient_id @"4148204247"
#define WRRedirect_uri @"http://www.baidu.com"
#define WRClient_secret @"69189c8db200cacaf5c6145f3bc1bf2d"

static WRAccount *_account = nil;

@implementation WRAccountTool

+ (WRAccount *)account
{
    if (!_account) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:WRAccountFilePath];
        //账号过期
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
        
    }
    return _account;
}

+(void)saveAccount:(WRAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:WRAccountFilePath];
}

+ (void)accountWithCode:(NSString *)code completionHandle:(void (^)(NSError *))complete
{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"client_id"] = WRClient_id;
    params[@"client_secret"] = WRClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = WRRedirect_uri;
    
    //允许请求接受 text/html类型
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    [BaseNetManager POST:@"https://api.weibo.com/oauth2/access_token" paramters:params completionHandle:^(id responseObj, NSError *error) {
        
        [WRAccount accountWithDic:responseObj];
        
        complete(error);
    }];
    
}

@end
