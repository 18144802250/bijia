//
//  WRSearchResultViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/14.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRSearchResultViewController.h"
#import "SearchResultCell.h"
#import "SearchResultViewModel.h"
#import "WRShopPriceViewController.h"

@interface WRSearchResultViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SearchResultViewModel *sResultVM;

@end

@implementation WRSearchResultViewController

- (instancetype)initWithQuest:(NSString *)quest
{
    if (self = [super init]) {
        
        _quest = quest;
    }
    return self;
}

/** 预防init */

- (instancetype)init
{
    if (self = [super init]) {
        
        NSAssert1(NO, @"%s 请使用initWithType初始化", __FUNCTION__);
        
    }
    return self;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 100;
        [_tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (SearchResultViewModel *)sResultVM {
    if(_sResultVM == nil) {
        _sResultVM = [[SearchResultViewModel alloc] initWithQuest:_quest];
    }
    return _sResultVM;
}

- (void)setQuest:(NSString *)quest
{
    _quest = quest;
    _sResultVM.quest = quest;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.sResultVM refreshDataCompletionHandle:^(NSError *error) {
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.sResultVM getMoreDataCompletionHandle:^(NSError *error) {
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
}

#pragma mark - tableView数据源配置

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sResultVM.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.resultModel = self.sResultVM.dataArr[indexPath.row];
    
    return cell;
}

#pragma mark - tableViewDelegate 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchResultDataItemsModel *itemModel = self.sResultVM.dataArr[indexPath.row];
    
//    if ([_delegate respondsToSelector:@selector(didClickedAtCellWithID:)]) {
        [_delegate didClickedAtCellWithID:itemModel.ID];
//    }
    
}

@end
