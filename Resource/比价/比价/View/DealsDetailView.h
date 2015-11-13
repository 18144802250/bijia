//
//  DealsDetailView.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsDetailViewModel.h"
#import "DealsPriceInfoModel.h"

@interface DealsDetailView : UIScrollView

@property (nonatomic, strong) DealsDetailViewModel *vm;

@property (nonatomic, strong) DealsPriceInfoDataModel *pm;

@property (nonatomic) CGFloat contentH;

@end
