//
//  SearchResultModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class SearchResultDataModel,SearchResultDataInlandModel,SearchResultDataItemsMerchantModel;

@interface SearchResultModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) SearchResultDataModel *data;

@end


@interface SearchResultDataModel : BaseModel

//@property (nonatomic, strong) NSArray<Deals *> *deals;
//
//@property (nonatomic, strong) NSArray<Others *> *others;

@property (nonatomic, strong) NSArray<SearchResultDataInlandModel *> *inland;
@end


@interface SearchResultDataInlandModel : BaseModel

/** 商家数 */
@property (nonatomic, assign) NSInteger merchant_count;
/** 通过ID进入商家比价页面 */
@property (nonatomic, copy) NSString *ID;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图片链接 */
@property (nonatomic, copy) NSString *image_url;

@property (nonatomic, copy) NSString *merchant_name;
/** 跳转链接 */
@property (nonatomic, copy) NSString *purchase_url;
/** 商家 */
@property (nonatomic, strong) SearchResultDataItemsMerchantModel *merchant;
@end


@interface SearchResultDataItemsMerchantModel : BaseModel
/** 商家名 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *logo_url;
@end







