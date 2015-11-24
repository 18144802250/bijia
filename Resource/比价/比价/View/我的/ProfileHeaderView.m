//
//  ProfileHeaderView.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileHeaderView.h"

#define LoginStr @"点击登陆收藏"
#define WelcomeStr @"欢迎开启比意绿色购物之旅!"

@interface ProfileHeaderView ()

@property (nonatomic, strong) UILabel *welcomeLb;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UIButton *setNickNameBtn;


@end

@implementation ProfileHeaderView


- (UILabel *)welcomeLb {
	if(_welcomeLb == nil) {
		_welcomeLb = [[UILabel alloc] init];
        _welcomeLb.textColor = [UIColor whiteColor];
        _welcomeLb.text = WelcomeStr;
        _welcomeLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_welcomeLb];
	}
	return _welcomeLb;
}

- (UIButton *)loginBtn {
	if(_loginBtn == nil) {
		_loginBtn = [[UIButton alloc] init];
        
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:LoginStr forState:UIControlStateNormal];
        [_loginBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtLoginBtn:)]) {
                [_delegate didClickedAtLoginBtn:_loginBtn];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginBtn];
	}
	return _loginBtn;
}

- (UILabel *)userNameLb {
    if(_userNameLb == nil) {
        _userNameLb = [[UILabel alloc] init];
        _userNameLb.text = @"当前用户:";
        _userNameLb.hidden = YES;
        [self addSubview:_userNameLb];
    }
    return _userNameLb;
}

- (UIButton *)setNickNameBtn {
    if(_setNickNameBtn == nil) {
        _setNickNameBtn = [[UIButton alloc] init];
        [_setNickNameBtn setTitle:@"设置呢名" forState:UIControlStateNormal];
        _setNickNameBtn.titleLabel.backgroundColor = kNaviTitleColor;
        _setNickNameBtn.hidden = YES;
        [_setNickNameBtn bk_addEventHandler:^(id sender) {
            if ([_delegate respondsToSelector:@selector(didClickedAtSetNickNameBtn:)]) {
                [_delegate didClickedAtSetNickNameBtn:_setNickNameBtn];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_setNickNameBtn];
    }
    return _setNickNameBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor grayColor];
        
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        [self.userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_loginBtn.mas_left).mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        }];
        
        [self.setNickNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_loginBtn.mas_right).mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
        
        [self.welcomeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_loginBtn.mas_top).mas_equalTo(-15);
            make.centerX.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (void)setProfileUserName:(NSString *)profileUserName
{
    _profileUserName = profileUserName;
    
    
    //如果登出
    if (!profileUserName) {
        _welcomeLb.text = WelcomeStr;
        _userNameLb.hidden = YES;
        
        [_loginBtn setTitle:LoginStr forState:UIControlStateNormal];
        _loginBtn.enabled = YES;
        
        _setNickNameBtn.hidden = YES;
    } else {
        //如果登入，修改呢名
        _welcomeLb.text = @"欢迎回来";
        
        _userNameLb.hidden = NO;
        
        [_loginBtn setTitle:profileUserName forState:UIControlStateNormal];
        _loginBtn.enabled = NO;
        
        _setNickNameBtn.hidden = NO;
    }
    
    
}

@end
