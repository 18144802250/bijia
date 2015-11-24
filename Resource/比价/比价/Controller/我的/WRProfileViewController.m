//
//  WRProfileViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRProfileViewController.h"
#import "ProfileView.h"
#import "WRLoginViewController.h"
#import "ProfileSettingView.h"
#import "WRCover.h"
#import "WRSettingViewController.h"
#import "ProfileCollectModel.h"
#import "WRShopViewController.h"

@interface WRProfileViewController () <ProfileHeaderViewDelegate,ProfileSettingViewDelegate,WRCoverDelegate,BmobEventDelegate,ProfileCollectViewDelegate>

@property (nonatomic, strong) ProfileView *profileView;

@property (nonatomic, strong) ProfileSettingView *settingView;
/** 监听数据库的变化 */
@property (nonatomic, strong) BmobEvent *bmobEvent;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation WRProfileViewController

- (ProfileView *)profileView {
    if(_profileView == nil) {
        _profileView = [[ProfileView alloc] init];
        _profileView.headView.delegate = self;
        _profileView.collectView.delegate = self;
    }
    return _profileView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSettingItemAtNavi];
    
    [self listen];
    
    [self addUserMessageView];
    
}



#pragma mark - 添加设置
- (void)addSettingItemAtNavi
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageWithOriginName:@"setting"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"setting_enable"] forState:UIControlStateDisabled];

    btn.frame = CGRectMake(0, 0, 35, 35);
#pragma mark - 点击设置 跳转设置VC
    [btn bk_addEventHandler:^(id sender) {
        
        WRSettingViewController *settingVC = [WRSettingViewController new];
        
        [self.navigationController pushViewController:settingVC animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _rightItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    rightItem.enabled = NO;
}
#pragma mark - 监听数据
- (void)listen
{
    _bmobEvent = [BmobEvent defaultBmobEvent];
    
    _bmobEvent.delegate = self;
    
    [_bmobEvent start];
}

#pragma mark - BmobEventDelegate 监听呢名的更改
- (void)bmobEventCanStartListen:(BmobEvent *)event
{
    [_bmobEvent listenRowChange:BmobActionTypeUpdateRow tableName:@"User" objectId:@"nickName"];
}
- (void)bmobEvent:(BmobEvent *)event didReceiveMessage:(NSString *)message
{
    NSLog(@"message = %@",message);
}

#pragma mark - 添加用户信息页
- (void)addUserMessageView
{
    [self.view addSubview:self.profileView];
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - 当页面显示时，刷新用户信息
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self userLogin];
}

#pragma mark - 判断用户是否登陆 登出是调用 开始时调用 设置呢名时调用 登陆，注册，第三方登陆成功时调用
- (void)userLogin
{
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        _rightItem.enabled = YES;
        //如果用户存在，先判断是否有呢名，如果没有设置用户名
        NSString *name = [WRBmobTool nickNameFromCurrentUser];
        if (name.length > 1) {
            _profileView.headView.profileUserName = name;
        } else {
            _profileView.headView.profileUserName = [WRBmobTool userNameFormCurrentUser];;
        }
        
        [self refreshCollectView];
        
    }else{
        _rightItem.enabled = NO;
        
        _profileView.headView.profileUserName = nil;
    }
}

#pragma mark - 刷新收藏栏
- (void)refreshCollectView
{
    //刷新收藏列表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Collect"];
    //查找Collect表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        ProfileCollectModel *model = [ProfileCollectModel mj_objectWithKeyValues:[self transformWithArr:array]];
        //当有数据时刷新列表
        if (model.data.count > 0) {
            
            _profileView.collectView.collectArr = model.data;
        }
    }];
}

#pragma mark - 转换成MJ解析的数据
- (NSDictionary*)transformWithArr:(NSArray*)arr
{
    return [NSDictionary dictionaryWithObject:arr forKey:@"data"];
}

#pragma mark - ProfileHeaderViewDelegate

- (void)didClickedAtLoginBtn:(UIButton *)btn
{
    WRLoginViewController *vc = [WRLoginViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didClickedAtSetNickNameBtn:(UIButton *)btn
{
    WRCover *cover = [WRCover show];
    cover.delegate = self;
    
    CGFloat svW = self.view.width - 30;
    CGFloat svH = self.view.height - 200;
    ProfileSettingView *settingView = [ProfileSettingView showInrect:CGRectMake(15, 100, svW, svH)];
    settingView.delegate = self;
    
    _settingView = settingView;
}

#pragma mark - ProfileSettingViewDelegate 点击确认 修改呢名

- (void)didClickedAtConfirmBtn:(UIButton *)btn nickName:(NSString *)nickName
{
    [WRCover hide];
    
    [ProfileSettingView hide];
    
    [WRBmobTool setCurrenUserWithNewNickName:nickName result:^(BOOL isSuccess) {
        if (isSuccess) {
            [self showSuccessMsg:@"修改成功"];
            //修改呢名时调用
            [self userLogin];
        } else {
            [self showErrorMsg:@"修改失败"];
        }
    }];
}

#pragma mark - WRCoverDelegate 点击蒙版 设置页面消失
- (void)didClickedAtCoverView
{
    [ProfileSettingView hide];
}

#pragma mark - ProfileCollectViewDelegate
- (void)didClickAtCollectViewCellWithIndex:(NSUInteger)index url:(NSURL *)url title:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"去购买页面吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"买买买！" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        WRShopViewController *shopVC = [WRShopViewController new];
        shopVC.URL = url;
        shopVC.title = title;
        
        [self.navigationController pushViewController:shopVC animated:YES];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不小心手抖～" style:1 handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)longPressAtCollectViewCellWithIndex:(NSUInteger)index objectId:(NSString *)objectId
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"确认删除这条收藏吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"狠心删除" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        BmobObject *bmobObject = [BmobObject objectWithoutDatatWithClassName:WRTableCollectName  objectId:objectId];
        [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //删除成功后的动作
                [self showSuccessMsg:@"删除成功"];
                
                [self refreshCollectView];
            } else if (error){
                [self showErrorMsg:error];
            } else {
                [self showErrorMsg:@"UnKnow error"];
            }
        }];
        
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不小心手抖～" style:1 handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
