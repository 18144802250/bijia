//
//  DealsPriceInfoModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class DealsPriceInfoDataModel,DealsPriceHistoryModel;

@interface DealsPriceInfoModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) DealsPriceInfoDataModel *data;

@end


@interface DealsPriceInfoDataModel : NSObject

@property (nonatomic, strong) NSArray *other_quotes;

@property (nonatomic, copy) NSString *end;

@property (nonatomic, copy) NSString *start;

@property (nonatomic, strong) NSArray<DealsPriceHistoryModel *> *price_history;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger price_trend;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, copy) NSString *price_trend_desc;

@end


@interface DealsPriceHistoryModel : NSObject

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *time;

@end

