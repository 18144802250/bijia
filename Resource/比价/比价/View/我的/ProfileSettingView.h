//
//  ProfileSettingView.h
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileSettingViewDelegate <NSObject>

@optional
- (void)didClickedAtConfirmBtn:(UIButton*)btn nickName:(NSString*)nickName;

@end


@interface ProfileSettingView : UIView

@property (nonatomic, strong) id <ProfileSettingViewDelegate> delegate;

+ (instancetype)showInrect:(CGRect)frame;

+ (void)hide;

@end
