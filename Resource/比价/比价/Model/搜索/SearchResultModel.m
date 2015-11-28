
//
//  SearchResultModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel

@end
@implementation SearchResultDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"inland" : [SearchResultDataInlandModel class]};
}

@end


@implementation SearchResultDataInlandModel

- (void)setPrice:(NSString *)price
{
    _price = [NSString stringWithFormat:@"¥%@",price];
}

@end

@implementation SearchResultDataItemsMerchantModel

@end