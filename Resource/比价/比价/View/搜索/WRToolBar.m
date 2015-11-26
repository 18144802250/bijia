//
//  WRToolBar.m
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRToolBar.h"

#define LineW 2
#define ToolFontSize 15

@interface WRToolBar ()

@property (nonatomic, strong) UIButton *priceBtn;
@property (nonatomic, strong) UIButton *shopNumBtn;
@property (nonatomic, strong) UIImageView *waveIV;

@end

@implementation WRToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kNaviTitleColor;
        
        //按钮的宽度
        CGFloat w = (kWindowW - 2*LineW)/3;
        //添加价格波动显示按钮
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:ToolFontSize];
        [_priceBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtBtn)]) {
                [_delegate didClickedAtBtn];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        UIImageView *waveIV = [UIImageView new];
        _waveIV = waveIV;
        [self addSubview:_priceBtn];
        [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(w);
        }];
        [_priceBtn addSubview:waveIV];
        [waveIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        //添加线
        UILabel *line = [UILabel new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_priceBtn.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(LineW);
            make.top.mas_equalTo(4);
            make.bottom.mas_equalTo(-4);
        }];
        //添加多家比价
        _shopNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopNumBtn.titleLabel.font = [UIFont systemFontOfSize:ToolFontSize];
        [_shopNumBtn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtBtn)]) {
                [_delegate didClickedAtBtn];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_shopNumBtn];
        [_shopNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(w);
        }];
        //添加线
        UILabel *line2 = [UILabel new];
        line2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_shopNumBtn.mas_right).mas_equalTo(0);
            make.width.mas_equalTo(LineW);
            make.top.mas_equalTo(4);
            make.bottom.mas_equalTo(-4);
        }];
        //添加收藏按钮
        UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.titleLabel.font = [UIFont systemFontOfSize:ToolFontSize];
        [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [collectBtn bk_addEventHandler:^(id sender) {

            if ([_delegate respondsToSelector:@selector(didClickedAtCollectBtn)]) {
                [_delegate didClickedAtCollectBtn];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:collectBtn];
        [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line2.mas_right).mas_equalTo(0);
            make.top.bottom.right.mas_equalTo(0);
        }];
        _collectBtn = collectBtn;
        UIImageView *collectIV = [UIImageView new];
        collectIV.image = [UIImage imageNamed:@"收藏"];
        [_collectBtn addSubview:collectIV];
        [collectIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return self;
}

- (void)setType:(PriceWaveType)type
{
    _type = type;
    switch (type) {
        case PriceWaveTypeClam:
            [_priceBtn setTitle:@"价格平稳" forState:UIControlStateNormal];
            _waveIV.image = [UIImage imageNamed:@"clam"];
            break;
        case PriceWaveTypeDown:
            [_priceBtn setTitle:@"价格下降" forState:UIControlStateNormal];
            _waveIV.image = [UIImage imageNamed:@"down"];
            break;
        case PriceWaveTypeUp:
            [_priceBtn setTitle:@"价格上升" forState:UIControlStateNormal];
            _waveIV.image = [UIImage imageNamed:@"up"];
            break;
        default:
            break;
    }
}

- (void)setShopNum:(NSInteger)shopNum
{
    _shopNum = shopNum;
    
    if (!shopNum) {
        [_shopNumBtn setTitle:@"没有比价信息" forState:UIControlStateNormal];
    } else {
        [_shopNumBtn setTitle:[NSString stringWithFormat:@"%ld家比价",_shopNum] forState:UIControlStateNormal];
    }
}

@end
