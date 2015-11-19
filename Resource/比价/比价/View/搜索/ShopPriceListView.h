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

+ (instancetype)viewInRect:(CGRect)frame;

@property (nonatomic, strong) SearchDetailDataModel *sdModel;

@property (nonatomic, strong) id <ShopPriceListViewDelegate> delegate;
/** 是否是compareView 如果是，把对应的商家名去掉*/
@property (nonatomic, assign) BOOL isCompareView;
/** 商家名 */
@property (nonatomic, strong) NSString *siteName;

@end
