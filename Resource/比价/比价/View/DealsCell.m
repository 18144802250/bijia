
//
//  DealsCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsCell.h"
#import "WRTool.h"



@implementation DealsCell

- (TimeView *)timeView {
    if(_timeView == nil) {
        _timeView = [[TimeView alloc] init];
    }
    return _timeView;
}

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

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.timeView];
        [self.contentView addSubview:self.iconIV];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.sourceLb];
        [self.contentView addSubview:self.supportLb];
        [self.contentView addSubview:self.commentLb];
        //图片 左10,宽高92,70,竖向居中
        

       
        
        
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(90, 90));
            make.centerY.mas_equalTo(0);
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
            make.width.mas_equalTo(50);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
        [self.supportLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentLb.mas_left).mas_equalTo(0);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-8);
        }];
    }
    return self;
}

- (void)setDataModel:(DealsDataModel *)dataModel
{
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(33);
    }];
    
    [self.iconIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(88, 88));
        make.bottom.mas_equalTo(-8);
    }];

}
@end
