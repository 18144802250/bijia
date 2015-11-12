//
//  CommentCell.m
//  比价
//
//  Created by apple-jd28 on 15/11/12.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *conmentLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation CommentCell

- (UIImageView *)icon {
	if(_icon == nil) {
		_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        
	}
	return _icon;
}

- (UILabel *)nameLb {
	if(_nameLb == nil) {
		_nameLb = [[UILabel alloc] init];
	}
	return _nameLb;
}

- (UILabel *)conmentLb {
	if(_conmentLb == nil) {
		_conmentLb = [[UILabel alloc] init];
	}
	return _conmentLb;
}

- (UILabel *)timeLb {
	if(_timeLb == nil) {
		_timeLb = [[UILabel alloc] init];
	}
	return _timeLb;
}

@end
