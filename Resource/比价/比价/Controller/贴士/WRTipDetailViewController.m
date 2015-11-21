

//
//  WRTipDetailViewController.m
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTipDetailViewController.h"
#import "SharePicNetManager.h"
#import "TipDetailView.h"
#import "TipDetailModel.h"

@interface WRTipDetailViewController ()

@property (nonatomic, strong) TipDetailDataModel *tipDetailModel;

@end

@implementation WRTipDetailViewController

- (instancetype)initWithGuideId:(NSString *)idStr
{
    if (self = [super init]) {
        
        _guideId = idStr;
        
    }
    return self;
}

/** 预防init */
- (instancetype)init
{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 请使用initWithGuideId初始化", __FUNCTION__);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showProgress];
    [SharePicNetManager getTipDetailDataWithGuideId:_guideId completionHandle:^(TipDetailModel *model, NSError *error) {
        [self hideProgress];
        
        TipDetailView *tipDetailView = [TipDetailView new];
        
        [self.view addSubview:tipDetailView];
        [tipDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        tipDetailView.dataModel = model.data;
        _tipDetailModel = model.data;
    }];
    
    
}



@end
