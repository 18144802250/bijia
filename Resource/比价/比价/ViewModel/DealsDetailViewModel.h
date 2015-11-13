//
//  DealsDetailViewModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseViewModel.h"
#import "DealsDetailModel.h"
#import "DealsPriceInfoModel.h"

@interface DealsDetailViewModel : BaseViewModel

- (instancetype)initWithIdStr:(NSString*)idStr;
/** idStr */
@property (nonatomic, strong) NSString *idStr;
/** 价格走势URL */
@property (nonatomic, strong) NSString *purchaseURL;
/** detailData模型 */
@property (nonatomic, strong) DealsDetailDataModel *detailDataModel;
/** priceInfoData模型 */
@property (nonatomic, strong) DealsPriceInfoDataModel *priceInfoModel;





@end
