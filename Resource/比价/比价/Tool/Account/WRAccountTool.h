//
//  WRAccountTool.h
//  我的微博
//
//  Created by apple-jd28 on 15/10/23.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRAccount.h"
#import "BaseNetManager.h"

@interface WRAccountTool : NSObject

+ (void)saveAccount:(WRAccount*)account;

+ (WRAccount*)account;

+ (void)accountWithCode:(NSString*)code completionHandle:(void(^)(NSError *error))complete;

@end
