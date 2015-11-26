//
//  WRSettingViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRSettingViewController.h"
#import "SettingView.h"


@interface WRSettingViewController () <WRBuyButtonDelegate,SettingViewDelegate>

@property (nonatomic, strong) SettingView *settingView;

@end

@implementation WRSettingViewController

- (SettingView *)settingView {
    if(_settingView == nil) {
        _settingView = [[SettingView alloc] init];
        _settingView.loginOutBtn.delegate = self;
        _settingView.delegate = self;
    }
    return _settingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSettingView];
}

#pragma mark - 添加设置页面
- (void)addSettingView
{
    [self.view addSubview:self.settingView];
    [_settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - WRBuyButtonDelegate 退出登陆
- (void)didClickedAtBuyBtn:(UIButton *)btn
{
    [BmobUser logout];
    if ([BmobUser getCurrentUser]) {
        [self showErrorMsg:@"登出失败"];
    } else {
        [self showSuccessMsg:@"已登出"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - SettingViewDelegate 
- (void)didClickAtTableViewCellWithRow:(NSUInteger)row
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认清空收藏夹吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"狠心清空！" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        //先查询出所有要删除的对象
        BmobQuery   *bquery = [BmobQuery queryWithClassName:WRTableCollectName];
        [bquery whereKey:WRTableCollectUserId equalTo:[BmobUser getCurrentUser].objectId];
        //查找Collect表的数据
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            
            NSUInteger count = array.count;
            if (count == 0) {
                [self showErrorMsg:@"没有可删除的数据"];
                return;
            }
            for (int i = 0; i < count; i++) {
                BmobObject *bmobObject = array[i];
                [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        //删除成功后的动作
                        if (i == count-1) {
                            [self showSuccessMsg:@"清空成功"];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    } else if (error){
                        [self showErrorMsg:error];
                    } else {
                        [self showErrorMsg:@"删除错误"];
                    }
                }];
            }
            
        }];
        
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不小心手抖～" style:1 handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
