//
//  CommentModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/28.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class CommentDataModel,CommentCommentsModel,CommentDataUserModel;
@interface CommentModel : BaseModel


@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) CommentDataModel *data;


@end
@interface CommentDataModel : NSObject

@property (nonatomic, strong) NSArray<CommentCommentsModel *> *comments;

@property (nonatomic, strong) NSArray *hot_comments;

@end

@interface CommentCommentsModel : BaseModel

@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *comment_content;

@property (nonatomic, copy) NSString *pub_time;

@property (nonatomic, assign) NSInteger supports_count;

@property (nonatomic, strong) CommentDataUserModel *user;

@end

@interface CommentDataUserModel : BaseModel

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *photo;

@end

