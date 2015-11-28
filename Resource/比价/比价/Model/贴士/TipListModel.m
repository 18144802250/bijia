//
//  TipListModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TipListModel.h"

@implementation TipListModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [TipListDataModel class]};
}

@end

@implementation TipListDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"author" : [TipListDataAuthorModel class], @"category" : [TipListDataCategoryModel class]};
}

-(void)setTitle:(NSString *)title
{
    _title = [title stringByReplacingOccurrencesOfString:@"【晒物园】" withString:@""];
}

- (void)setCover_image_url:(NSURL *)cover_image_url
{
    _cover_image_url = cover_image_url;
}

@end


@implementation TipListDataAuthorModel

@end


@implementation TipListDataCategoryModel

@end






