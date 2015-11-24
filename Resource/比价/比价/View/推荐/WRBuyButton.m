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
        [_buyBtn setBackgroundColor:[UIColor redColor]];
        _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_buyBtn bk_addEventHandler:^(id sender) {
            if ([_delegate respondsToSelector:@selector(didClickedAtBuyBtn:)]) {
                [_delegate didClickedAtBuyBtn:_buyBtn];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.buyBtn];
        CGFloat w = 300;
        CGFloat h = 50;
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [_buyBtn setTitle:title forState:UIControlStateNormal];
}

@end
