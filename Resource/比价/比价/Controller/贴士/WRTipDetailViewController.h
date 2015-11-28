//
//  WRTipDetailViewController.h
//  比价
//
//  Created by apple-jd28 on 15/11/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharePicNetManager.h"

@interface WRTipDetailViewController : UIViewController

- (instancetype)initWithGuideId:(NSString*)idStr type:(ShareType)type;
@property (nonatomic, assign) ShareType type;
@property (nonatomic, strong) NSString *guideId;

@property (nonatomic, assign) BOOL isDealsCome;

@end
