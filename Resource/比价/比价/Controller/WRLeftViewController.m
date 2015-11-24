//
//  WRLeftViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRLeftViewController.h"
#import "WRCommendViewController.h"

@interface LeftCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UILabel *textLb;

@end

@implementation LeftCell

- (UIImageView *)leftIV {
    if(_leftIV == nil) {
        _leftIV = [[UIImageView alloc] init];
        _leftIV.contentMode = UIViewContentModeScaleAspectFill;
        _leftIV.clipsToBounds = YES;
    }
    return _leftIV;
}

- (UILabel *)textLb {
    if(_textLb == nil) {
        _textLb = [[UILabel alloc] init];
        _textLb.textColor = [UIColor blackColor];
        _textLb.textAlignment = NSTextAlignmentCenter;
        _textLb.font = [UIFont systemFontOfSize:WRItemsNameFontSize];
    }
    return _textLb;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.leftIV];
        [self.contentView addSubview:self.textLb];
        
        [self.textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_textLb.mas_left).mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
    }
    return self;
}


@end

@interface WRLeftViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *itemsName;

@property (nonatomic, strong) NSArray *contros;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation WRLeftViewController

- (NSArray *)itemsName {
    if(_itemsName == nil) {
        
       _itemsName = @[@"全部类别",@"日用百货",@"生鲜食品",@"服饰鞋包",@"美妆个护",@"运动健康",@"数码家电",@"母婴玩具"];
    }
    return _itemsName;
}

- (NSArray *)contros {
    if(_contros == nil) {
        
        NSMutableArray *arr = [NSMutableArray new];
        for (int i = 0; i < self.itemsName.count; i++) {
            WRCommendViewController *vc = [WRCommendViewController new];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
            [arr addObject:navi];
        }
        _contros = [arr copy];
    }
    return _contros;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[LeftCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 66;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWindowW*0.7, kWindowH*0.8));
        make.centerY.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsName.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLb.font = [UIFont systemFontOfSize:30];
        _selectedIndexPath = indexPath;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLb.text = self.itemsName[indexPath.row];
    
    NSString *imageStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.leftIV.image = [UIImage imageNamed:imageStr];
    
    return cell;
}

kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LeftCell *cell2 = [tableView cellForRowAtIndexPath:_selectedIndexPath];
    cell2.textLb.font = [UIFont systemFontOfSize:WRItemsNameFontSize];
    
    
    LeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLb.font = [UIFont systemFontOfSize:30];
    
    _selectedIndexPath = indexPath;

    [WRTool defaultTool].type = indexPath.row;

    [self.sideMenuViewController setContentViewController:self.contros[indexPath.row] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark - 当选定的Cell放大 怎么放大？怎么找到对应的Cell 的 文本字体设置大点



@end
