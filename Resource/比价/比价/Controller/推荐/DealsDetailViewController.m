//
//  DealsDetailViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailViewController.h"
#import "DealsDetailView.h"
#import "DealsDetailViewModel.h"
#import "WRShopViewController.h"
#import "WRBuyButton.h"
#import "WRCommentViewController.h"


@interface DealsDetailViewController () <UIScrollViewDelegate,WRBuyButtonDelegate,CommentTableViewDelegate>

@property (nonatomic, strong) DealsDetailView *dealsDetailView;

@property (nonatomic, strong) DealsDetailViewModel *dealsDetailVM;

@property (nonatomic, strong) WRBuyButton *buy;

@property (nonatomic, strong) UIView *naviView;

@end

@implementation DealsDetailViewController

- (instancetype)initWithIdStr:(NSString *)idStr
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
        NSAssert1(NO, @"%s 请使用initWithType初始化", __FUNCTION__);
    }
    return self;
}


- (WRBuyButton *)buy {
    if(_buy == nil) {
        _buy = [[WRBuyButton alloc] init];
        _buy.title = @"买买买";
        _buy.delegate = self;
    }
    return _buy;
}
- (DealsDetailView *)dealsDetailView {
	if(_dealsDetailView == nil) {
		_dealsDetailView = [[DealsDetailView alloc] init];
        _dealsDetailView.scrollView.delegate = self;
        _dealsDetailView.hotCommentTV.delegate = self;
	}
	return _dealsDetailView;
}

- (DealsDetailViewModel *)dealsDetailVM {
    if(_dealsDetailVM == nil) {
        _dealsDetailVM = [[DealsDetailViewModel alloc] initWithIdStr:_idStr];
    }
    return _dealsDetailVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.dealsDetailView];
    [self.dealsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -64, 0));
    }];
    
    [self.view addSubview:self.buy];
    [_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.view.width, 38));
    }];
    
    [self showProgress];
    [self.dealsDetailVM getDataFromNetCompleteHandle:^(NSError *error) {

        [self hideProgress];

        self.dealsDetailView.dataModel = self.dealsDetailVM.detailDataModel;
    }];
    
    [self addMyNaviView];
    [WRNaviTool addBackItemAtPresentVC:self];
    
    [self.dealsDetailVM addObserver:self forKeyPath:@"priceInfoModel" options:NSKeyValueObservingOptionNew context:nil];
    
}
#define mark - 添加自定义导航视图
- (void)addMyNaviView
{
    _naviView = [UIView new];
    _naviView.backgroundColor = kNaviTitleColor;
    _naviView.alpha = 0;
    [self.view addSubview:_naviView];
    [_naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn bk_addEventHandler:^(id sender) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } forControlEvents:UIControlEventTouchUpInside];
//    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [_naviView addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-5);
//        make.left.mas_equalTo(10);
//        make.size.mas_equalTo(CGSizeMake(35, 35));
//    }];
    
}
/** 监听self.dealsDetailVM priceInfoModel属性 当有新值时，修改视图 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.dealsDetailView.priceInfoModel = self.dealsDetailVM.priceInfoModel;
}

//对象销毁时，移除监听者
- (void)dealloc
{
    [self.dealsDetailVM removeObserver:self forKeyPath:@"priceInfoModel"];
}

#pragma mark - WRBuyButtonDelegate
- (void)didClickedAtBuyBtn:(UIButton *)btn
{
    
    WRShopViewController *vc = [WRShopViewController new];
    DealsDetailDataModel *model = self.dealsDetailVM.detailDataModel;
    NSString *purURLStr = model.purchase_url;
    vc.URL = [NSURL URLWithString:purURLStr];
    vc.purchaseURL = [purURLStr stringByReplacingOccurrencesOfString:@"http://www.huihui.cn/proxy?purl=" withString:@""];
    
    [WRNaviTool addBackItemAtPresentVC:vc];
    
//    [self.navigationController pushViewController:vc animated:NO];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat x = offsetY / 100;
    if (x > 1) {
        x = 1;
    }
    _naviView.alpha = x;
}

#pragma mark - CommentTableViewDelegate 跳转到详细评论页面
- (void)didClickedAtMoreCommentBtn
{
    DealsDetailDataModel *model = self.dealsDetailVM.detailDataModel;
    WRCommentViewController *vc = [[WRCommentViewController alloc] initWithID:[NSString stringWithFormat:@"%ld",model.content_id]];
    
    vc.title = @"详细评论";
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
