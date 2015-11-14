//
//  ShopModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class ShopDataModel;
@interface ShopModel : BaseModel


@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<ShopDataModel *> *data;


@end
@interface ShopDataModel : NSObject
/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 商品URL */
@property (nonatomic, copy) NSURL *url;

@property (nonatomic, assign) BOOL is_global;

@end

