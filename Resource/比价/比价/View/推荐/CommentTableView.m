//
//  CommentTableView.m
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "CommentTableView.h"
#import "TipDetailModel.h"
#import "WRHeadView.h"

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) TipDetailDataHotCommentsModel *commontModel;

@end

@interface CommentCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *commentLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation CommentCell

- (UIImageView *)icon {
    if(_icon == nil) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
        /** 圆角设置 */
        _icon.layer.cornerRadius = 38/2;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:12];
        _nameLb.textColor = [UIColor lightGrayColor];
    }
    return _nameLb;
}

- (UILabel *)commentLb {
    if(_commentLb == nil) {
        _commentLb = [[UILabel alloc] init];
        _commentLb.font = [UIFont systemFontOfSize:14];
        _commentLb.numberOfLines = 1;
    }
    return _commentLb;
}

- (UILabel *)timeLb {
    if(_timeLb == nil) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.textColor = [UIColor lightGrayColor];
        _timeLb.textAlignment = NSTextAlignmentRight;
    }
    return _timeLb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.commentLb];
        [self.contentView addSubview:self.timeLb];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(38, 38));
            make.left.mas_equalTo(10);
        }];
        
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(_icon.mas_topMargin).mas_equalTo(0);
            make.left.mas_equalTo(_icon.mas_right).mas_equalTo(10);
            
        }];
        
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(_icon.mas_topMargin).mas_equalTo(0);
            make.right.mas_equalTo(-10);
        }];
        
        [self.commentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottomMargin.mas_equalTo(_icon.mas_bottomMargin).mas_equalTo(3);
            make.left.mas_equalTo(_icon.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
    }
    return self;
}

- (void)setCommontModel:(TipDetailDataHotCommentsModel *)commontModel
{
    _commontModel = commontModel;
    
    DealsDetailDataUserModel *userModel = commontModel.user;
    
    [_icon setImageWithURL:[NSURL URLWithString:userModel.photo] placeholderImage:[UIImage imageNamed:@"success"]];
    
    _nameLb.text = userModel.nickname;
    
    _timeLb.text = commontModel.pub_time;
    
    _commentLb.text = commontModel.comment_content;
}

@end

@interface CommentTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) WRHeadView *headView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CommentTableView

- (WRHeadView *)headView {
    if(_headView == nil) {
        _headView = [[WRHeadView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 40)];
    }
    return _headView;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        self.headView.text = @"热门评论";
        _tableView.tableHeaderView = _headView;
        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 55;
        [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setHotCommentArr:(NSArray *)hotCommentArr
{
    _hotCommentArr = hotCommentArr;
    
    if (hotCommentArr.count == 3) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"点击查看更多评论" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn bk_addEventHandler:^(id sender) {
            
            if ([_delegate respondsToSelector:@selector(didClickedAtMoreCommentBtn)]) {
                [_delegate didClickedAtMoreCommentBtn];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, 100, 35);
        _tableView.tableFooterView = btn;
    }
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.hotCommentArr.count;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.commontModel = self.hotCommentArr[indexPath.row];
    return cell;
}





@end
