//
//  ProfileLoginView.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileLoginViewDelegate <NSObject>

@optional
- (void)didClickedAtLoginBtn:(UIButton*)btn userName:(NSString*)userName userPwd:(NSString*)userPwd;

- (void)didClickedAtRegistBtn:(UIButton*)btn;

- (void)didClickedAtSinaBtn:(UIButton*)btn;

@end

@interface ProfileLoginView : UIImageView

@property (nonatomic, strong) id <ProfileLoginViewDelegate> delegate;

@end
