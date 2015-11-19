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

#import "WRShopViewController.h"

#import "ShopPriceHeaderView.h"
#import "ShopPriceListView.h"

@interface WRShopPriceViewController () <ShopPriceListViewDelegate>

@property (nonatomic, strong) ShopPriceHeaderView *headerView;
@property (nonatomic, strong) ShopPriceListView *listView;

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

- (ShopPriceHeaderView *)headerView {
    if(_headerView == nil) {
        _headerView = [[ShopPriceHeaderView alloc] init];
    }
    return _headerView;
}

- (ShopPriceListView *)listView {
    if(_listView == nil) {
        _listView = [[ShopPriceListView alloc] init];
        _listView.delegate = self;
    }
    return _listView;
}

- (SearchDetailDataModel *)resultModel {
    if(_resultModel == nil) {
        _resultModel = [[SearchDetailDataModel alloc] init];
    }
    return _resultModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加视图
    [self addSubView];
    
    [SearchNetManager getItemsPriceWithID:_idStr completionHandle:^(SearchDetailModel *model, NSError *error) {
        
        self.resultModel = model.data;
        
    
        _headerView.dataModel = model.data;
        
        
        _listView.sdModel = model.data;
    }];
    
}

#pragma mark - 添加头和list视图
- (void)addSubView
{
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerView.mas_bottom).mas_equalTo(0);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - ShopPriceListViewDelegate

- (void)didClickAtCellIndex:(NSInteger)index
{
    WRShopViewController *vc = [WRShopViewController new];
    
    SearchDetailDataItemsModel *itemModel = _resultModel.items[index];
    NSString *purUrlStr = itemModel.purchase_url;
    vc.URL = [NSURL URLWithString:purUrlStr];
    vc.purchaseURL = [purUrlStr stringByReplacingOccurrencesOfString:@"/proxy?purl=" withString:@""];
    vc.sdDataModel = _resultModel;
    vc.title = itemModel.site_name;
    [self.navigationController pushViewController:vc animated:YES];
}





@end
