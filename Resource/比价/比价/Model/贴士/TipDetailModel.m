//
//  TipDetailModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TipDetailModel.h"

@implementation TipDetailModel

@end



@implementation TipDetailDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"section_list" : [TipDetailDataSectionListModel class], @"author" : [TipDetailDataAuthorModel class], @"category" : [TipDetailDataCategoryModel class], @"hot_comments" : [TipDetailDataHotCommentsModel class]};
}

- (void)setUpdate_date:(NSString *)update_date
{
    _update_date = [update_date stringByReplacingOccurrencesOfString:@"00:00:00" withString:@""];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _webViewTitle = [title stringByReplacingOccurrencesOfString:@"真相:" withString:@""];
}

@end


@implementation TipDetailDataSectionListModel

@end


@implementation TipDetailDataAuthorModel

@end


@implementation TipDetailDataCategoryModel

@end


@implementation TipDetailDataHotCommentsModel

@end


@implementation TipDetailDataUserModel

@end


