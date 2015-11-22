//
//  ProfileHeaderView.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileHeaderViewDelegate <NSObject>

@optional
- (void)didClickedAtLoginBtn:(UIButton*)btn;

- (void)didClickedAtSetNickNameBtn:(UIButton*)btn;

@end


@interface ProfileHeaderView : UIImageView

@property (nonatomic, strong) id<ProfileHeaderViewDelegate> delegate;

/** 设置用户名 */
@property (nonatomic, strong) NSString *profileUserName;

@end
