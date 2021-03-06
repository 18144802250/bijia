//
//  WRCompareView.m
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRCompareView.h"
#import "PriceView.h"
#import "ShopPriceListView.h"

#import "SearchDetailModel.h"

@interface WRCompareView ()

@property (nonatomic, strong) UILabel *headTitle;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, assign) CGFloat contentH;

@end

@implementation WRCompareView

#pragma mark -把view添加到window上
+ (instancetype)showInRect:(CGRect)frame
{
    WRCompareView *compareView = [[WRCompareView alloc] initWithFrame:frame];
    
    [Keywindow addSubview:compareView];
    
    return compareView;
}

#pragma mark - hide 移除view
+ (void)hide
{
    for (UIView *view in Keywindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}

- (UIScrollView *)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //添加头视图  需要数据 DealsPriceInfoDataModel 的 价格局势描述
        UILabel *headTitle = [UILabel new];
        headTitle.numberOfLines = 2;
        headTitle.backgroundColor = kNaviTitleColor;
        headTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:headTitle];
        [headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(80);
        }];

        _headTitle = headTitle;
#pragma mark - collectButton
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_collectBtn bk_addEventHandler:^(id sender) {
            if ([_delegate respondsToSelector:@selector(didClickAtCollectBtnAtWRCompareView)]) {
                [_delegate didClickAtCollectBtnAtWRCompareView];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        _collectBtn.backgroundColor = kNaviTitleColor;
        [self addSubview:_collectBtn];
        [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(35);
        }];
#pragma mark - scrollView 
        [self addSubview:self.scrollView];
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headTitle.mas_bottom).mas_equalTo(3);
            make.bottom.mas_equalTo(_collectBtn.mas_top).mas_equalTo(-3);
            make.left.right.mas_equalTo(0);
        }];

    }
    return self;
}

- (void)setPiDataModel:(DealsPriceInfoDataModel *)piDataModel
{
    _piDataModel = piDataModel;
    
    //添加价格走势图 PriceView 需要数据 DealsPriceInfoDataModel 的 items
    PriceView *priceView = [[PriceView alloc] initWithDateModel:piDataModel rect:CGRectMake(0, 0, self.width, self.width/1.8)];
    [_scrollView addSubview:priceView];
    
    _headTitle.text = piDataModel.title;
}

- (void)setSdDataModel:(SearchDetailDataModel *)sdDataModel
{
    _sdDataModel = sdDataModel;
    
    
    NSUInteger count = sdDataModel.items.count - 1;
    CGFloat tableH = count*44;
    
    if (count == 0) {
        return;
    }
    //添加商家比价图 ShopPriceListView 需要数据 SearchDetailDataModel 的items
    ShopPriceListView *spListView = [ShopPriceListView viewInRect:CGRectMake(0, self.width/1.8, self.width, tableH)];
    spListView.isCompareView = YES;
    spListView.backgroundColor = [UIColor purpleColor];
    [_scrollView addSubview:spListView];
    

    //设置listView时 把scrollView的contentSize设置
    _contentH = self.width/1.8+tableH;
    spListView.siteName = _siteName;
    _scrollView.contentSize = CGSizeMake(0, _contentH);
    
    spListView.sdModel = sdDataModel;
    
    _spListView = spListView;
}

@end
