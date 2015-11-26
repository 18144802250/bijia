//
//  BaseModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@end

@class BaseDetailDataUserModel;
@interface BaseDetailDataHotCommentsModel : BaseModel

@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *comment_content;

@property (nonatomic, copy) NSString *pub_time;

@property (nonatomic, assign) NSInteger supports_count;

@end

@interface BaseDetailDataUserModel : BaseModel

@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *photo;

@end