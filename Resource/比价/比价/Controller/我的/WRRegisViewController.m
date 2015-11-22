//
//  WRRegisViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRRegisViewController.h"
#import "ProfileRegistView.h"

@interface WRRegisViewController ()<ProfileRegistViewDelegate>

@property (nonatomic, strong) ProfileRegistView *registView;

@end

@implementation WRRegisViewController

- (ProfileRegistView *)registView {
    if(_registView == nil) {
        _registView = [[ProfileRegistView alloc] init];
        _registView.delegate = self;
    }
    return _registView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRegisview];
}


#pragma mark - 添加注册页
- (void)addRegisview
{
    [self.view addSubview:self.registView];
    
    [self.registView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - ProfileLoginViewDelegate 点击登陆 开始验证
- (void)didClickedAtRegisBtn:(UIButton *)btn userName:(NSString *)userName userPwd:(NSString *)userPwd
{
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:userName];
    [bUser setPassword:userPwd];

    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            [self showSuccessMsg:@"注册成功"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            [self showErrorMsg:@"注册失败"];
        }
    }];
    
}

@end
