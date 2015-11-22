//
//  ProfileSettingView.m
//  比价
//
//  Created by apple-jd28 on 15/11/22.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileSettingView.h"

@interface ProfileSettingView ()

@property (nonatomic, strong) UITextField *inputTF;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation ProfileSettingView



- (UITextField *)inputTF {
	if(_inputTF == nil) {
		_inputTF = [[UITextField alloc] init];
        _inputTF.placeholder = @"请输入你的呢名";
        [self addSubview:_inputTF];
	}
	return _inputTF;
}

- (UIButton *)confirmBtn {
	if(_confirmBtn == nil) {
		_confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.backgroundColor = kNaviTitleColor;
        [_confirmBtn bk_addEventHandler:^(id sender) {
            if ([_delegate respondsToSelector:@selector(didClickedAtConfirmBtn:nickName:)]) {
                if (_inputTF.text.length < 1) {
                    [self showErrorMsg:@"呢名不能为空"];
                    return;
                }
                [_delegate didClickedAtConfirmBtn:_confirmBtn nickName:_inputTF.text];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmBtn];
	}
	return _confirmBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-40);
        }];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_inputTF.mas_bottom).mas_equalTo(10);
        }];
        
    }
    return self;
}

+ (instancetype)showInrect:(CGRect)frame
{
    ProfileSettingView *settingView = [[ProfileSettingView alloc] initWithFrame:frame];
    
    [Keywindow addSubview:settingView];
    
    return settingView;
}

+ (void)hide
{
    for (UIView *view in Keywindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}

@end
