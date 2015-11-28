//
//  ShareLableView.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TipListDataModel,DealsDataModel;
@interface ShareLableView : UIView

@property (nonatomic, strong) TipListDataModel *dataModel;

@property (nonatomic, strong) DealsDataModel *ddModel;

@end
