//
//  DealsDetailView.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRBuyButton.h"

@class DealsDetailDataModel,DealsPriceInfoDataModel;
@interface DealsDetailView : UIView

@property (nonatomic, strong) WRBuyButton *buy;

@property (nonatomic, strong) DealsDetailDataModel *dataModel;

@property (nonatomic, strong) DealsPriceInfoDataModel *priceInfoModel;

@end
