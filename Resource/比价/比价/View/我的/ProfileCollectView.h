//
//  ProfileCollectView.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileCollectViewDelegate <NSObject>

@optional
- (void)didClickAtCollectViewCellWithIndex:(NSUInteger)index url:(NSURL*)url title:(NSString*)title;

- (void)longPressAtCollectViewCellWithIndex:(NSUInteger)index objectId:(NSString*)objectId;

@end

@interface ProfileCollectView : UIView

@property (nonatomic, strong) NSArray *collectArr;

@property (nonatomic, strong) id<ProfileCollectViewDelegate> delegate;

@end
