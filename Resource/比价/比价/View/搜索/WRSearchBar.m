//
//  WRSearchBar.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRSearchBar.h"
#import "UIImage+Extension.h"

@implementation WRSearchBar

- (UIButton *)cancelBtn {
    if(_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelBtn.backgroundColor = kNaviTitleColor;
        _cancelBtn.hidden = YES;
    }
    return _cancelBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:14];
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        searchIcon.width += 10;
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 35));
        }];
        
    }
    return self;
}

@end
