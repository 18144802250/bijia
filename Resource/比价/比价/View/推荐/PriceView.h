//
//  PriceView.h
//  比价
//
//  Created by apple-jd28 on 15/11/12.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsPriceInfoModel.h"

@interface PriceView : UIView

- (instancetype)initWithDateModel:(DealsPriceInfoDataModel*)data rect:(CGRect)frame;

@property (nonatomic, strong) DealsPriceInfoDataModel *data;

@end
