//
//  SearchNetManager.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseNetManager.h"

@interface SearchNetManager : BaseNetManager

/** 获取商城data */
+ (id)getShopDataWithCompletionHandle:(void(^)(id model,NSError *error))completion;

/** 根据搜索框的值请求链接 */
+ (id)getSearchValueWithTextStr:(NSString*)str completionHandle:(void(^)(id model,NSError *error))completion;

/** 根据搜索的值 返回商品列表 */
+ (id)getSearchResultWithQuest:(NSString*)quest page:(NSInteger)page completionHandle:(void(^)(id model,NSError *error))completion;

/** 根据商品ID 返回各电商的价格 */
+ (id)getItemsPriceWithID:(NSString*)idStr completionHandle:(void(^)(id model,NSError *error))completion;

@end
