//
//  ProfileCollectModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/23.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseModel.h"

@class ProfileCollectDataModel,ProfileCollectDataBmobModel;
@interface ProfileCollectModel : BaseModel

@property (nonatomic, strong) NSArray<ProfileCollectDataModel *> *data;

@end

@interface ProfileCollectDataModel : BaseModel

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) ProfileCollectDataBmobModel *bmobDataDic;

@end

@interface ProfileCollectDataBmobModel : BaseModel

@property (nonatomic, strong) NSString *picURL;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *goodPrice;
@property (nonatomic, strong) NSString *goodName;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *createdAt;

@end