//
//  WRBmobTool.h
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResultBlock)(BOOL isSuccess);

@interface WRBmobTool : NSObject

/** 返回当前用户的呢名 */
+ (NSString*)nickNameFromCurrentUser;

/** 返回当前用户的用户名 */
+ (NSString*)userNameFormCurrentUser;

/** 设置当前用户的呢名 并更新到服务器*/
+ (void)setCurrenUserWithNewNickName:(NSString*)nickName result:(ResultBlock)result;

@end
