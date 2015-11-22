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

@interface WRProfileViewController () <ProfileHeaderViewDelegate,ProfileSettingViewDelegate,WRCoverDelegate,BmobEventDelegate>

@property (nonatomic, strong) ProfileView *profileView;

@property (nonatomic, strong) ProfileSettingView *settingView;
/** 监听数据库的变化 */
@property (nonatomic, strong) BmobEvent *bmobEvent;

@end

@implementation WRProfileViewController

- (ProfileView *)profileView {
    if(_profileView == nil) {
        _profileView = [[ProfileView alloc] init];
        _profileView.headView.delegate = self;
    }
    return _profileView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self listen];
    
    [self addUserMessageView];
}

#pragma mark - 添加设置
- (void)addSettingItemAtNavi
{


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

#pragma mark - 添加用户信息页 判断用户是否登陆
- (void)addUserMessageView
{
    [self.view addSubview:self.profileView];
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        //如果用户存在，先判断是否有呢名，如果没有设置用户名
        NSString *name = [WRBmobTool nickNameFromCurrentUser];
        if (name.length > 1) {
            _profileView.headView.profileUserName = name;
        } else {
            _profileView.headView.profileUserName = [WRBmobTool userNameFormCurrentUser];;
        }
        
    }else{
        
    }
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


@end
