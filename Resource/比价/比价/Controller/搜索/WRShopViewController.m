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
#import "SearchResultModel.h"
#import "DealsNetManager.h"

#import "WRCover.h"
#import "WRToolBar.h"
#import "WRCompareView.h"
#import "ShopPriceListView.h"

#import "WRLoginViewController.h"

#define kURL @"url"
#define kGoodName @"goodName"
#define kGoodPrice @"goodPrice"
#define kPicURL @"picURL"
#define kSource @"source"

@interface WRShopViewController () <UIWebViewDelegate,WRToolBarDelegate,WRCoverDelegate,ShopPriceListViewDelegate,WRCompareViewDelegate>

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
    
#pragma mark - 请求价格波动图的数据 如果没有传sdDataModel和purchaseURL过来 则不需要请求
    if (_sdDataModel || _purchaseURL.length>4) {
        [DealsNetManager getDealsDataPriceWithPurchaseURL:_purchaseURL completionHandle:^(DealsPriceInfoModel *model, NSError *error) {
            
            if ([model.status isEqualToString:@"fail"]) {
                return;
            }
            _piDataModel = model.data;
            
            [self.view addSubview:self.toolBar];
            [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(0);
                make.height.mas_equalTo(35);
            }];
            
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
    compareView.delegate = self;
    compareView.siteName = _siteName;
    compareView.piDataModel = _piDataModel;
    
    if (_sdDataModel) {
        compareView.sdDataModel = _sdDataModel;
    }
    
    compareView.spListView.delegate = self;
}

#pragma mark - 点击收藏
- (void)didClickedAtCollectBtn
{
    [self isCollected];
}

#pragma mark - 收藏功能
- (void)collect
{
    
    UIAlertController *alert = nil;
    if ([BmobUser getCurrentUser]) {
        
        alert = [UIAlertController alertControllerWithTitle:@"添加收藏" message:@"确认收藏？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的～" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            BmobObject  *collect = [BmobObject objectWithClassName:WRTableCollectName];
            //用户ID
            [collect setObject:[BmobUser getCurrentUser].objectId forKey:WRTableCollectUserId];
            //商品名字
            NSString *title = _sdDataModel?_sdDataModel.title:_inlandModel.title;
            [collect setObject:title forKey:kGoodName];
            //商品价格
            NSString *price = _itemModel?_itemModel.price:_inlandModel.price;
            [collect setObject:price forKey:kGoodPrice];
            //图片url
            NSString *sdImageURL = [NSString stringWithFormat:@"%@",_sdDataModel.image_url];
            NSString *imageURLStr = _sdDataModel?sdImageURL:_inlandModel.image_url;
            [collect setObject:imageURLStr forKey:kPicURL];
            //商家
            [collect setObject:_siteName forKey:kSource];
            //跳转url
            [collect setObject:[NSString stringWithFormat:@"%@",_URL] forKey:kURL];
            //异步保存
            [collect saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //创建成功后会返回objectId，updatedAt，createdAt等信息
                    //打印objectId
                    [self showSuccessMsg:@"收藏成功"];
                    
                } else if (error){
                    //发生错误后的动作
                    NSLog(@"%@",error);
                } else {
                    NSLog(@"Unknow error");
                }
            }];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"才不～" style:UIAlertActionStyleCancel handler:nil]];
    } else {
        alert = [UIAlertController alertControllerWithTitle:@"登陆收藏" message:@"登陆后添加收藏功能哦~" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的～" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            WRLoginViewController *loginVC = [WRLoginViewController new];
            [self.navigationController pushViewController:loginVC animated:YES];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"才不～" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 判断是否收藏过 避免重复收藏
- (void)isCollected
{
    //查询该用户已经添加的收藏
    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
    NSString *bql = @"select * from Collect where userID = ? and url = ?";
    NSArray *placeholderArray = @[[BmobUser getCurrentUser].objectId,[NSString stringWithFormat:@"%@",_URL]];
    
    [bmobQuery queryInBackgroundWithBQL:bql pvalues:placeholderArray block:^(BQLQueryResult *result, NSError *error) {
        if (error) {

        } else {
            if (result.resultsAry.count) {
                [self showErrorMsg:@"该商品已经静静地躺在收藏夹了～"];
            } else {
                [self collect];
            }
        }
    }];
}

#pragma mark - WRCoverDelegate 点击蒙版
- (void)didClickedAtCoverView
{
    [WRCompareView hide];
}

#pragma mark - ShopPriceListViewDelegate
- (void)didClickAtCellWithItemModel:(SearchDetailDataItemsModel *)itemModel
{
    WRShopViewController *vc = [WRShopViewController new];
    NSString *purUrlStr = itemModel.purchase_url;
    vc.itemModel = itemModel;
    vc.URL = [NSURL URLWithString:purUrlStr];
    vc.purchaseURL = [purUrlStr stringByReplacingOccurrencesOfString:@"/proxy?purl=" withString:@""];
    vc.siteName = itemModel.site_name;
    vc.sdDataModel = _sdDataModel;
    vc.title = itemModel.site_name;
    [self.navigationController pushViewController:vc animated:YES];

    [WRCover hide];
    [WRCompareView hide];
}

#pragma mark -WRCompareViewDelegate 点击收藏
- (void)didClickAtCollectBtnAtWRCompareView
{
    [WRCover hide];
    [WRCompareView hide];
    
    [self isCollected];
}

@end
