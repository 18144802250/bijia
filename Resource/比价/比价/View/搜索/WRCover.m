
//
//  WRCover.m
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRCover.h"

@implementation WRCover

+ (instancetype)show
{
    WRCover *cover = [[WRCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    cover.backgroundColor = [UIColor blackColor];
    
    cover.alpha = 0.6;
    
    [Keywindow addSubview:cover];
    
    return cover;
}

+ (void)hide
{
    for (UIView *view in Keywindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(didClickedAtCoverView)]) {
        [_delegate didClickedAtCoverView];
    }
}

@end
