//
//  SearchModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@interface SearchModel : BaseModel
/** 搜索相关商品名称 */
@property (nonatomic, strong) NSString *name;

/** 搜索相关商品链接 */
@property (nonatomic, strong) NSString *shopUrl;


@end
