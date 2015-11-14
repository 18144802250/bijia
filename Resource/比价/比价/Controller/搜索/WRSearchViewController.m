//
//  WRSearchViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRSearchViewController.h"
#import "WRSearchBar.h"
#import "ShopViewModel.h"
#import "WRShopListView.h"
#import "WRShopViewController.h"
#import "SearchViewModel.h"

@interface WRSearchViewController () <UITableViewDataSource,UITableViewDelegate,WRShopListViewDelegate>

@property (nonatomic, strong) WRSearchBar *searchBar;

@property (nonatomic, strong) ShopViewModel *shopVM;
@property (nonatomic, strong) SearchViewModel *searchVM;

@property (nonatomic, strong) UITableView *tableView;
/** 历史记录数组 */
@property (nonatomic, strong) NSMutableArray *historyArr;
/** 搜索数组 */
@property (nonatomic, strong) NSArray *searchArr;

@end

static WRSearchViewController *searchVC = nil;

@implementation WRSearchViewController

- (NSArray *)searchArr {
    if(_searchArr == nil) {
        _searchArr = [[NSArray alloc] init];
    }
    return _searchArr;
}

- (WRSearchBar *)searchBar {
    if(_searchBar == nil) {
        WRSearchBar *searchBar = [[WRSearchBar alloc] initWithFrame:CGRectMake(0, 0, kWindowW - 80, 35)];
        
        searchBar.placeholder = @"搜一搜，比一比";
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor grayColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        _tableView.tableFooterView = [UIView new];

    }
    return _tableView;
}

- (SearchViewModel *)searchVM {
    if(_searchVM == nil) {
        _searchVM = [[SearchViewModel alloc] init];
    }
    return _searchVM;
}
- (ShopViewModel *)shopVM {
    if(_shopVM == nil) {
        _shopVM = [[ShopViewModel alloc] init];
        
    }
    return _shopVM;
}

- (NSMutableArray *)historyArr {
    if(_historyArr == nil) {
        _historyArr = [[NSMutableArray alloc] init];
    }
    return _historyArr;
}

#pragma mark - 设计单例模式，免得重复加载数据
+ (WRSearchViewController *)standerSearchVC
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        searchVC = [WRSearchViewController new];
        
    });
    return searchVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加返回item
    [WRNaviTool addBackItemAtVC:self];
    
    //添加搜索框
    [self addSearchBar];
    
    
    //添加列表
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    //添加商城
    [self.shopVM getDataFromNetCompleteHandle:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    
    
}

#pragma mark -添加搜索框
- (void)addSearchBar
{

    self.navigationItem.titleView = self.searchBar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

#pragma mark - textChange 当搜索栏的值发生改变时
/** 当搜索框的值发生改变时 发请求*/
- (void)textChange:(NSNotification*)noti
{
    self.searchVM.textStr = _searchBar.text;
    [self.searchVM getDataFromNetCompleteHandle:^(NSError *error) {
        NSLog(@"...");
    }];
}


#pragma mark - view加载完成 searchBar获得键盘相应
- (void)viewDidAppear:(BOOL)animated
{
    [_searchBar becomeFirstResponder];
}


#pragma mark - tableView数据源和代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
        
    } else {
        return self.historyArr.count;
    }
}
#pragma mark - 标题
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"商城入口";
    } else {
        return @"历史记录";
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        WRShopListView *list = [WRShopListView new];
        list.delegate = self;
        list.shopModel = self.shopVM;
        [cell.contentView addSubview:list];
        
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    } else {
        cell.textLabel.text = self.historyArr[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat h = (kWindowW - 30)/2 + 10;
        return h;
    } else {
        return 44;
    }
}

#pragma mark - 点击商城列表按钮 转到商城详情页
- (void)didClickedAtBtnTag:(NSInteger)index
{
    WRShopViewController *vc = [WRShopViewController new];
    ShopDataModel *model = self.shopVM.dataArr[index];
    vc.URL = model.url;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}



@end
