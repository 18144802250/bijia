
//
//  ShowPicCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ShowPicCell.h"
#import "TipListModel.h"
#import "ShareLableView.h"
#import "DealsModel.h"

@interface ShowPicCell ()

@property (nonatomic, strong) UIImageView *bigIV;

@property (nonatomic, strong) ShareLableView *lableView;

@end

@implementation ShowPicCell



- (ShareLableView *)lableView {
	if(_lableView == nil) {
		_lableView = [[ShareLableView alloc] init];
    
	}
	return _lableView;
}

- (UIImageView *)bigIV {
	if(_bigIV == nil) {
		_bigIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_bigIV];
	}
	return _bigIV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.bigIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.bottom.mas_equalTo(-15);
        }];
        
        
        [self.bigIV addSubview:self.lableView];
        [_lableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(86);
        }];
    }
    return self;
}

- (void)setDataModel:(DealsDataModel *)dataModel
{
    _dataModel = dataModel;
    [_bigIV setImageWithURL:dataModel.image_url];
    _lableView.ddModel = dataModel;
}

- (void)setTlModel:(TipListDataModel *)tlModel
{
    _tlModel = tlModel;
    [_bigIV setImageWithURL:tlModel.cover_image_url];
    _lableView.dataModel = tlModel;
}

@end
