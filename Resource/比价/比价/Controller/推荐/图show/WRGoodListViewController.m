//
//  WRGoodListViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRGoodListViewController.h"
#import "DealsNetManager.h"
#import "GoodlistCell.h"
#import "DealsViewModel.h"

@interface WRGoodListViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataModelArr;
@property (nonatomic, strong) DealsViewModel *dealsVM;

@end

@implementation WRGoodListViewController

- (DealsViewModel *)dealsVM {
    if(_dealsVM == nil) {
        _dealsVM = [[DealsViewModel alloc] initWithType:CategoryTypeGoodlist];
    }
    return _dealsVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = kWindowW*(480/720) + (kWindowW - 80)/3 + 20;
        
        [_tableView registerClass:[GoodlistCell class] forCellReuseIdentifier:@"Cell"];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
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

#pragma mark -tableViewDataSource 数据源配置

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _dataModelArr.count;
    return count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.glDataModel = _dataModelArr[indexPath.row];
    
    return cell;
}


kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
