//
//  ProfileModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileModel : NSObject
/** 用户名 */
@property (nonatomic, strong) NSString *userName;
/** 用户密码 */
@property (nonatomic, strong) NSString *userPwd;
/** 用户呢名 */
@property (nonatomic, strong) NSString *nickName;

@end
