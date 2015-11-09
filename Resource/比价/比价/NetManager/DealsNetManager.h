//
//  DealsNetManager.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseNetManager.h"

@interface DealsNetManager : BaseNetManager

+ (id)getDealsDataWithSec:(NSString*)secStr completionHandle:(void(^)(id responseObj,NSError *error))completion;

@end
