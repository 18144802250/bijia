//
//  DealsPriceInfoModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsPriceInfoModel.h"

@implementation DealsPriceInfoModel

@end

@implementation DealsPriceInfoDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"price_history" : [DealsPriceHistoryModel class]};
}



@end

@implementation DealsPriceHistoryModel


@end
@implementation DealsPriceInfoDataOtherQuotesModel

@end


