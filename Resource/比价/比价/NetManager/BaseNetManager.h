//
//  BaseNetManager.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject

+ (id)GET:(NSString*)path paramters:(NSDictionary*)params completionHandle:(void(^)(id responseObj,NSError *error))completion;

+ (id)POST:(NSString*)path paramters:(NSDictionary*)params completionHandle:(void(^)(id responseObj,NSError *error))completion;

@end
