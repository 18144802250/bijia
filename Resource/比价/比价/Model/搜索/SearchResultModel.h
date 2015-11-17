//
//  SearchResultModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class SearchResultDataModel,SearchResultDataItemsModel;
@interface SearchResultModel : BaseModel


@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) SearchResultDataModel *data;


@end
@interface SearchResultDataModel : BaseModel

@property (nonatomic, assign) NSInteger result_num;

@property (nonatomic, strong) NSArray<SearchResultDataItemsModel *> *items;

@end

@interface SearchResultDataItemsModel : BaseModel

/** 商家数 */
@property (nonatomic, assign) NSInteger merchant_count;
/** 通过ID进入商家比价页面 */
@property (nonatomic, copy) NSString *ID;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图片链接 */
@property (nonatomic, copy) NSURL *image_url;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, copy) NSString *purchase_url;

@end

