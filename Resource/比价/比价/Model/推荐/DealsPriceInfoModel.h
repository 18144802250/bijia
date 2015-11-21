//
//  DealsPriceInfoModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class DealsPriceInfoDataModel,DealsPriceHistoryModel,DealsPriceInfoDataOtherQuotesModel;
@interface DealsPriceInfoModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) DealsPriceInfoDataModel *data;


@end


@interface DealsPriceInfoDataModel : BaseModel
/** 卖家数组 */
@property (nonatomic, strong) NSArray *other_quotes;
/** 结束时间 */
@property (nonatomic, copy) NSString *end;
/** 开始时间 */
@property (nonatomic, copy) NSString *start;
/** 历史价格数组 */
@property (nonatomic, strong) NSArray<DealsPriceHistoryModel *> *price_history;
/** 题目 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger price_trend;
/** 卖家名 */
@property (nonatomic, copy) NSString *merchant_name;
/** 价格趋势描述 */
@property (nonatomic, copy) NSString *price_trend_desc;

@end


@interface DealsPriceHistoryModel : BaseModel
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 时间 */
@property (nonatomic, copy) NSString *time;

@end


@interface DealsPriceInfoDataOtherQuotesModel : BaseModel

@property (nonatomic, copy) NSString *purchase_url;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) BOOL available;

@property (nonatomic, assign) BOOL recommend;

@end

