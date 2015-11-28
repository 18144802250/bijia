//
//  WRTipViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTipViewController.h"
#import "TipViewModel.h"
#import "TipCell.h"
#import "ShowPicCell.h"
#import "WRTipDetailViewController.h"

@interface WRTipViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TipViewModel *tipVM;

@end

@implementation WRTipViewController

- (TipViewModel *)tipVM {
    if(_tipVM == nil) {
        _tipVM = [[TipViewModel alloc] initWithType:_type];
    }
    return _tipVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = kWindowW*(480/720) + (kWindowW - 80)/3 + 20;
        
        [_tableView registerClass:[TipCell class] forCellReuseIdentifier:@"tip"];
        [_tableView registerClass:[ShowPicCell class] forCellReuseIdentifier:@"show"];

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
        [self.tipVM refreshDataCompletionHandle:^(NSError *error) {
            
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tipVM getMoreDataCompletionHandle:^(NSError *error) {
            
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
        }];
    }];
}

#pragma mark -tableViewDataSource 数据源配置

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.tipVM.dataArr.count;
    return count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == ShareTypeTip) {
        TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tip" forIndexPath:indexPath];
        cell.dataModel = self.tipVM.dataArr[indexPath.row];
        
        return cell;
    } else {
        ShowPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"show" forIndexPath:indexPath];
        cell.tlModel = self.tipVM.dataArr[indexPath.row];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == ShareTypePic) {
        return kWindowH/2;
    }
    return 110;
}


kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TipListDataModel *model = self.tipVM.dataArr[indexPath.row];
    
    WRTipDetailViewController *tipDetailVC = [[WRTipDetailViewController alloc] initWithGuideId:[NSString stringWithFormat:@"%ld",model.guide_id] type:_type];

    [self.navigationController pushViewController:tipDetailVC animated:YES];
}




@end
