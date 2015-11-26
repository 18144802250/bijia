//
//  ProfileLoginView.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileLoginView.h"

@interface ProfileLoginView ()

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, strong) UITextField *userNameTf;

@property (nonatomic, strong) UITextField *userNamePwd;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *regisBtn;

@property (nonatomic, strong) UILabel *otherLoginLb;

@property (nonatomic, strong) UIButton *sinaBtn;

@end

@implementation ProfileLoginView

- (UIView *)inputView {
    if(_inputView == nil) {
        _inputView = [[UIView alloc] init];
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景框"]];
        [_inputView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _inputView.alpha = 0.4;
        [self addSubview:_inputView];
    }
    return _inputView;
}

- (UITextField *)userNameTf {
    if(_userNameTf == nil) {
        _userNameTf = [[UITextField alloc] init];
        [_userNameTf setTextColor:[UIColor blackColor]];
        UIImage *imageN = [UIImage imageNamed:@"icon"];
        UIImageView *leftVN = [[UIImageView alloc]initWithImage:imageN];
        leftVN.contentMode = UIViewContentModeCenter;
        leftVN.frame = CGRectMake(0, 0, 55, 20);
        _userNameTf.leftViewMode = UITextFieldViewModeAlways;
        _userNameTf.leftView = leftVN;
        _userNameTf.returnKeyType = UIReturnKeyNext;
        [WRTextFieldTool addHideDowmItemAtTFKeyboard:_userNameTf];
    }
    return _userNameTf;
}

- (UITextField *)userNamePwd {
    if(_userNamePwd == nil) {
        _userNamePwd = [[UITextField alloc] init];
        [_userNamePwd setTextColor:[UIColor blackColor]];
        [_userNamePwd setSecureTextEntry:YES];
        UIImage *imageP = [UIImage imageNamed:@"lock"];
        UIImageView *leftVP = [[UIImageView alloc]initWithImage:imageP];
        leftVP.contentMode = UIViewContentModeCenter;
        leftVP.frame = CGRectMake(0, 0, 55, 20);
        _userNamePwd.leftViewMode = UITextFieldViewModeAlways;
        _userNamePwd.leftView = leftVP;
        [WRTextFieldTool addHideDowmItemAtTFKeyboard:_userNamePwd];
        _userNameTf.returnKeyType = UIReturnKeyDone;
    }
    return _userNamePwd;
}

- (UIButton *)loginBtn {
    if(_loginBtn == nil) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = kNaviTitleColor;
        [_loginBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtLoginBtn:userName:userPwd:)]) {
                [_delegate didClickedAtLoginBtn:_loginBtn userName:_userNameTf.text userPwd:_userNamePwd.text];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIButton *)regisBtn {
    if(_regisBtn == nil) {
        _regisBtn = [[UIButton alloc] init];
        [_regisBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtRegistBtn:)]) {
                [_delegate didClickedAtRegistBtn:_regisBtn];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        [_regisBtn setTitle:@"快速注册" forState:UIControlStateNormal];
        [_regisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:_regisBtn];
    }
    return _regisBtn;
}

- (UILabel *)otherLoginLb {
    if(_otherLoginLb == nil) {
        _otherLoginLb = [[UILabel alloc] init];
        _otherLoginLb.text = @"-------- 第三方登陆 -------";
        _otherLoginLb.textColor = [UIColor lightGrayColor];
        _otherLoginLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_otherLoginLb];
    }
    return _otherLoginLb;
}

- (UIButton *)sinaBtn {
    if(_sinaBtn == nil) {
        _sinaBtn = [[UIButton alloc] init];
        [_sinaBtn setImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
        [_sinaBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtSinaBtn:)]) {
                [_delegate didClickedAtSinaBtn:_sinaBtn];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sinaBtn];
    }
    return _sinaBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"head4"];
        
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
        
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_inputView.mas_bottom).mas_equalTo(40);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(40);
        }];
        
        [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginBtn.mas_bottom).mas_equalTo(30);
            make.right.mas_equalTo(-40);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        
        [self.sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(53, 53));
            make.bottom.mas_equalTo(-50);
        }];
        
        [self.otherLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_sinaBtn.mas_top).mas_equalTo(-34);
            make.centerX.mas_equalTo(0);
        }];
        
    }
    return self;
}





@end
