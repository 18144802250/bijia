
//
//  DealsCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsCell.h"

#import "TimeView.h"

@interface DealsCell ()

//* 左侧图片 */
@property (nonatomic, strong) UIImageView *iconIV;
//* 题目标签 */
@property (nonatomic, strong) UILabel *titleLb;
//* 来源标签 */
@property (nonatomic, strong) UILabel *sourceLb;
//* 赞标签 */
@property (nonatomic, strong) UIImageView *commentIV;
@property (nonatomic, strong) UILabel *supportLb;
//* 回复数标签 */
@property (nonatomic, strong) UIImageView *likeIV;
@property (nonatomic, strong) UILabel *commentLb;

@property (nonatomic, strong) TimeView *timeView;

@end

static NSInteger days = 0;
@implementation DealsCell

-(UIImageView *)iconIV
{
    if (_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        //内容模式:保持比例,填充满
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.clipsToBounds = YES;
    }
    return _iconIV;
}

-(UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

-(UILabel *)sourceLb
{
    if (!_sourceLb) {
        _sourceLb = [[UILabel alloc] init];
        _sourceLb.textColor = [UIColor lightGrayColor];
        _sourceLb.font = [UIFont systemFontOfSize:12];
    }
    return _sourceLb;
}

-(UILabel *)supportLb
{
    if (!_supportLb) {
        _supportLb = [[UILabel alloc] init];
        _supportLb.textColor = [UIColor lightGrayColor];
        _supportLb.font = [UIFont systemFontOfSize:12];
        _supportLb.textAlignment = NSTextAlignmentRight;
        
    }
    return _supportLb;
}

-(UILabel *)commentLb
{
    if (!_commentLb) {
        _commentLb = [[UILabel alloc] init];
        _commentLb.textColor = [UIColor lightGrayColor];
        _commentLb.font = [UIFont systemFontOfSize:12];
        _commentLb.textAlignment = NSTextAlignmentRight;
    }
    return _commentLb;
}

- (TimeView *)timeView {
    if(_timeView == nil) {
        _timeView = [[TimeView alloc] init];
    }
    return _timeView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView addSubview:self.iconIV];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.sourceLb];
        [self.contentView addSubview:self.supportLb];
        [self.contentView addSubview:self.commentLb];

        
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(90, 90));
            make.top.mas_equalTo(10);
        }];
        //题目 距离图片右边缘8,右边缘10,上边缘笔图片上边缘矮3
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.topMargin.mas_equalTo(_iconIV.mas_topMargin).mas_equalTo(8);
        }];
        //来源 与图片相邻
        [self.sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
        //评论数
        [self.commentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
        _commentIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment"]];
        _commentIV.frame = CGRectMake(0, 0, 10, 10);
        [self.contentView addSubview:_commentIV];
        [_commentIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentLb.mas_left).mas_equalTo(-5);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
        [self.supportLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentIV.mas_left).mas_equalTo(-10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
        _likeIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like"]];
        _likeIV.frame = CGRectMake(0, 0, 12, 12);
        [self.contentView addSubview:_likeIV];
        [_likeIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_supportLb.mas_left).mas_equalTo(-5);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
        
    }
    return self;
}

- (void)setDataModel:(DealsDataModel *)dataModel
{
    _dataModel = dataModel;
    
    [_iconIV setImageWithURL:dataModel.image_url];
    
    NSString *subTitle = dataModel.sub_title;
    NSString *title = [NSString stringWithFormat:@"%@ %@",dataModel.title,subTitle];
    NSRange subRange = [title rangeOfString:subTitle];
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subRange];
    _titleLb.attributedText = titleAttri;
    
    DealsDataMerchantModel *merchantModel = dataModel.merchant;
    _sourceLb.text = merchantModel.name;
    if (dataModel.supports_count == 0) {
        _likeIV.hidden = YES;
        _supportLb.hidden = YES;
    } else {
        _supportLb.text = [NSString stringWithFormat:@"%ld",dataModel.supports_count];
    }
    if (dataModel.comments_count == 0) {
        _commentIV.hidden = YES;
        _commentLb.hidden = YES;
    } else {
        _commentLb.text = [NSString stringWithFormat:@"%ld",dataModel.comments_count];
    }
    
    
    //如果是今天 则为空
    NSString *timeStr = [self timeStrFromToday];

    if (timeStr != nil) {
        //* 时间标签 */
        self.timeView.text = timeStr;
        _timeView.hidden = NO;
        [self.contentView addSubview:self.timeView];
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(33);
        }];
        [self.iconIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(35);
        }];
    } else {
        _timeView.hidden = YES;
        [self.iconIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
        }];
    }
}

/** 计算发布时间距离今天的天数，返回时间字符串 */
- (NSString *)timeStrFromToday
{
    //如果是今天，返回空 如果不是今天 返回发布时间的str
    
    if (_dataModel.daysFromToday > 0 && _dataModel.daysFromToday != days) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [formatter stringFromDate:[self publishTimeStrToDate]];
        //保存
        days = _dataModel.daysFromToday;
        return dateStr;
    }
    return nil;
}

- (NSDate*)publishTimeStrToDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];//Tue Nov 10 08:30:28 +0800 2015
    formatter.dateFormat = @"EEE MMM d HH:mm:ss z yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en-us"];
    return [formatter dateFromString:_dataModel.pub_time];
}

@end
