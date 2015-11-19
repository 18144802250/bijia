//
//  ShopPriceListView.h
//  比价
//
//  Created by apple-jd28 on 15/11/17.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopPriceListViewDelegate <NSObject>

@optional
- (void)didClickAtCellIndex:(NSInteger)index;

@end


@class SearchDetailDataModel;
@interface ShopPriceListView : UIView

@property (nonatomic, strong) SearchDetailDataModel *sdModel;

@property (nonatomic, strong) id <ShopPriceListViewDelegate> delegate;
/** 是否是compareView 如果是，把自己*/
@property (nonatomic, assign) BOOL isCompareView;

@end
