
//
//  DealsCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsCell.h"

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
        _titleLb.font = [UIFont systemFontOfSize:17];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

-(UILabel *)subTitleLb{
    if (_subTitleLb == nil) {
        _subTitleLb = [[UILabel alloc] init];
        _subTitleLb.font = [UIFont systemFontOfSize:17];
        _subTitleLb.textColor = [UIColor redColor];
    }
    return _subTitleLb;
}
-(UILabel *)sourceLb
{
    if (!_sourceLb) {
        _sourceLb = [[UILabel alloc] init];
        _sourceLb.textColor = [UIColor lightGrayColor];
        _sourceLb.font = [UIFont systemFontOfSize:13];
    }
    return _sourceLb;
}

-(UILabel *)supportLb
{
    if (!_supportLb) {
        _supportLb = [[UILabel alloc] init];
        _supportLb.textColor = [UIColor lightGrayColor];
        _supportLb.font = [UIFont systemFontOfSize:13];
    }
    return _sourceLb;
}

-(UILabel *)commentLb
{
    if (!_commentLb) {
        _commentLb = [[UILabel alloc] init];
        _commentLb.textColor = [UIColor lightGrayColor];
        _commentLb.font = [UIFont systemFontOfSize:13];
    }
    return _commentLb;
}

@end
