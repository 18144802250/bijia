//
//  WRHistoryTool.h
//  比价
//
//  Created by apple-jd28 on 15/11/24.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRHistory.h"

@interface WRHistoryTool : NSObject

+ (void)saveHistory:(NSArray*)historyArr;

+ (WRHistory*)history;

@end
