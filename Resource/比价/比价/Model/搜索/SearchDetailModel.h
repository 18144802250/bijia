//
//  SearchDetailModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/16.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class SearchDetailDataModel,SearchDetailDataItemsModel;
@interface SearchDetailModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) SearchDetailDataModel *data;

@end
@interface SearchDetailDataModel : NSObject
/** 题目 */
@property (nonatomic, copy) NSString *title;
/** 图片链接 */
@property (nonatomic, copy) NSURL *image_url;
/** B2C条目 */
@property (nonatomic, strong) NSArray<SearchDetailDataItemsModel *> *items;
/** 数目 */
@property (nonatomic, assign) NSInteger item_count;
/** 参考价格 */
@property (nonatomic, copy) NSString *recommend_price;

@end

@interface SearchDetailDataItemsModel : NSObject

@property (nonatomic, copy) NSString *site_image_url;
/** 名字 */
@property (nonatomic, copy) NSString *site_name;
/** 是否推荐 */
@property (nonatomic, assign) BOOL recommend;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 是否缺货 */
@property (nonatomic, assign) BOOL available;

@property (nonatomic, copy) NSString *purchase_url;

@end

