//
//  ItemsCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/16.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ItemsCell.h"
#import "SearchDetailModel.h"

@interface HeadItemCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *iconIV;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLb;

/** 价格 */
@property (nonatomic, strong) UILabel *priceLb;
/** 推荐价格 */
@property (nonatomic, strong) UILabel *RecommendPriceLb;

@end

@implementation HeadItemCell

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
        _titleLb.numberOfLines = 3;
        [self.contentView addSubview:_titleLb];
    }
    return _titleLb;
}

- (UILabel *)RecommendPriceLb {
    if(_RecommendPriceLb == nil) {
        _RecommendPriceLb = [[UILabel alloc] init];
        _RecommendPriceLb.font = [UIFont systemFontOfSize:13];
        _RecommendPriceLb.textColor = [UIColor lightGrayColor];
        _RecommendPriceLb.text = @"推荐价格:";
        [self.contentView addSubview:_RecommendPriceLb];
    }
    return _RecommendPriceLb;
}

- (UILabel *)priceLb {
    if(_priceLb == nil) {
        _priceLb = [[UILabel alloc] init];
        [self.contentView addSubview:_priceLb];
    }
    return _priceLb;
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

#pragma mark - 另一个Cell

@interface ItemsCell ()
/** 是否推荐 */
@property (nonatomic, strong) UIImageView *recommendIv;

/** 是否缺货 */
@property (nonatomic, strong) UIButton *avibtn;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLb;
/** 价格 */
@property (nonatomic, strong) UILabel *priceLb;

@end

@implementation ItemsCell

- (UIImageView *)recommendIv {
    if(_recommendIv == nil) {
        _recommendIv = [[UIImageView alloc] init];
        [self.contentView addSubview:_recommendIv];
    }
    return _recommendIv;
}

- (UIButton *)avibtn {
    if(_avibtn == nil) {
        _avibtn = [[UIButton alloc] init];
        [self.contentView addSubview:_avibtn];
    }
    return _avibtn;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
    }
    return _titleLb;
}

- (UILabel *)priceLb {
    if(_priceLb == nil) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_priceLb];
    }
    return _priceLb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.recommendIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.centerY.mas_equalTo(0);
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_recommendIv.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(0);
        }];
        
        [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        [self.avibtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(88, 35));
        }];
    }
    return self;
}


- (void)setItemsModel:(SearchDetailDataItemsModel *)itemsModel
{
    _itemsModel = itemsModel;
    //是否推荐？
    if (itemsModel.recommend) {
        _recommendIv.hidden = NO;
    } else {
        _recommendIv.hidden = YES;
    }
    //电商名
    _titleLb.text = itemsModel.site_name;
    //价格 最低的绿色 普通的红色 缺货显示灰色
    if (itemsModel.available) {
        if ([itemsModel.price isEqualToString:_recommendPrice]) {
            _priceLb.textColor = [UIColor greenColor];
        } else {
            _priceLb.textColor = [UIColor redColor];
        }
    } else {
        _priceLb.textColor = [UIColor lightGrayColor];
    }
    _priceLb.text = itemsModel.price;
    
    if (itemsModel.available) {
        [_avibtn setTitle:@"去商场" forState:UIControlStateNormal];
    } else {
        [_avibtn setTitle:@"缺货" forState:UIControlStateNormal];
        [_avibtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //隐藏辅助视图
        self.accessoryView.hidden = YES;
    }
}


@end
