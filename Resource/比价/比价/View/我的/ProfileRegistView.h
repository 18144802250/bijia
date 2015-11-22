//
//  ProfileRegistView.h
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileRegistViewDelegate <NSObject>

@optional
- (void)didClickedAtRegisBtn:(UIButton*)btn userName:(NSString*)userName userPwd:(NSString*)userPwd;

@end

@interface ProfileRegistView : UIImageView

@property (nonatomic, strong) id <ProfileRegistViewDelegate> delegate;

@end
