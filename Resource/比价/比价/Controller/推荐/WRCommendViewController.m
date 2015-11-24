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

- (instancetype)init
{
    if (self = [super init]) {
        
        _categoryType = [WRTool defaultTool].type;
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
        _dealsVM = [[DealsViewModel alloc] initWithType:[WRTool defaultTool].type];
    }
    return _dealsVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftItem];
    self.title = @"推荐";
    //UIEdgeInsetsMake(0, 0, -64, 0)
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -64, 0));
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

#pragma mark - 添加LeftVC的Item
- (void)addLeftItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    NSString *imageName = [NSString stringWithFormat:@"%ld",[WRTool defaultTool].type];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn bk_addEventHandler:^(id sender) {
        [self.sideMenuViewController presentLeftMenuViewController];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftItem];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dealsVM.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.dataModel = self.dealsVM.dataArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealsDataModel *model = self.dealsVM.dataArr[indexPath.row];
    NSDateComponents *cmp = model.daysFromToday;
    
    return cmp.day == 0?110:145;
}

kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DealsDataModel *model = self.dealsVM.dataArr[indexPath.row];
    DealsDetailViewController *vc = [[DealsDetailViewController alloc] initWithIdStr:[NSString stringWithFormat:@"%ld",model.content_id]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [WRTabBarTool showTabBar:self];
}

@end
