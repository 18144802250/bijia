//
//  DealsDetailViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsDetailViewModel.h"
#import "DealsNetManager.h"

@implementation DealsDetailViewModel

- (instancetype)initWithIdStr:(NSString *)idStr
{
    if (self = [super init]) {
        
        _idStr = idStr;

    }
    return self;
}

/** 预防init */
- (instancetype)init
{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 请使用initWithType初始化", __FUNCTION__);
    }
    return self;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    [DealsNetManager getDealsDetailDataWithContentId:_idStr completionHandle:^(DealsDetailModel *model, NSError *error) {
        
        //设置frame
        self.detailDataModel = model.data;
        
        self.purchaseURL = _detailDataModel.purchase_url;
        
        completionHandle(error);
    }];
    
    
}

#pragma mark - 重写setPurchaseURL 请求数据

- (void)setPurchaseURL:(NSString *)purchaseURL
{
    _purchaseURL = purchaseURL;
    
    [DealsNetManager getDealsDataPriceWithPurchaseURL:purchaseURL completionHandle:^(DealsPriceInfoModel *model, NSError *error) {
        //设置frame
        self.priceInfoModel = model.data;
        
    }];
    
}


@end
