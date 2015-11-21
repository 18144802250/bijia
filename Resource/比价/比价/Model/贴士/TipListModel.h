//
//  TipListModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class TipListDataModel,TipListDataAuthorModel,TipListDataCategoryModel;
@interface TipListModel : BaseModel


@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<TipListDataModel *> *data;


@end
@interface TipListDataModel : BaseModel

@property (nonatomic, strong) NSArray<TipListDataAuthorModel *> *author;

@property (nonatomic, strong) NSArray<TipListDataCategoryModel *> *category;

@property (nonatomic, assign) NSInteger download_count;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 通过id获取页面url */
@property (nonatomic, assign) NSInteger guide_id;

@property (nonatomic, assign) CGFloat grade;

@property (nonatomic, copy) NSString *update_date;

@property (nonatomic, copy) NSString *type;
/** 评论数 */
@property (nonatomic, assign) NSInteger comments_count;
/** 简介 */
@property (nonatomic, copy) NSString *intro;
/** 图片链接 */
@property (nonatomic, copy) NSURL *cover_image_url;

@end

@interface TipListDataAuthorModel : BaseModel
/** 呢名 */
@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, copy) NSString *intro;
/** 图片 */
@property (nonatomic, copy) NSURL *photo;

@property (nonatomic, copy) NSString *job;

@end

@interface TipListDataCategoryModel : BaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@end

