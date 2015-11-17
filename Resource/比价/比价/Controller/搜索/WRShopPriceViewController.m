//
//  WRShopPriceViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/16.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRShopPriceViewController.h"
#import "SearchNetManager.h"
#import "SearchDetailModel.h"
#import "ItemsCell.h"

@interface WRShopPriceViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SearchDetailDataModel *resultModel;

@end

@implementation WRShopPriceViewController

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
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (SearchDetailDataModel *)resultModel {
    if(_resultModel == nil) {
        _resultModel = [[SearchDetailDataModel alloc] init];
    }
    return _resultModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [SearchNetManager getItemsPriceWithID:_idStr completionHandle:^(SearchDetailModel *model, NSError *error) {
        
        self.resultModel = model.data;
        [_tableView reloadData];
        
    }];
    
}

#pragma mark - tableView数据源配置

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //+1个Cell
    return self.resultModel.items.count>0?self.resultModel.items.count+1:0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HeadItemCell *cell = [HeadItemCell new];
        
        cell.dataModel = self.resultModel;
        
        return cell;
    }
    ItemsCell *cell = [ItemsCell new];
        
    cell.itemsModel = self.resultModel.items[indexPath.row-1];
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }
    return 44;
}

#pragma mark - tableViewDelegate 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}




@end
