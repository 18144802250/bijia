//
//  ProfileView.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileHeaderView.h"
#import "ProfileCollectView.h"

@interface ProfileView : UIView

@property (nonatomic, strong) ProfileHeaderView *headView;

@property (nonatomic, strong) ProfileCollectView *collectView;

@end
