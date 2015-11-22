//
//  WRAccount.h
//  我的微博
//
//  Created by apple-jd28 on 15/10/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>
//"access_token" = "2.00fuwDQGH78jWE3372f2557c0ZobYI";
//        "expires_in" = 157679999;
//        "remind_in" = 157679999;
//        uid = 5734159817;
@interface WRAccount : NSObject <NSCoding>

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *expires_in;
@property (nonatomic, strong) NSString *remind_in;
@property (nonatomic, strong) NSString *uid;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
//过期日期 
@property (nonatomic, strong) NSDate *expires_date;

+ (instancetype)accountWithDic:(NSDictionary*)dic;

@end
