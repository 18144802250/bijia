//
//  WRToolBar.h
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WRToolBarDelegate <NSObject>

@optional
- (void)didClickedAtBtn;

@end

typedef NS_ENUM(NSUInteger, PriceWaveType) {
    PriceWaveTypeUp,
    PriceWaveTypeDown,
    PriceWaveTypeClam,
};

@interface WRToolBar : UIView

@property (nonatomic, assign) PriceWaveType type;
@property (nonatomic, assign) NSInteger shopNum;

@property (nonatomic, strong) id <WRToolBarDelegate> delegate;

@end
