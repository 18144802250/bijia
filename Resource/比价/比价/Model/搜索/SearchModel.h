//
//  SearchModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"



@class SearchHuigoodsModel,SearchHuigoodsDataModel;
@interface SearchModel : BaseModel

@property (nonatomic, strong) SearchHuigoodsModel *huigoods;


@end
@interface SearchHuigoodsModel : BaseModel

@property (nonatomic, copy) NSString *q;

@property (nonatomic, strong) NSArray<SearchHuigoodsDataModel *> *r;

@end

@interface SearchHuigoodsDataModel : BaseModel

@property (nonatomic, copy) NSString *lable;
/** 搜索相关商品名称 */
@property (nonatomic, copy) NSString *value;
/** 搜索相关商品链接 */
@property (nonatomic, copy) NSString *url;

@end

