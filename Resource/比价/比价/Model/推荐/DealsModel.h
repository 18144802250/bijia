//
//  DealsModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class DealsDataModel,DealsDataUserModel,DealsDataMerchantModel,DealsDataItemsModel;
@interface DealsModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<DealsDataModel *> *data;

@end

@interface DealsDataModel : BaseModel
/** idStr */
@property (nonatomic, copy) NSString *ID;
/** 浏览数 */
@property (nonatomic, assign) NSInteger browses_count;

@property (nonatomic, strong) DealsDataMerchantModel *merchant;
/** 赞 */
@property (nonatomic, assign) NSInteger supports_count;
/** 发布时间 */
@property (nonatomic, copy) NSString *pub_time;
/** 根据判断发布时间，返回与今天相差的天数 */
@property (nonatomic, assign) NSInteger daysFromToday;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *editor_tag_image_url;

@property (nonatomic, assign) NSInteger oppositions_count;

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
/** 类型 */
@property (nonatomic, copy) NSString *type;
/** 图片 */
@property (nonatomic, copy) NSURL *image_url;
/** 子图片数组 */
@property (nonatomic, strong) NSArray<DealsDataItemsModel *> *items;
/** webView标题 */
@property (nonatomic, copy) NSString *webViewTitle;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 页面展示xml */
@property (nonatomic, copy) NSString *page;
/** 评论数 */
@property (nonatomic, assign) NSInteger comments_count;



@end



@interface DealsDataUserModel : BaseModel

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSURL *photo;

@end

@interface DealsDataMerchantModel : BaseModel
/** 商家 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *logo_url;

@end

@interface DealsDataItemsModel : BaseModel
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图片 */
@property (nonatomic, copy) NSURL *image_url;

@end


