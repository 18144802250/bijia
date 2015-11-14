//
//  WRShopListView.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopViewModel.h"



@protocol WRShopListViewDelegate <NSObject>

@optional
- (void)didClickedAtBtnTag:(NSInteger)index;

@end

@interface WRShopListView : UIView

@property (nonatomic, strong) ShopViewModel *shopModel;

@property (nonatomic, strong) id<WRShopListViewDelegate> delegate;

@end
