//
//  ProfileView.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "ProfileView.h"

#import "WRHeadView.h"
#import "ProfileCollectView.h"

@interface ProfileView ()

@property (nonatomic, strong) WRHeadView *titleHead;



@end

@implementation ProfileView

- (ProfileHeaderView *)headView {
	if(_headView == nil) {
		_headView = [[ProfileHeaderView alloc] init];
        [self addSubview:_headView];
	}
	return _headView;
}

- (WRHeadView *)titleHead {
	if(_titleHead == nil) {
		_titleHead = [[WRHeadView alloc] init];
        _titleHead.text = @"我的收藏";
        [self addSubview:_titleHead];
	}
	return _titleHead;
}

- (ProfileCollectView *)collectView {
	if(_collectView == nil) {
		_collectView = [[ProfileCollectView alloc] init];
        [self addSubview:_collectView];
	}
	return _collectView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(180);
        }];
        
        [self.titleHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headView.mas_bottom).mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleHead.mas_bottom).mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

@end
