//
//  WRBuyButton.m
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRBuyButton.h"

@interface WRBuyButton ()

@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation WRBuyButton

- (UIButton *)buyBtn {
    if(_buyBtn == nil) {
        
        _buyBtn = [[UIButton alloc] init];
        
        _buyBtn.backgroundColor = kNaviTitleColor;
        _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
    }
    return _buyBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = kRGBColor(222, 222, 222);
        
        [self addSubview:self.buyBtn];
        CGFloat w = 200;
        CGFloat h = 30;
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-3);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
        
        [_buyBtn bk_addEventHandler:^(id sender) {
            DDLogVerbose(@"1111");
            if ([_delegate respondsToSelector:@selector(didClickedAtBuyBtn:)]) {
                [_delegate didClickedAtBuyBtn:_buyBtn];
            }
        } forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [_buyBtn setTitle:title forState:UIControlStateNormal];
}

@end
