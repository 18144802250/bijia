//
//  WRCommentViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/28.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRCommentViewController.h"
#import "CommentTableView.h"
#import "DealsNetManager.h"
#import "CommentModel.h"

@interface WRCommentCell : UITableViewCell

@property (nonatomic, strong) CommentCommentsModel *commontModel;

@end

@interface WRCommentCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *commentLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation WRCommentCell

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
        _commentLb.numberOfLines = 0;
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

- (void)setCommontModel:(CommentCommentsModel *)commontModel
{
    _commontModel = commontModel;
    
    CommentDataUserModel *userModel = commontModel.user;
    
    [_icon setImageWithURL:[NSURL URLWithString:userModel.photo] placeholderImage:[UIImage imageNamed:@"success"]];
    
    _nameLb.text = userModel.nickname;
    
    _timeLb.text = commontModel.pub_time;
    
    _commentLb.text = commontModel.comment_content;
}

@end

@interface WRCommentViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *commenArr;

@end

@implementation WRCommentViewController

- (instancetype)initWithID:(NSString *)idStr
{
    if (self = [super init]) {
        
        _idStr = idStr;
    }
    return self;
}

/** 预防init */
- (instancetype)init
{
    if (self = [super init]) {
        
        NSAssert1(NO, @"%s 请使用initWithID初始化", __FUNCTION__);
    }
    return self;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
//        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = UITableViewRowAnimationAutomatic;
        [_tableView registerClass:[WRCommentCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [DealsNetManager getCommentDataWithId:_idStr completionHandle:^(CommentModel *model, NSError *error) {
        
        self.commenArr = model.data.comments;
        [_tableView reloadData];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commenArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.commontModel = self.commenArr[indexPath.row];
    
    return cell;
}

@end
