

//
//  WRBmobTool.m
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRBmobTool.h"

@implementation WRBmobTool

+ (NSString *)nickNameFromCurrentUser
{
    BmobUser *user = [BmobUser getCurrentUser];

    return [user objectForKey:@"nickName"];
}

+ (NSString *)userNameFormCurrentUser
{
    return [[BmobUser getCurrentUser] objectForKey:@"username"];
}

+ (void)setCurrenUserWithNewNickName:(NSString *)nickName result:(ResultBlock)result
{
    BmobUser *bUser = [BmobUser getCurrentUser];
    [bUser setObject:nickName forKey:@"nickName"];
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        result(isSuccessful);
    }];
}

@end
