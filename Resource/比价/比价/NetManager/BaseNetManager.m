//
//  BaseNetManager.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseNetManager.h"


static AFHTTPSessionManager *manager = nil;
@implementation BaseNetManager


+ (AFHTTPSessionManager *)sharedAFManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        
    });
    return manager;
}


+ (id)GET:(NSString *)path paramters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completion
{
//    DDLogVerbose(@"path = %@",path);
    return [[self sharedAFManager] GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}

+ (id)POST:(NSString *)path paramters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completion
{
    return [[self sharedAFManager] POST:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}


@end
