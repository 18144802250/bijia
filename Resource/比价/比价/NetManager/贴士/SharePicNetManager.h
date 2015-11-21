//
//  SharePicNetManager.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseNetManager.h"

typedef NS_ENUM(NSUInteger, ShareType) {
    /** 贴士 */
    ShareTypeTip,
    /** 晒图 */
    ShareTypePic
};

@interface SharePicNetManager : BaseNetManager

/** 通过类型和时间获取数据 */
+ (id)getDataWithType:(ShareType)type Sec:(NSString*)secStr completionHandle:(void(^)(id model,NSError *error))completion;


/** 通过ID 获取分享详细 */
+ (id)getTipDetailDataWithGuideId:(NSString*)idstr completionHandle:(void(^)(id model,NSError *error))completion;

@end
