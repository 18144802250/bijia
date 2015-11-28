//
//  DealsNetManager.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseNetManager.h"

typedef NS_ENUM(NSUInteger, CategoryType) {
    /** 全部类别 */
    CategoryTypeInland,
    /** 日用百货 */
    CategoryTypeDaily,
    /** 生鲜食品 */
    CategoryTypeFood,
    /** 服饰鞋包 */
    CategoryTypeDresses,
    /** 美妆个护 */
    CategoryTypeCosmetics,
    /** 运动健康 */
    CategoryTypeSport,
    /** 数码家电 */
    CategoryTypeDigital,
    /** 母婴玩具 */
    CategoryTypeBaby,
    /** 商品图片列表 */
    CategoryTypeGoodlist
};

@interface DealsNetManager : BaseNetManager
/** 获取国内 */
+ (id)getDealsDataWithType:(CategoryType)type Sec:(NSString*)secStr completionHandle:(void(^)(id model,NSError *error))completion;

/** 获取国内详细 */
+ (id)getDealsDetailDataWithContentId:(NSString*)contentId completionHandle:(void(^)(id model,NSError *error))completion;
/** 获取国内详细比价信息 */
+ (id)getDealsDataPriceWithPurchaseURL:(NSString*)URL completionHandle:(void (^)(id model,NSError *error))completion;

/** 根据ID获取全部评论 */
+ (id)getCommentDataWithId:(NSString*)idStr completionHandle:(void (^)(id model,NSError *error))completion;

@end
