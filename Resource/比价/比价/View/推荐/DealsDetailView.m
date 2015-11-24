//
//  DealsDetailView.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailView.h"
#import "UIView+Extension.h"
#import "CommentTableView.h"
#import "PriceView.h"

@interface DealsDetailView ()<UIWebViewDelegate>
/** 头部图片 680*332 */
//@property (nonatomic, strong) UIImageView *headIcon;
/** webView加载内容 */
@property (nonatomic, strong) UIWebView *contentWebView;
/** 热门评论 */
@property (nonatomic, strong) CommentTableView *hotCommentTV;

@property (nonatomic) CGFloat cellH;

@end

@implementation DealsDetailView

//- (UIImageView *)headIcon {
//	if(_headIcon == nil) {
//		_headIcon = [[UIImageView alloc] init];
//        _headIcon.contentMode = UIViewContentModeScaleAspectFill;
//        _headIcon.clipsToBounds = YES;
//        
//        [_headIcon addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
//	}
//	return _headIcon;
//}

- (UIWebView *)contentWebView {
	if(_contentWebView == nil) {
		_contentWebView = [[UIWebView alloc] init];
        _contentWebView.delegate = self;
	}
	return _contentWebView;
}

//- (CommentTableView *)hotCommentTV {
//	if(_hotCommentTV == nil) {
//		_hotCommentTV = [[CommentTableView alloc] init];
//        
//	}
//	return _hotCommentTV;
//}
#pragma mark - 初始化View时
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _cellH = 44;
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor grayColor];
        
//        [self addSubview:self.headIcon];
        [self addSubview:self.contentWebView];
        
        
//        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(kWindowW, 150));
//        }];
        
        [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_headIcon.mas_bottom).mas_equalTo(0);
            make.top.left.right.mas_equalTo(0);
        }];

//        [self.hotCommentTV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.mas_equalTo(0);
//        }];
        
//        _contentH = 150;

    }
    return self;
}
#pragma mark - 头部图片设置 webView读取html 评论tableView重新加载
- (void)setVm:(DealsDetailViewModel *)vm
{
    _vm = vm;
    
//    [_headIcon setImageWithURL:[NSURL URLWithString:vm.detailDataModel.image_url]];
    
    [_contentWebView loadHTMLString:vm.detailDataModel.page baseURL:nil];
    
}


#pragma mark - 价格走势图
- (void)setPm:(DealsPriceInfoDataModel *)pm
{
    _pm = pm;
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
//    CGFloat documentWidth = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').offsetWidth"] floatValue];
//    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
//    
//    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight"] floatValue];
    
//    NSLog(@"documentSize = {%f, %f}", documentWidth, documentHeight);
    
    CGRect frame = webView.frame;
    frame.size.width = 768;
    frame.size.height = 1;
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    webView.frame = frame;
    /** webView高 */
    CGFloat webViewH = webView.scrollView.contentSize.height;
    DDLogVerbose(@"webViewH = %lf",webViewH);
    [_contentWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(webViewH);
    }];
    _contentH += webViewH;
    self.contentSize = CGSizeMake(0, _contentH);
    
    NSUInteger count = self.vm.detailDataModel.hot_comments.count;
    if (count==0) {
        return;
    }
    CGFloat commentTvH = 0;
    if (count < 4) {
        commentTvH = _cellH*count + 40;
    } else
        commentTvH = _cellH * 3 + 40;
    CommentTableView *commentTV = [[CommentTableView alloc] initWithFrame:CGRectMake(0, _contentH, self.width, commentTvH) style:0];
//    [_hotCommentTV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(commentTvH);
//    }];
    commentTV.hotCommentArr = self.vm.detailDataModel.hot_comments;
    [self addSubview:commentTV];
    _hotCommentTV = commentTV;
    
    _contentH += commentTvH;
    self.contentSize = CGSizeMake(0, _contentH);
}
#pragma mark - 当头部的图片有值时调用 
//会调用两次 设置前置图片时调用一次 获取网络图片时调用一次
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//
//    if ([keyPath isEqualToString:@"image"]) {
//        CGFloat headHeight = _headIcon.image.size.height;
//        CGFloat headWidth = _headIcon.image.size.width;
//        CGFloat h = kWindowW/(headWidth/headHeight);
//        
//        if (h > 100) {
//            [_headIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(h);
//            }];
//            _contentH = _contentH + h - 150;
//            self.contentSize = CGSizeMake(0, _contentH);
//        }
//    }
//        
//
//    
//}
#pragma mark - 对象销毁时 移除监听者
//- (void)dealloc
//{
//    [_headIcon removeObserver:self forKeyPath:@"image"];
//}


@end
