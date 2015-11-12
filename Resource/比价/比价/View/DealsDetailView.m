//
//  DealsDetailView.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailView.h"
#import "UIView+Extension.h"

@interface DealsDetailView ()<UIWebViewDelegate>

/** 头部图片 680*332 */
@property (nonatomic, strong) UIImageView *headIcon;

/** webView加载内容 */
@property (nonatomic, strong) UIWebView *contentWebView;

/** 价格走势 */
@property (nonatomic, strong) UIView *priceView;
/** 热门评论 */
@property (nonatomic, strong) UITableView *hotCommentTv;

@property (nonatomic) CGFloat contentH;


@end

@implementation DealsDetailView

- (UIImageView *)headIcon {
	if(_headIcon == nil) {
		_headIcon = [[UIImageView alloc] init];
        _headIcon.backgroundColor = [UIColor redColor];
        _headIcon.contentMode = UIViewContentModeScaleAspectFill;
        _headIcon.clipsToBounds = YES;
        
        [_headIcon addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
	}
	return _headIcon;
}

- (UIWebView *)contentWebView {
	if(_contentWebView == nil) {
		_contentWebView = [[UIWebView alloc] init];
        _contentWebView.backgroundColor = [UIColor purpleColor];
        _contentWebView.delegate = self;
	}
	return _contentWebView;
}

- (UIView *)priceView {
	if(_priceView == nil) {
		_priceView = [[UIView alloc] init];
	}
	return _priceView;
}

- (UITableView *)hotCommentTv {
	if(_hotCommentTv == nil) {
		_hotCommentTv = [[UITableView alloc] init];
        _hotCommentTv.dataSource = self;
        _hotCommentTv.delegate = self;
        
        _hotCommentTv registerClass:<#(nullable Class)#> forCellReuseIdentifier:<#(nonnull NSString *)#>
	}
	return _hotCommentTv;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.headIcon];
        [self addSubview:self.contentWebView];
        [self addSubview:self.priceView];
        [self addSubview:self.hotCommentTv];
        
        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kWindowW, 150));
        }];
    
    }
    return self;
}

- (void)setVm:(DealsDetailViewModel *)vm
{
    _vm = vm;
    
    [_headIcon setImageWithURL:[NSURL URLWithString:vm.detailDataModel.image_url] placeholderImage:[UIImage imageNamed:@"success@3x"]];
    
    [_contentWebView loadHTMLString:vm.detailDataModel.page baseURL:nil];
    
    UIScrollView *sv = (UIScrollView*)[[_contentWebView subviews] objectAtIndex:0];
    sv.bounces = NO;
    
}

- (void)setPm:(DealsPriceInfoDataModel *)pm
{
    _pm = pm;
    
    
}

#pragma mark - webView代理方法  计算webView的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.width = 768;
    frame.size.height = 1;
    webView.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    _contentH = webView.scrollView.contentSize.height + 200;
    [_contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headIcon.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(_contentH);
    }];
    self.contentSize = CGSizeMake(0, _contentH + _headIcon.height);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat headHeight = _headIcon.image.size.height;
    CGFloat headWidth = _headIcon.image.size.width;
    CGFloat h = kWindowW/(headWidth/headHeight);
    
    if (h > 10) {
        [_headIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        
            make.top.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kWindowW, h));
        }];
        self.contentSize = CGSizeMake(0, _contentH + h);
    }
}

- (void)dealloc
{
    [_headIcon removeObserver:self forKeyPath:@"image"];
    
}

@end
