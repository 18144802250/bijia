//
//  WRCommendViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRCommendViewController.h"
#import "DealsCell.h"
#import "DealsViewModel.h"
#import "WRNaviTool.h"
#import "WRTool.h"
#import "DealsDetailViewController.h"
#import "WRSearchViewController.h"
#import "WRTitleBarButton.h"

@interface WRCommendViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DealsViewModel *dealsVM;

@end

@implementation WRCommendViewController


- (id)initWithType:(CategoryType)type
{
    
    if (self = [super init]) {
        
        _type = type;
        
    }
    return self;
}

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
        
        [_tableView registerClass:[DealsCell class] forCellReuseIdentifier:@"Cell"];
        
    }
    return _tableView;
}

- (DealsViewModel *)dealsVM {
    if(_dealsVM == nil) {
        _dealsVM = [[DealsViewModel alloc] initWithType:_type];
    }
    return _dealsVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    WRTitleBarButton *titleBtn = [WRTitleBarButton new];
    
#pragma mark - 点击开启全网搜索 跳转页面
    [titleBtn bk_addEventHandler:^(id sender) {
        
        WRSearchViewController *vc = [WRSearchViewController standerSearchVC];
        
        
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:navi animated:NO completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
    
    [WRNaviTool addLeftNaviItemAtViewC:self];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dealsVM refreshDataCompletionHandle:^(NSError *error) {
            
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.dealsVM getMoreDataCompletionHandle:^(NSError *error) {
            
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
        }];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dealsVM.rowNumber;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //如果不是今天的日期
    if ([self.dealsVM timeWithRow:indexPath.row]) {
        cell.dataModel = self.dealsVM.dataArr[indexPath.row];
        cell.timeView.text = [self.dealsVM timeWithRow:indexPath.row];
    }
    
    [cell.iconIV setImageWithURL:[self.dealsVM picURLWithRow:indexPath.row]];
    
    cell.titleLb.attributedText = [self.dealsVM titleWithRow:indexPath.row];
    
    cell.sourceLb.text = [self.dealsVM sourceWithRow:indexPath.row];
    
    cell.supportLb.text = [self.dealsVM supportWithRow:indexPath.row];
    
    cell.commentLb.text = [self.dealsVM commentWithRow:indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.dealsVM timeWithRow:indexPath.row]?135:100;
}

kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DealsDetailViewController *vc = [[DealsDetailViewController alloc] initWithIdStr:[self.dealsVM idStrWithRow:indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
