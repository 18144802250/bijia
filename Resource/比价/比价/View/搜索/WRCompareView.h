//
//  WRCompareView.h
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealsPriceInfoDataModel,SearchDetailDataModel;
@interface WRCompareView : UIView

+ (instancetype)showInRect:(CGRect)frame;

+ (void)hide;

@property (nonatomic, strong) DealsPriceInfoDataModel *piDataModel;
@property (nonatomic, strong) SearchDetailDataModel *sdDataModel;

/** 商家名 */
@property (nonatomic, strong) NSString *siteName;

@end
