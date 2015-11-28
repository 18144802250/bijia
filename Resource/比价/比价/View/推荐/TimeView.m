//
//  TimeView.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TimeView.h"

@interface TimeView ()

@property (nonatomic, strong) UIView *whiteBGV;
@property (nonatomic, strong) UILabel *textLb;

@end

@implementation TimeView

- (UIView *)whiteBGV {
    if(_whiteBGV == nil) {
        _whiteBGV = [[UIView alloc] init];
        _whiteBGV.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBGV;
}

- (UILabel *)textLb {
    if(_textLb == nil) {
        _textLb = [[UILabel alloc] init];
        _textLb.font = [UIFont systemFontOfSize:13];
        _textLb.textColor = [UIColor lightGrayColor];
    }
    return _textLb;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = NO;
    
        [self addSubview:self.whiteBGV];
        [_whiteBGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(3, 0, 0, 0));
        }];
        
        [self.whiteBGV addSubview:self.textLb];
        [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textLb.text = text;
}


@end
