//
//  WRCover.h
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WRCoverDelegate <NSObject>

@optional
- (void)didClickedAtCoverView;

@end

@interface WRCover : UIView

+ (instancetype)show;

@property (nonatomic, strong) id <WRCoverDelegate> delegate;

@end
