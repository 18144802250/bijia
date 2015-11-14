//
//  SearchResultCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "SearchResultCell.h"

@interface SearchResultCell ()
/** 图片 */
@property (nonatomic, strong) UIImageView *iconIV;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLb;

/** 价格 */
@property (nonatomic, strong) UILabel *priceLb;

/** 商家数 */
@property (nonatomic, strong) UILabel *merchantCountLb;

@end

@implementation SearchResultCell

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.clipsToBounds = YES;
        [self.contentView addSubview:_iconIV];
    }
    return _iconIV;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.numberOfLines = 2;
        [self.contentView addSubview:_titleLb];
    }
    return _titleLb;
}

- (UILabel *)priceLb {
    if(_priceLb == nil) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceLb];
    }
    return _priceLb;
}

- (UILabel *)merchantCountLb {
    if(_merchantCountLb == nil) {
        _merchantCountLb = [[UILabel alloc] init];
        
        _merchantCountLb.textColor = [UIColor lightGrayColor];
        
        _merchantCountLb.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_merchantCountLb];
    }
    return _merchantCountLb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
        [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(0);
        }];
        [self.merchantCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setResultModel:(SearchResultDataItemsModel *)resultModel
{
    _resultModel = resultModel;
    
    [self.iconIV setImageWithURL:resultModel.image_url];
    self.titleLb.text = resultModel.title;
    self.priceLb.text = resultModel.price;
    self.merchantCountLb.text = [NSString stringWithFormat:@"%ld个商家",resultModel.merchant_count];
}

@end
