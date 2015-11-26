//
//  TipCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TipCell.h"

@interface TipCell ()
//* 图片 */
@property(nonatomic,strong)UIImageView *iconIV;
//* 题目标签 */
@property(nonatomic,strong)UILabel *titleLb;
//* 来源标签 */
@property(nonatomic,strong)UILabel *sourceLb;
//*子标题 */
@property(nonatomic,strong)UILabel *subTitleLb;
//* 回复数标签 */
@property(nonatomic,strong)UILabel *commentLb;

@end

@implementation TipCell

-(UIImageView *)iconIV
{
    if (_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        //内容模式:保持比例,填充满
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.clipsToBounds = YES;
        [self.contentView addSubview:_iconIV];
    }
    return _iconIV;
}

-(UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.numberOfLines = 1;
        [self.contentView addSubview:_titleLb];
    }
    return _titleLb;
}

-(UILabel *)subTitleLb
{
    if (!_subTitleLb) {
        _subTitleLb = [[UILabel alloc] init];
        _subTitleLb.textColor = [UIColor lightGrayColor];
        _subTitleLb.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_subTitleLb];
    }
    return _subTitleLb;
}

-(UILabel *)sourceLb
{
    if (!_sourceLb) {
        _sourceLb = [[UILabel alloc] init];
        _sourceLb.textColor = [UIColor lightGrayColor];
        _sourceLb.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_sourceLb];
    }
    return _sourceLb;
}
-(UILabel *)commentLb
{
    if (!_commentLb) {
        _commentLb = [[UILabel alloc] init];
        _commentLb.textColor = [UIColor lightGrayColor];
        _commentLb.font = [UIFont systemFontOfSize:12];
        _commentLb.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_commentLb];
    }
    return _commentLb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(70, 90));
            make.centerY.mas_equalTo(0);
        }];
        //题目 距离图片右边缘8,右边缘10,上边缘笔图片上边缘矮3
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.topMargin.mas_equalTo(_iconIV.mas_topMargin).mas_equalTo(8);
        }];
        [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
        //来源 与图片相邻
        [self.sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-2);
        }];
        //评论数
        [self.commentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-2);
        }];
        UIImageView *commentIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment"]];
        [self.contentView addSubview:commentIV];
        [commentIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentLb.mas_left).mas_equalTo(-5);
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin).mas_equalTo(-2);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        
    }
    return self;
}

- (void)setDataModel:(TipListDataModel *)dataModel
{
    _dataModel = dataModel;
    
    [_iconIV setImageWithURL:dataModel.cover_image_url];
    _titleLb.text = dataModel.title;
    _subTitleLb.text = dataModel.intro;
    TipListDataAuthorModel *author = dataModel.author[0];
    _sourceLb.text = author.nick_name;
    _commentLb.text = [NSString stringWithFormat:@"%ld",dataModel.comments_count];
}

@end
