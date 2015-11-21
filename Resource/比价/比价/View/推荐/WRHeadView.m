//
//  WRHeadView.m
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRHeadView.h"

@interface WRHeadView ()

@property (nonatomic, strong) UILabel *textLb;

@end

@implementation WRHeadView

- (UILabel *)textLb {
    if(_textLb == nil) {
        _textLb = [[UILabel alloc] init];
        _textLb.backgroundColor = [UIColor clearColor];
    }
    return _textLb;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        
        [self addSubview:self.textLb];
        [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 12, 0, 0));
        }];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;

    _textLb.text = text;
}

@end
