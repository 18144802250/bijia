//
//  WRSettingViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRSettingViewController.h"
#import "SettingView.h"


@interface WRSettingViewController () <WRBuyButtonDelegate>

@property (nonatomic, strong) SettingView *settingView;

@end

@implementation WRSettingViewController

- (SettingView *)settingView {
    if(_settingView == nil) {
        _settingView = [[SettingView alloc] init];
        _settingView.loginOutBtn.delegate = self;
    }
    return _settingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSettingView];
}

#pragma mark - 添加设置页面
- (void)addSettingView
{
    [self.view addSubview:self.settingView];
    [_settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - WRBuyButtonDelegate 退出登陆
- (void)didClickedAtBuyBtn:(UIButton *)btn
{
    [BmobUser logout];
    if ([BmobUser getCurrentUser]) {
        [self showErrorMsg:@"登出失败"];
    } else {
        [self showSuccessMsg:@"已登出"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
