//
//  WRLeftViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRLeftViewController.h"
#import "WRCompareViewController.h"

@interface WRLeftViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *itemsName;

@property (nonatomic, strong) NSArray *contros;

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
            WRCompareViewController *vc = [[WRCompareViewController alloc] initWithType:i];
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.tableFooterView = [UIView new];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text = self.itemsName[indexPath.row];
    
    return cell;
}

kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.sideMenuViewController setContentViewController:self.contros[indexPath.row] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}



@end
