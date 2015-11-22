
//
//  WRAccount.m
//  我的微博
//
//  Created by apple-jd28 on 15/10/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//


#import "WRAccountTool.h"

#define WRUidKey @"uid"
#define WRAccessTokenKey @"token"
#define WRExpires_inKey @"exoires"
#define WRExpires_dateKey @"date"
#define WRNameKey @"name"

@implementation WRAccount

+(instancetype)accountWithDic:(NSDictionary *)dic
{
    WRAccount *account = [WRAccount new];
    [account setValuesForKeysWithDictionary:dic];
    [WRAccountTool saveAccount:account];
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

 //归档的时候调用：告诉系统哪个属性需要归档，如何归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:WRAccessTokenKey];
    [aCoder encodeObject:_expires_in forKey:WRExpires_inKey];
    [aCoder encodeObject:_uid forKey:WRUidKey];
    [aCoder encodeObject:_expires_date forKey:WRExpires_dateKey];
    [aCoder encodeObject:_name forKey:WRNameKey];
}

 //解档的时候调用：告诉系统哪个属性需要解档，如何解档

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {

        // 一定要记得赋值
        _access_token =  [aDecoder decodeObjectForKey:WRAccessTokenKey];
        _expires_in = [aDecoder decodeObjectForKey:WRExpires_inKey];
        _uid = [aDecoder decodeObjectForKey:WRUidKey];
        _expires_date = [aDecoder decodeObjectForKey:WRExpires_dateKey];
        _name = [aDecoder decodeObjectForKey:WRNameKey];
    }
    return self;
}

@end
