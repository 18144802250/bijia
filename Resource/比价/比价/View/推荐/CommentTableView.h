//
//  CommentTableView.h
//  比价
//
//  Created by apple-jd28 on 15/11/20.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentTableViewDelegate <NSObject>

@optional
- (void)didClickedAtMoreCommentBtn;

@end

@interface CommentTableView : UIView

@property (nonatomic, assign) BOOL isCommentVC;
@property (nonatomic, strong) NSArray *hotCommentArr;

@property (nonatomic, strong) id<CommentTableViewDelegate> delegate;

@end
