//
//  ProfileCollectCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileCollectCell.h"
#import "ProfileCollectModel.h"

@interface ProfileCollectCell ()

@property (nonatomic, strong) UIImageView *collectIV;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *sourLb;

@end

@implementation ProfileCollectCell

- (UIImageView *)collectIV {
	if(_collectIV == nil) {
		_collectIV = [[UIImageView alloc] init];
        _collectIV.contentMode = UIViewContentModeScaleAspectFill;
        _collectIV.clipsToBounds = YES;
        [self.contentView addSubview:_collectIV];
	}
	return _collectIV;
}

- (UILabel *)titleLb {
	if(_titleLb == nil) {
		_titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.numberOfLines = 2;
        [self.contentView addSubview:_titleLb];
	}
	return _titleLb;
}
- (UILabel *)priceLb {
    if(_priceLb == nil) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.backgroundColor = [UIColor whiteColor];
    }
    return _priceLb;
}

- (UILabel *)sourLb {
	if(_sourLb == nil) {
		_sourLb = [[UILabel alloc] init];
        _sourLb.font = [UIFont systemFontOfSize:12];
        _sourLb.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_sourLb];
	}
	return _sourLb;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor=[UIColor darkGrayColor].CGColor;
        self.layer.borderWidth=0.3;
        
        CGFloat colloctIVH = (kWindowW - 30)/2;
        
        [self.collectIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(colloctIVH);
        }];
        
        [self.collectIV addSubview:self.priceLb];
        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_collectIV.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);

        }];
        
        [self.sourLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setDataModel:(ProfileCollectDataBmobModel *)dataModel
{
    _dataModel = dataModel;
    
    [_collectIV setImageWithURL:[NSURL URLWithString:dataModel.picURL]];
    _priceLb.text = dataModel.goodPrice;
    _titleLb.text = dataModel.goodName;
    _sourLb.text = dataModel.source;
}

@end
