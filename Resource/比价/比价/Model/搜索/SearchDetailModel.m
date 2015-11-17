//
//  SearchDetailModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/16.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchDetailModel.h"

@implementation SearchDetailModel

@end
@implementation SearchDetailDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [SearchDetailDataItemsModel class]};
}

- (void)setRecommend_price:(NSString *)recommend_price
{
    _recommend_price = [NSString stringWithFormat:@"%@元",recommend_price];
}

@end


@implementation SearchDetailDataItemsModel

- (void)setPrice:(NSString *)price
{
    int i = roundf(price.floatValue);
    _price = [NSString stringWithFormat:@"%d元",i];
}

@end


