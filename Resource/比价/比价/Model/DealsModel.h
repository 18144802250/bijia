//
//  DealsModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class DealsDataModel,DealsDataUserModel,DealsDataMerchantModel;
@interface DealsModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<DealsDataModel *> *data;

@end

@interface DealsDataModel : BaseModel
/** 浏览数 */
@property (nonatomic, assign) NSInteger browses_count;

@property (nonatomic, strong) DealsDataMerchantModel *merchant;
/** 赞 */
@property (nonatomic, assign) NSInteger supports_count;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 发布时间 */
@property (nonatomic, copy) NSString *pub_time;
/** 根据判断发布时间，返回与今天相差的天数 */
@property (nonatomic, assign) NSDateComponents *daysFromToday;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *editor_tag_image_url;

@property (nonatomic, assign) NSInteger oppositions_count;
/** 回复数 */
@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger shares_count;
/** id */
@property (nonatomic, assign) NSInteger content_id;
/** 子标题 */
@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, strong) DealsDataUserModel *user;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong) NSArray<NSString *> *categories;
/** 图片 */
@property (nonatomic, copy) NSString *image_url;

@end

@interface DealsDataUserModel : BaseModel

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *photo;

@end

@interface DealsDataMerchantModel : BaseModel
/** 商家 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *logo_url;

@end

