//
//  SettingView.h
//  比价
//
//  Created by apple-jd28 on 15/11/23.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRBuyButton.h"

@protocol SettingViewDelegate <NSObject>

@optional
- (void)didClickAtTableViewCellWithRow:(NSUInteger)row;

@end

@interface SettingView : UIView

@property (nonatomic, strong) WRBuyButton *loginOutBtn;
@property (nonatomic, strong) id <SettingViewDelegate> delegate;

@end
