//
//  TipDetailView.m
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "TipDetailView.h"
#import "TipDetailModel.h"
#import "CommentTableView.h"
#import "WRHeadView.h"

@interface TipDetailView () <UIWebViewDelegate>

/** 标题 */
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *introLb;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) WRHeadView *headView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) CommentTableView *commentTV;

@property (nonatomic, assign) CGFloat contentH;

@end

@implementation TipDetailView


- (UILabel *)titleLb {
	if(_titleLb == nil) {
		_titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_titleLb];
	}
	return _titleLb;
}

- (UILabel *)introLb {
	if(_introLb == nil) {
		_introLb = [[UILabel alloc] init];
        _introLb.font = [UIFont systemFontOfSize:15];
        _introLb.textColor = [UIColor redColor];
        [self addSubview:_introLb];
	}
	return _introLb;
}

- (UILabel *)nameLb {
	if(_nameLb == nil) {
		_nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:12];
        _nameLb.textColor = [UIColor lightGrayColor];
        [self addSubview:_nameLb];
	}
	return _nameLb;
}

- (UILabel *)timeLb {
	if(_timeLb == nil) {
		_timeLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:12];
        _nameLb.textColor = [UIColor lightGrayColor];
        [self addSubview:_timeLb];
	}
	return _timeLb;
}

- (WRHeadView *)headView {
    if(_headView == nil) {
        _headView = [[WRHeadView alloc] init];
        [self addSubview:_headView];
    }
    return _headView;
}

- (UIWebView *)webView {
	if(_webView == nil) {
		_webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [self addSubview:_webView];
	}
	return _webView;
}

- (CommentTableView *)commentTV {
	if(_commentTV == nil) {
		_commentTV = [[CommentTableView alloc] init];
        [self addSubview:_commentTV];
	}
	return _commentTV;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(10);
        }];
        [self.introLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(8);
            make.leftMargin.mas_equalTo(_titleLb.mas_leftMargin).mas_equalTo(0);
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_introLb.mas_bottom).mas_equalTo(8);
            make.leftMargin.mas_equalTo(_titleLb.mas_leftMargin).mas_equalTo(0);
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_introLb.mas_bottom).mas_equalTo(8);
            make.left.mas_equalTo(_nameLb.mas_right).mas_equalTo(10);
        }];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLb.mas_bottom).mas_equalTo(20);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLb.mas_bottom).mas_equalTo(10);
            make.left.right.mas_equalTo(0);
        }];
        
        _contentH = 164;
        self.contentSize = CGSizeMake(0, _contentH);
    }
    return self;
}

- (void)setDataModel:(TipDetailDataModel *)dataModel
{
    _dataModel = dataModel;
    
    _titleLb.text = dataModel.title;
    _introLb.text  = dataModel.intro;
    TipDetailDataAuthorModel *authorModel = dataModel.author[0];
    _nameLb.text = authorModel.nick_name;
    _timeLb.text = dataModel.update_date;
    _headView.text = dataModel.title;
    TipDetailDataSectionListModel *sectionList = dataModel.section_list[0];
    [_webView loadHTMLString:sectionList.content baseURL:nil];
    
}

#pragma mark - UIWebViewDelegate当网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.width = 768;
    frame.size.height = 1;
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    webView.frame = frame;
    /** webView高 */
    CGFloat webViewH = webView.scrollView.contentSize.height;
    [_webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(webViewH);
        make.width.mas_equalTo(self.width);
    }];
    _contentH += webViewH;
    self.contentSize = CGSizeMake(0, _contentH);
    
    NSUInteger count = _dataModel.hot_comments.count;
    if (count > 0) {
        CommentTableView *commentTV = [CommentTableView new];
        commentTV.hotCommentArr = _dataModel.hot_comments;
        
        CGFloat tableH;
        if (count < 4) {
            tableH = count * 44;
        } else {
            tableH = 3 * 44;
        }
        [self addSubview:commentTV];
    }
    
}

@end
