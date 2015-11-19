//
//  ShopPriceHeaderView.m
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ShopPriceHeaderView.h"
#import "SearchDetailModel.h"

@interface ShopPriceHeaderView ()

/** 图片 */
@property (nonatomic, strong) UIImageView *iconIV;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLb;

/** 价格 */
@property (nonatomic, strong) UILabel *priceLb;
/** 推荐价格 */
@property (nonatomic, strong) UILabel *RecommendPriceLb;

@end

@implementation ShopPriceHeaderView

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.clipsToBounds = YES;
        [self addSubview:_iconIV];
    }
    return _iconIV;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.numberOfLines = 3;
        [self addSubview:_titleLb];
    }
    return _titleLb;
}

- (UILabel *)RecommendPriceLb {
    if(_RecommendPriceLb == nil) {
        _RecommendPriceLb = [[UILabel alloc] init];
        _RecommendPriceLb.font = [UIFont systemFontOfSize:13];
        _RecommendPriceLb.textColor = [UIColor lightGrayColor];
        _RecommendPriceLb.text = @"推荐价格:";
        [self addSubview:_RecommendPriceLb];
    }
    return _RecommendPriceLb;
}

- (UILabel *)priceLb {
    if(_priceLb == nil) {
        _priceLb = [[UILabel alloc] init];
        [self addSubview:_priceLb];
    }
    return _priceLb;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(88, 88));
        }];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-18);
            make.topMargin.mas_equalTo(_iconIV.mas_topMargin).mas_equalTo(0);
        }];
        
        [self.RecommendPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(0);
        }];
        [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_RecommendPriceLb.mas_right).mas_equalTo(10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(0);
        }];
        
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

- (void)setDataModel:(SearchDetailDataModel *)dataModel
{
    _dataModel = dataModel;
    
    [_iconIV setImageWithURL:dataModel.image_url];
    _titleLb.text = dataModel.title;
    _priceLb.text = dataModel.recommend_price;
}


@end
