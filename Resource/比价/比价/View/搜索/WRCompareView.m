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

@property (nonatomic, strong) ShopPriceListView *spListView;

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
        
        self.backgroundColor = [UIColor greenColor];
        
        //添加头视图  需要数据 DealsPriceInfoDataModel 的 价格局势描述
        UILabel *headTitle = [UILabel new];
        headTitle.numberOfLines = 2;
//        headTitle.textColor = [UIColor whiteColor];
        headTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:headTitle];
        [headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(80);
        }];

        _headTitle = headTitle;
#pragma mark - collectButton
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"] forState:UIControlStateNormal];
        _collectBtn.backgroundColor= [UIColor blackColor];
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
        
        _contentH = 120;
        //添加商家比价图 ShopPriceListView 需要数据 SearchDetailDataModel 的items
        ShopPriceListView *spListView = [ShopPriceListView new];
        
        [_scrollView addSubview:spListView];
        [spListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(120, 0, 0, 0));
        }];
        _spListView = spListView;
    }
    return self;
}

- (void)setPiDataModel:(DealsPriceInfoDataModel *)piDataModel
{
    _piDataModel = piDataModel;
    
    //添加价格走势图 PriceView 需要数据 DealsPriceInfoDataModel 的 items

    PriceView *priceView = [[PriceView alloc] initWithDateModel:piDataModel rect:CGRectMake(0, 0, self.width, self.width/1.8)];

    [_scrollView addSubview:priceView];
    
//    [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(120);
//    }];
    
    _headTitle.text = piDataModel.title;
}

- (void)setSdDataModel:(SearchDetailDataModel *)sdDataModel
{
    _sdDataModel = sdDataModel;
        //设置listView时 把scrollView的contentSize设置
    NSUInteger count = sdDataModel.items.count;
    CGFloat tableH = count*33;
    _contentH += tableH;
    
    _scrollView.contentSize = CGSizeMake(0, _contentH);
    _spListView.sdModel = sdDataModel;
    
}



@end
