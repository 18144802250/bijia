//
//  ShareLableView.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ShareLableView.h"
#import "TipListModel.h"
#import "DealsModel.h"

@interface ShareLableView ()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *subIntroLb;
@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UILabel *nameLb;

@end

@implementation ShareLableView

- (UILabel *)titleLb {
	if(_titleLb == nil) {
		_titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = [UIColor whiteColor];
        [self addSubview:_titleLb];
	}
	return _titleLb;
}

- (UILabel *)subIntroLb {
	if(_subIntroLb == nil) {
		_subIntroLb = [[UILabel alloc] init];
        _subIntroLb.font = [UIFont systemFontOfSize:14];
        _subIntroLb.textAlignment = NSTextAlignmentCenter;
        _subIntroLb.textColor = [UIColor whiteColor];
        [self addSubview:_subIntroLb];
	}
	return _subIntroLb;
}

- (UIImageView *)headIcon {
	if(_headIcon == nil) {
		_headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _headIcon.contentMode = UIViewContentModeScaleAspectFill;
        _headIcon.clipsToBounds = YES;
        _headIcon.layer.cornerRadius = 10/2;
         [self addSubview:_headIcon];
	}
	return _headIcon;
}

- (UILabel *)nameLb {
	if(_nameLb == nil) {
		_nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:10];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.textColor = [UIColor whiteColor];
        [self addSubview:_nameLb];
	}
	return _nameLb;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 1;
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.mas_equalTo(0);

        }];
        [self.subIntroLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(10);
            make.centerX.mas_equalTo(0);
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.centerX.mas_equalTo(0);
        }];
        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_nameLb.mas_left).mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
    }
    return self;
}

- (void)setDataModel:(TipListDataModel *)dataModel
{
    _dataModel = dataModel;
    
    _titleLb.text = dataModel.title;
    _subIntroLb.text = dataModel.intro;
    TipListDataAuthorModel *author = dataModel.author[0];
    _nameLb.text = author.nick_name;
    [_headIcon setImageWithURL:author.photo];
}

- (void)setDdModel:(DealsDataModel *)ddModel
{
    _ddModel = ddModel;
    
    _titleLb.text = ddModel.title;
    _subIntroLb.text = ddModel.sub_title;
    DealsDataUserModel *user = ddModel.user;
    _nameLb.text = user.nickname;
    [_headIcon setImageWithURL:user.photo];
}

@end
