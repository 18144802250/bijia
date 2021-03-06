//
//  WRShopViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchDetailDataModel,SearchDetailDataItemsModel,SearchResultDataInlandModel;
@interface WRShopViewController : UIViewController
/** 显示在webView的URL */
@property (nonatomic, strong) NSURL *URL;

/** 请求价格波动图 PurchaseURL */
@property (nonatomic, strong) NSString *purchaseURL;
/** 商城列表的数据 */
@property (nonatomic, strong) SearchDetailDataModel *sdDataModel;
/** 详细商家数据 */
@property (nonatomic, strong) SearchDetailDataItemsModel *itemModel;
/**商家名*/
@property (nonatomic, strong) NSString *siteName;
/** 如果没有sdDataModel数据，需要传入title收藏和imageUrl */
@property (nonatomic, strong) SearchResultDataInlandModel *inlandModel;

@end
