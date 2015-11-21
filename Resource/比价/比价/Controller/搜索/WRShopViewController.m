//
//  WRShopViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRShopViewController.h"

#import "DealsPriceInfoModel.h"
#import "SearchDetailModel.h"
#import "DealsNetManager.h"

#import "WRCover.h"
#import "WRToolBar.h"
#import "WRCompareView.h"
#import "ShopPriceListView.h"

@interface WRShopViewController () <UIWebViewDelegate,WRToolBarDelegate,WRCoverDelegate,ShopPriceListViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WRToolBar *toolBar;

@property (nonatomic, strong) DealsPriceInfoDataModel *piDataModel;

@end

@implementation WRShopViewController

- (WRToolBar *)toolBar {
    if(_toolBar == nil) {
        _toolBar = [[WRToolBar alloc] init];
        _toolBar.delegate = self;
    }
    return _toolBar;
}

- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
#pragma mark - 请求价格波动图的数据 如果没有传sdDataModel过来则不需要请求
    if (_sdDataModel || _purchaseURL.length>4) {
        [DealsNetManager getDealsDataPriceWithPurchaseURL:_purchaseURL completionHandle:^(DealsPriceInfoModel *model, NSError *error) {
            
            _piDataModel = model.data;
            
            
            [self.view addSubview:self.toolBar];
            [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(0);
                make.height.mas_equalTo(35);
            }];
            
//            NSString *price = _piDataModel.price_trend_desc;
//            PriceWaveType type;
            
//            if ([price isEqualToString:@"价格上涨"]) {
//                type = PriceWaveTypeUp;
//            } else if ([price isEqualToString: @"价格平稳"]) {
//                type = PriceWaveTypeClam;
//            } else {
//                type = PriceWaveTypeDown;
//            }
            self.toolBar.type = [self countWithPriceHistoryArr:_piDataModel.price_history];
            self.toolBar.shopNum = _sdDataModel.items.count;
        }];
    }
    
    [_webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
}

#pragma mark - 根据时间价格数组计算价格波动
- (PriceWaveType)countWithPriceHistoryArr:(NSArray*)arr
{
    DealsPriceHistoryModel *phModel = arr.lastObject;
    CGFloat lastPrice = phModel.price.floatValue;
    NSUInteger count = arr.count;
    CGFloat hPrice = lastPrice;
    CGFloat lPrice = lastPrice;
    for (int i = 0; i < count; i++) {
        DealsPriceHistoryModel *model = arr[i];
        CGFloat currentPrice = model.price.floatValue;
        if (hPrice < currentPrice) {
            hPrice = currentPrice;
        }
        if (lPrice > currentPrice) {
            lPrice = currentPrice;
        }
    }
    if (hPrice > lPrice) {
        
        if (lastPrice == lPrice) {
            return PriceWaveTypeDown;
        } else {
            return PriceWaveTypeUp;
        }
        
    } else {
        return PriceWaveTypeClam;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideProgress];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideProgress];
}
#pragma mark - viewDisAppear 页面消失时把加载框停掉
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self hideProgress];
}


#pragma mark - WRToolBarDelegate 当点击工具栏  先弹出蒙版 再弹出比价页面
- (void)didClickedAtBtn
{
    WRCover *cover = [WRCover show];
    cover.delegate = self;
    
    CGFloat w = kWindowW - 2*10;
    CGFloat h = kWindowH - 2*100;
    WRCompareView *compareView = [WRCompareView showInRect:CGRectMake(10, 100, w, h)];

    compareView.siteName = _siteName;
    
    compareView.piDataModel = _piDataModel;
    
    compareView.sdDataModel = _sdDataModel;
    
    compareView.spListView.delegate = self;
}

#pragma mark - WRCoverDelegate 点击蒙版
- (void)didClickedAtCoverView
{
    [WRCompareView hide];
}

#pragma mark - ShopPriceListViewDelegate
- (void)didClickAtCellWithItemModel:(SearchDetailDataItemsModel *)itemModel
{
    NSString *purUrlStr = itemModel.purchase_url;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:purUrlStr]]];
    self.title = itemModel.site_name;
    [WRCompareView hide];
}

@end
