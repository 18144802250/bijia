//
//  TipViewModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/19.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "BaseViewModel.h"
#import "SharePicNetManager.h"

@interface TipViewModel : BaseViewModel

- (instancetype)initWithType:(ShareType)type;

@property (nonatomic, assign) ShareType type;
/** 时间Str */
@property (nonatomic, strong) NSString *secStr;


@end
