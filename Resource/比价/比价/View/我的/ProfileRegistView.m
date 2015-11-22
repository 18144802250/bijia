//
//  ProfileRegistView.m
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileRegistView.h"

@interface ProfileRegistView ()

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UITextField *userNameTf;
@property (nonatomic, strong) UITextField *userNamePwd;
@property (nonatomic, strong) UIButton *regisBtn;

@end

@implementation ProfileRegistView

- (UIView *)inputView {
    if(_inputView == nil) {
        _inputView = [[UIView alloc] init];
        _inputView.backgroundColor = [UIColor blackColor];
        _inputView.alpha = 0.4;
        [self addSubview:_inputView];
    }
    return _inputView;
}

- (UITextField *)userNameTf {
    if(_userNameTf == nil) {
        _userNameTf = [[UITextField alloc] init];
        [_userNameTf setTextColor:[UIColor whiteColor]];
        UIImage *imageN = [UIImage imageNamed:@"icon"];
        UIImageView *leftVN = [[UIImageView alloc]initWithImage:imageN];
        leftVN.contentMode = UIViewContentModeCenter;
        leftVN.frame = CGRectMake(0, 0, 55, 20);
        _userNameTf.leftViewMode = UITextFieldViewModeAlways;
        _userNameTf.leftView = leftVN;
    }
    return _userNameTf;
}

- (UITextField *)userNamePwd {
    if(_userNamePwd == nil) {
        _userNamePwd = [[UITextField alloc] init];
        [_userNamePwd setTextColor:[UIColor whiteColor]];
        UIImage *imageP = [UIImage imageNamed:@"lock"];
        UIImageView *leftVP = [[UIImageView alloc]initWithImage:imageP];
        leftVP.contentMode = UIViewContentModeCenter;
        leftVP.frame = CGRectMake(0, 0, 55, 20);
        _userNamePwd.leftViewMode = UITextFieldViewModeAlways;
        _userNamePwd.leftView = leftVP;
    }
    return _userNamePwd;
}

- (UIButton *)regisBtn {
    if(_regisBtn == nil) {
        _regisBtn = [[UIButton alloc] init];
        [_regisBtn setTitle:@"注册" forState:UIControlStateNormal];
        _regisBtn.backgroundColor = kNaviTitleColor;
        [_regisBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtRegisBtn:userName:userPwd:)]) {
                [_delegate didClickedAtRegisBtn:_regisBtn userName:_userNameTf.text userPwd:_userNamePwd.text];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        [_regisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_regisBtn];
    }
    return _regisBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"背景图"];
        
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(120);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(100);
        }];
        
        [_inputView addSubview:self.userNameTf];
        [_userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [_inputView addSubview:self.userNamePwd];
        [_userNamePwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userNameTf.mas_bottom).mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_inputView.mas_bottom).mas_equalTo(40);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

@end
