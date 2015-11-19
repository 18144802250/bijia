//
//  GoodListModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class GooListDataModel,GooListDataUserModel,GooListDataMerchantModel,GooListDataItemsModel;
@interface GoodListModel : BaseModel


@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<GooListDataModel *> *data;

@end
@interface GooListDataModel : NSObject

@property (nonatomic, assign) NSInteger browses_count;

@property (nonatomic, strong) GooListDataMerchantModel *merchant;

@property (nonatomic, assign) NSInteger supports_count;
/** 标题 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pub_time;
/** 子图片数组 */
@property (nonatomic, strong) NSArray<GooListDataItemsModel *> *items;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *editor_tag_image_url;

@property (nonatomic, assign) NSInteger oppositions_count;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger shares_count;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger content_id;
/** 子标题 */
@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, strong) GooListDataUserModel *user;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong) NSArray<NSString *> *categories;
/** 图片链接 */
@property (nonatomic, copy) NSString *image_url;

@end

@interface GooListDataUserModel : BaseModel

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *photo;

@end

@interface GooListDataMerchantModel : BaseModel

@property (nonatomic, copy) NSString *name;

@end

@interface GooListDataItemsModel : BaseModel
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图片 */
@property (nonatomic, copy) NSString *image_url;

@end

