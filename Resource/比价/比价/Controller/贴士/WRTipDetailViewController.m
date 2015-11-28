

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

- (instancetype)initWithGuideId:(NSString *)idStr type:(ShareType)type
{
    if (self = [super init]) {
        
        _guideId = idStr;
        _type = type;
        
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
    self.title = @"详情";
    
    [self showProgress];
    [SharePicNetManager getTipDetailDataWithGuideId:_guideId type:_type completionHandle:^(TipDetailModel *model, NSError *error) {
        [self hideProgress];
        switch (_type) {
            case ShareTypePic:
            {
                UIWebView *webView = [UIWebView new];
                [self.view addSubview:webView];
                [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(0);
                }];
                [webView loadHTMLString:model.data.page baseURL:nil];
                if (_isDealsCome) {
                    [WRNaviTool addBackItemAtPresentVC:self];
                }
                
                break;
            }
            case ShareTypeTip:
            {
                TipDetailView *tipDetailView = [TipDetailView new];
                
                [self.view addSubview:tipDetailView];
                [tipDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(0);
                }];
                
                tipDetailView.dataModel = model.data;
                _tipDetailModel = model.data;
                break;
            }
            default:
                break;
        }
        
    }];
    
    
}



@end
