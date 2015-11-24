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
#import "SearchModel.h"
#import "WRSearchResultViewController.h"
#import "WRShopPriceViewController.h"
#import "WRHistoryTool.h"

@interface WRSearchViewController () <UITableViewDataSource,UITableViewDelegate,WRShopListViewDelegate,WRSearchResultViewControllerDelegate>

@property (nonatomic, strong) WRSearchBar *searchBar;

@property (nonatomic, strong) ShopViewModel *shopVM;
@property (nonatomic, strong) SearchViewModel *searchVM;
@property (nonatomic, strong) WRShopListView *list;

@property (nonatomic, strong) UITableView *tableView;
/** 历史记录数组 */
@property (nonatomic, strong) NSMutableArray *historyArr;
/** 搜索数组 包含有历史记录*/
@property (nonatomic, strong) NSArray *searchArr;

@property (nonatomic, strong) WRSearchResultViewController *srVC;

@end

static WRSearchViewController *searchVC = nil;

@implementation WRSearchViewController

- (WRSearchBar *)searchBar {
    if(_searchBar == nil) {
        WRSearchBar *searchBar = [[WRSearchBar alloc] initWithFrame:CGRectMake(0, 0, kWindowW - 80, 35)];
        
        searchBar.placeholder = @"搜一搜，比一比";
#pragma mark - 当点击键盘右下角搜索时 添加历史记录
        [searchBar bk_addEventHandler:^(id sender) {
            //添加返回按钮
            [self addBackItem];
            WRSearchResultViewController *srVC = [[WRSearchResultViewController alloc] initWithQuest:_searchBar.text];
            srVC.delegate = self;
            
            [self.view addSubview:srVC.view];
            [srVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                //UIEdgeInsetsMake(0, 0, 0, 0)
                make.edges.mas_equalTo(0);
            }];
            _srVC = srVC;
            //添加历史记录 并归档
            for (NSString *str in self.historyArr) {
                if (_searchBar.text == str) {
                    return;
                }
            }
            [self.historyArr addObject:_searchBar.text];
            [WRHistoryTool saveHistory:self.historyArr];

        } forControlEvents:UIControlEventEditingDidEndOnExit];
        _searchBar = searchBar;
        _searchBar.returnKeyType = UIReturnKeySearch;
    }
    return _searchBar;
}

- (WRShopListView *)list {
    if(_list == nil) {
        _list = [[WRShopListView alloc] init];

        _list.delegate = self;
    }
    return _list;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor grayColor];

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
#pragma mark - 获取本地历史记录
- (NSMutableArray *)historyArr {
    if(_historyArr == nil) {
        _historyArr = [[WRHistoryTool history].historyArr mutableCopy];
    }
    return _historyArr;
}

- (NSArray *)searchArr {
    if(_searchArr == nil) {
        _searchArr = [[NSArray alloc] init];
    }
    return _searchArr;
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
        //先显示商城，再请求搜索链接
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }];
    //添加键盘弹起时 返回原界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardGetUp:) name:UIKeyboardWillShowNotification object:nil];
    
}

#pragma mark -添加搜索框
- (void)addSearchBar
{
    self.navigationItem.titleView = self.searchBar;
}

#pragma mark - textChange 当搜索栏的值发生改变时
/** 当搜索框的值发生改变时 发请求*/
- (void)textChange:(NSNotification*)noti
{
    self.searchVM.textStr = _searchBar.text;
    [self.searchVM getDataFromNetCompleteHandle:^(NSError *error) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:self.historyArr];
#pragma mark 把搜索请求回来的数据添加到搜索结果数组
        for (SearchHuigoodsDataModel *strModel in self.searchVM.dataArr) {
            [arr addObject:strModel.value];
        }
        self.searchArr = [arr copy];
        [self.tableView reloadData];
    }];
}

#pragma mark 当搜索详情页出来时，需要添加返回按钮
- (void)addBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn bk_addEventHandler:^(id sender) {
#pragma mark - 点击返回按钮 搜索详情页取消
        [_srVC.view removeFromSuperview];
        
        [btn removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftItem];
}

#pragma mark - view加载完成 searchBar获得键盘相应
- (void)viewDidAppear:(BOOL)animated
{
    [_searchBar becomeFirstResponder];
    [_tableView reloadData];
}


#pragma mark - tableView数据源和代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return 1;
        
    } else if (self.searchArr.count) {
        return self.searchArr.count;
    } else {
        return self.historyArr.count;
    }
}
#pragma mark - 标题
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"商城入口";
    } else if (section == 1){
        return @"历史记录";
    } else {
        return nil;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
            [cell.contentView addSubview:self.list];
            _list.tag = 100;
            [self.list mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        }
        WRShopListView *listView = (WRShopListView*)[cell.contentView viewWithTag:100];
        listView.shopModel = self.shopVM;
        
        return cell;
    } else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];

        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell2"];
        }
        if (self.searchArr.count) {
            cell.textLabel.text = self.searchArr[indexPath.row];
        } else {
            cell.textLabel.text = self.historyArr[indexPath.row];
        }
        return cell;
    } else {
        UITableViewCell * cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor grayColor];
        
#pragma mark -清空历史记录
        cell.textLabel.text = @"清空历史记录";
        
        return cell;
    }
}

#pragma mark - 点击历史记录Cell时 跳转到新SearchResultView 把键盘隐藏 把点击的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        [self.historyArr removeAllObjects];
        [WRHistoryTool saveHistory:self.historyArr];
        if (self.historyArr.count == 0) {
            [self showSuccessMsg:@"清空成功"];
        }
        [self.tableView reloadData];
        return;
    }
    
    //添加返回按钮
    [self addBackItem];
    //点击对应的字符串
    NSString *clickStr = nil;
    if (self.searchArr.count) {
        clickStr = self.searchArr[indexPath.row];
    } else {
        clickStr = self.historyArr[indexPath.row];
    }
    
    WRSearchResultViewController *srVC = [[WRSearchResultViewController alloc] initWithQuest:clickStr];
    
    srVC.delegate = self;
    
    [self.view addSubview:srVC.view];
    [srVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _srVC = srVC;
    _searchBar.text = clickStr;
    [_searchBar resignFirstResponder];
    
    //添加历史记录 如果不重复 并归档
    for (NSString *str in self.historyArr) {
        if (clickStr == str) {
            return;
        }
    }
    [self.historyArr addObject:clickStr];
    [WRHistoryTool saveHistory:self.historyArr];
}

#pragma mark - 返回tableCell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat h = (kWindowW - 30)/2 + 10;
        return h;
    } else {
        return 44;
    }
}

#pragma mark - scrollViewDelegate 当拽动tableView时 键盘隐藏
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];

}


#pragma mark - 点击商城列表按钮 转到商城详情页 添加历史记录
- (void)didClickedAtBtnTag:(NSInteger)index
{
    WRShopViewController *vc = [WRShopViewController new];
    ShopDataModel *model = self.shopVM.dataArr[index];
    vc.URL = model.url;
    vc.title = model.name;
    
    [self.historyArr addObject:model.name];
    
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - 当页面将要消失时 把键盘隐藏 把监听者去掉 把搜索栏清除 把搜索数组清除 把搜索结果页面remove
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
    
    _searchBar.text = @"";  
    
    self.searchArr = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}



#pragma mark - 监听当键盘弹起时 把搜索结果页面remove
- (void)keyboardGetUp:(NSNotification*)noti
{
    [_srVC.view removeFromSuperview];
}

#pragma mark - WRSearchResultViewControllerDelegate 点击Cell 跳转详细页面
- (void)didClickedAtCellWithID:(NSString *)idStr
{
    WRShopPriceViewController *spVC = [[WRShopPriceViewController alloc] initWithID:idStr];
    spVC.title = @"商家比价";
    
    [self.navigationController pushViewController:spVC animated:YES];
}

@end
