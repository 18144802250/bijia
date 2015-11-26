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
#import "WRBuyButton.h"
#import "WRShopViewController.h"



@interface DealsDetailViewController () <UIScrollViewDelegate,WRBuyButtonDelegate>

@property (nonatomic, strong) DealsDetailView *dealsDetailView;

@property (nonatomic, strong) DealsDetailViewModel *dealsDetailVM;

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

- (DealsDetailView *)dealsDetailView {
	if(_dealsDetailView == nil) {
		_dealsDetailView = [[DealsDetailView alloc] init];
        _dealsDetailView.buy.delegate = self;
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
    //隐藏TabBar
    [WRTabBarTool hideTabBar:self];
    
    [self.view addSubview:self.dealsDetailView];
    [self.dealsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -64, 0));
    }];
    
    [self showProgress];
    [self.dealsDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
        [self hideProgress];
        
        self.dealsDetailView.dataModel = self.dealsDetailVM.detailDataModel;
    }];
    
    [self.dealsDetailVM addObserver:self forKeyPath:@"priceInfoModel" options:NSKeyValueObservingOptionNew context:nil];
    
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
    vc.purchaseURL = [purURLStr stringByReplacingOccurrencesOfString:@"/proxy?purl=" withString:@""];
    
    [self.navigationController pushViewController:vc animated:NO];
}


@end
