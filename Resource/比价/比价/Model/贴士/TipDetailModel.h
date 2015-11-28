//
//  TipDetailModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"
#import "DealsDetailModel.h"

@class TipDetailDataModel,TipDetailDataSectionListModel,TipDetailDataAuthorModel,TipDetailDataCategoryModel,TipDetailDataHotCommentsModel;
@interface TipDetailModel : BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) TipDetailDataModel *data;

@end
@interface TipDetailDataModel : NSObject

@property (nonatomic, copy) NSString *file_url;

@property (nonatomic, assign) NSInteger guide_id;

@property (nonatomic, copy) NSString *total_size;
/** 发布时间 */
@property (nonatomic, copy) NSString *update_date;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** webView标题 */
@property (nonatomic, copy) NSString *webViewTitle;

@property (nonatomic, strong) NSArray<TipDetailDataHotCommentsModel *> *hot_comments;

@property (nonatomic, copy) NSString *catalog;

@property (nonatomic, copy) NSString *cover_image_url;

@property (nonatomic, copy) NSString *is_recommended;
/** 评论数 */
@property (nonatomic, assign) NSInteger comments_count;
/** 简介 */
@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *title_pinyin;

@property (nonatomic, strong) NSArray<TipDetailDataCategoryModel *> *category;

@property (nonatomic, copy) NSString *pagenum;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *last_modify_log;

@property (nonatomic, assign) CGFloat grade;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign) NSInteger download_count;
/** webView需要加载的数据 */
@property (nonatomic, strong) NSArray<TipDetailDataSectionListModel *> *section_list;
/** 作者 */
@property (nonatomic, strong) NSArray<TipDetailDataAuthorModel *> *author;

@property (nonatomic, copy) NSString *digest;

/** 图片链接 */
@property (nonatomic, copy) NSString *image_url;
/** 页面展示xml */
@property (nonatomic, copy) NSString *page;

@end

@interface TipDetailDataSectionListModel : BaseModel

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *title;
/** xml文件 */
@property (nonatomic, copy) NSString *content;

@end

@interface TipDetailDataAuthorModel : BaseModel
/** 呢名 */
@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *job;

@end

@interface TipDetailDataCategoryModel : BaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@end

@interface TipDetailDataHotCommentsModel : DealsDetailDataHotCommentsModel

@end


