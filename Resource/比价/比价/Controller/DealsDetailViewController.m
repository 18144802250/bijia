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



@interface DealsDetailViewController () <UIScrollViewDelegate>

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
        _dealsDetailView.bounces = NO;
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.dealsDetailView];
    
    [self.dealsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    [self.dealsDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        self.dealsDetailView.vm = self.dealsDetailVM;
    }];
    
    
    
    [self.dealsDetailVM addObserver:self forKeyPath:@"priceInfoModel" options:NSKeyValueObservingOptionNew context:nil];
    
}
/** 监听self.dealsDetailVM priceInfoModel属性 当有新值时，修改视图 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.dealsDetailView.pm = self.dealsDetailVM.priceInfoModel;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.dealsDetailVM removeObserver:self forKeyPath:@"priceInfoModel"];
}





@end
