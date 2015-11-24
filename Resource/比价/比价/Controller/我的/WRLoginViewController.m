//
//  WRLoginViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRLoginViewController.h"
#import "ProfileLoginView.h"
#import "WRRegisViewController.h"
#import "WRQAuthViewController.h"

@interface WRLoginViewController () <ProfileLoginViewDelegate>

@property (nonatomic, strong) ProfileLoginView *loginView;

@end

@implementation WRLoginViewController

- (ProfileLoginView *)loginView {
    if(_loginView == nil) {
        _loginView = [[ProfileLoginView alloc] init];
        _loginView.delegate = self;
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLoginview];
    
}

#pragma mark - 添加登陆页
- (void)addLoginview
{
    [self.view addSubview:self.loginView];

    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - ProfileLoginViewDelegate 点击登陆 开始验证
- (void)didClickedAtLoginBtn:(UIButton *)btn userName:(NSString *)userName userPwd:(NSString *)userPwd
{
    [BmobUser loginWithUsernameInBackground:userName password:userPwd block:^(BmobUser *user, NSError *error) {
        if (error) {
            [self showErrorMsg:@"登陆失败"];
        } else {
            [self showSuccessMsg:@"登陆成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)didClickedAtRegistBtn:(UIButton *)btn
{
    WRRegisViewController *vc = [WRRegisViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickedAtSinaBtn:(UIButton *)btn
{
    WRQAuthViewController *vc = [WRQAuthViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
