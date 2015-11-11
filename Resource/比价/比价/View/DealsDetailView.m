//
//  DealsDetailView.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailView.h"

@interface DealsDetailView ()

/** 头部图片 680*332 */
@property (nonatomic, strong) UIImageView *headIcon;

/** webView加载内容 */
@property (nonatomic, strong) UIWebView *contentWebView;

/** 价格走势 */
@property (nonatomic, strong) UIView *priceView;
/** 热门评论 */
@property (nonatomic, strong) UITableView *hotCommentTv;


@end

@implementation DealsDetailView

- (UIImageView *)headIcon {
	if(_headIcon == nil) {
		_headIcon = [[UIImageView alloc] init];
        _headIcon.backgroundColor = [UIColor redColor];
        _headIcon.contentMode = UIViewContentModeScaleAspectFill;
        _headIcon.clipsToBounds = YES;
	}
	return _headIcon;
}

- (UIWebView *)contentWebView {
	if(_contentWebView == nil) {
		_contentWebView = [[UIWebView alloc] init];
        _contentWebView.backgroundColor = [UIColor purpleColor];

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
            make.size.mas_equalTo(CGSizeMake(kWindowW, 200));
        }];
        
        [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headIcon.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(400);
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
    
    self.contentSize = CGSizeMake(0, sv.contentSize.height + _headIcon.)
}

- (void)setPm:(DealsPriceInfoDataModel *)pm
{
    _pm = pm;
    
    
}

@end
