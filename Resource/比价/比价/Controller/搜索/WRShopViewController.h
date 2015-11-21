//
//  WRShopViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/13.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchDetailDataModel;
@interface WRShopViewController : UIViewController
/** 显示在webView的URL */
@property (nonatomic, strong) NSURL *URL;

/** 请求价格波动图 PurchaseURL */
@property (nonatomic, strong) NSString *purchaseURL;
/** 商城列表的数据 */
@property (nonatomic, strong) SearchDetailDataModel *sdDataModel;
/**商家名*/
@property (nonatomic, strong) NSString *siteName;

@end
