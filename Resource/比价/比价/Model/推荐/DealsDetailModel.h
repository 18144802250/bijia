//
//  DealsDetailModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@class DealsDetailDataModel,DdealDetailDataHotCommentsModel,DealsDetailDataUserModel;
@interface DealsDetailModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) DealsDetailDataModel *data;

@end
@interface DealsDetailDataModel : BaseModel

/** 热门评论 */
@property (nonatomic, strong) NSArray *hot_comments;

@property (nonatomic, copy) NSString *share_link;

@property (nonatomic, copy) NSString *content_type;
/** 子题目 */
@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, assign) NSInteger content_id;
/** 图片链接 */
@property (nonatomic, copy) NSString *image_url;
/** 题目 */
@property (nonatomic, copy) NSString *title;
/** 比价的关键链接  详细页关键链接 */
@property (nonatomic, copy) NSString *purchase_url;

@property (nonatomic, copy) NSString *html_url;

@property (nonatomic, assign) NSInteger supports_count;

@property (nonatomic, assign) BOOL collected;
/** xml内容 */
@property (nonatomic, copy) NSString *page;
/** 评论数 */
@property (nonatomic, assign) NSInteger comments_count;


@end



@interface DealsDetailDataHotCommentsModel : BaseModel

@property (nonatomic, assign) long long ID;
/** 评论 */
@property (nonatomic, copy) NSString *comment_content;
/** 发布时间 */
@property (nonatomic, copy) NSString *pub_time;

@property (nonatomic, assign) NSInteger supports_count;

@property (nonatomic, strong) DealsDetailDataUserModel *user;

@end

@interface DealsDetailDataUserModel : BaseModel

@property (nonatomic, copy) NSString *email;

/** 匿名 */
@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger level;
/** 头像 */
@property (nonatomic, copy) NSString *photo;

@end

