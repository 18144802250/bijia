//
//  DealsDetailView.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailView.h"
#import "PriceView.h"
#import "DealsDetailModel.h"

#define WRWebViewH 500

@interface DealsDetailView ()<UIWebViewDelegate>
/** webView加载内容 */
@property (nonatomic, strong) UIWebView *contentWebView;


@end

@implementation DealsDetailView
{
    CGFloat _contentH;
}

- (UIScrollView *)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (CommentTableView *)hotCommentTV {
	if(_hotCommentTV == nil) {
		_hotCommentTV = [[CommentTableView alloc] init];
	}
	return _hotCommentTV;
}
#pragma mark - 初始化View时
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.hotCommentTV.hidden = NO;
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-40);
        }];
    }
    return self;
}
#pragma mark - webView读取html 评论tableView重新加载
- (void)setDataModel:(DealsDetailDataModel *)dataModel
{
    _dataModel = dataModel;

    UIWebView *webView = [[UIWebView alloc] init];
    webView.userInteractionEnabled = YES;
    webView.delegate = self;
    [_scrollView addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width, WRWebViewH));
    }];
    [webView loadHTMLString:dataModel.page baseURL:nil];
    _contentWebView = webView;
}


#pragma mark - 价格走势图
- (void)setPriceInfoModel:(DealsPriceInfoDataModel *)priceInfoModel
{
    _priceInfoModel = priceInfoModel;
//    if (pm.price_history.count>1&&pm!=nil) {
//        PriceView *pv = [[PriceView alloc] initWithDateModel:pm rect:CGRectMake(0, 0, self.width, self.width/1.8)];
//        
//        [self addSubview:pv];
//        CGFloat h = self.width/1.8;
//        pv.frame = CGRectMake(self.width, _contentH, self.width, h);
//        
//        _contentH += h;
//        self.contentSize = CGSizeMake(0, _contentH);
//    }
}

#pragma mark - webView代理方法  计算webView的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    webView.scrollView.bounces = NO;
    NSUInteger count = self.dataModel.hot_comments.count;
    if (count==0) {
        return;
    }
    CGFloat commentTvH = 0;
    if (count < 4) {
        commentTvH = 44*count + 188;
    } else {
        commentTvH = 44 * 3 + 188;
    }

    [_scrollView addSubview:self.hotCommentTV];
    [_hotCommentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentWebView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(commentTvH);
    }];
    _hotCommentTV.hotCommentArr = self.dataModel.hot_comments;
    
    _contentH = WRWebViewH;
    _contentH += commentTvH;
    _scrollView.contentSize = CGSizeMake(0, _contentH);
    
    
}

@end
