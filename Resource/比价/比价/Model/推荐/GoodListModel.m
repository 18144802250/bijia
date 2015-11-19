//
//  GoodListModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "GoodListModel.h"

@implementation GoodListModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [GooListDataModel class]};
}
@end
@implementation GooListDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [GooListDataItemsModel class]};
}

@end


@implementation GooListDataUserModel

@end


@implementation GooListDataMerchantModel

@end


@implementation GooListDataItemsModel

@end


