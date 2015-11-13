//
//  DealsDetailView.m
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailView.h"
#import "UIView+Extension.h"
#import "CommentCell.h"
#import "PriceView.h"

@interface DealsDetailView ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>

/** 头部图片 680*332 */
@property (nonatomic, strong) UIImageView *headIcon;

/** webView加载内容 */
@property (nonatomic, strong) UIWebView *contentWebView;

/** 价格走势 */
@property (nonatomic, strong) UIView *priceView;
/** 热门评论 */
@property (nonatomic, strong) UITableView *hotCommentTv;



@property (nonatomic) CGFloat cellH;

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
        _hotCommentTv.rowHeight = 48;
        _cellH = _hotCommentTv.rowHeight;
        
        
        
        [_hotCommentTv registerClass:[CommentCell class] forCellReuseIdentifier:@"Cell"];
	}
	return _hotCommentTv;
}
#pragma mark - 初始化View时
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
        
        [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headIcon.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
        }];
        
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_contentWebView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
        }];
        
        [self.hotCommentTv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_priceView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
        }];
        
        _contentH = 150;

    }
    return self;
}
#pragma mark - 头部图片设置 webView读取html 评论tableView重新加载
- (void)setVm:(DealsDetailViewModel *)vm
{
    _vm = vm;
    
    [_headIcon setImageWithURL:[NSURL URLWithString:vm.detailDataModel.image_url]];
    
    [_contentWebView loadHTMLString:vm.detailDataModel.page baseURL:nil];
    
}


#pragma mark - 价格走势图
- (void)setPm:(DealsPriceInfoDataModel *)pm
{
    _pm = pm;
    if (pm.price_history.count>1&&pm!=nil) {
        PriceView *pv = [PriceView new];
        pv.data = pm;
        CGFloat h = (kWindowW - 60)/2 + 40;
        [_priceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(h);
        }];
        _contentH += h;
        self.contentSize = CGSizeMake(0, _contentH);
    }
    
}

#pragma mark - webView代理方法  计算webView的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.width = 768;
    frame.size.height = 1;
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    webView.frame = frame;
    /** webView高 */
    CGFloat webViewH = webView.scrollView.contentSize.height + 200;
    [_contentWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(webViewH);
    }];
    _contentH += webViewH;
    self.contentSize = CGSizeMake(0, _contentH);
    
    NSUInteger count = self.vm.detailDataModel.hot_comments.count;
    if (count==0) {
        return;
    }
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 40)];
    headView.backgroundColor = [UIColor lightGrayColor];
    UILabel *textLb = [UILabel new];
    textLb.text = @"热门评论";
    textLb.backgroundColor = [UIColor clearColor];
    [headView addSubview:textLb];
    [textLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 12, 0, 0));
    }];
    
    _hotCommentTv.tableHeaderView = headView;
    CGFloat commentTvH = 0;
    if (count < 4) {
        commentTvH = _cellH*count + 40;
    } else
        commentTvH = _cellH * 3 + 40;
    [_hotCommentTv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(commentTvH);
    }];
    _contentH += commentTvH;
    self.contentSize = CGSizeMake(0, _contentH);
    [_hotCommentTv reloadData];
}
#pragma mark - 当头部的图片有值时调用 
//会调用两次 设置前置图片时调用一次 获取网络图片时调用一次
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    if ([keyPath isEqualToString:@"image"]) {
        CGFloat headHeight = _headIcon.image.size.height;
        CGFloat headWidth = _headIcon.image.size.width;
        CGFloat h = kWindowW/(headWidth/headHeight);
        
        if (h > 100) {
            [_headIcon mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(h);
            }];
            _contentH = _contentH + h - 150;
            self.contentSize = CGSizeMake(0, _contentH);
        }
    }
        

    
}
#pragma mark - 对象销毁时 移除监听者
- (void)dealloc
{
    [_headIcon removeObserver:self forKeyPath:@"image"];
}

#pragma mark - tableViewDataSource 数据源配置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.vm.detailDataModel.hot_comments.count;
    if (count < 4) {
        return count;
    }
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.commontModel = self.vm.detailDataModel.hot_comments[indexPath.row];
    
    return cell;
}

@end
