//
//  DealsViewModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "DealsNetManager.h"
#import "DealsModel.h"

@interface DealsViewModel : BaseViewModel

- (instancetype)initWithType:(CategoryType)type;

@property (nonatomic, assign) CategoryType type;

@property (nonatomic, assign) NSInteger rowNumber;

/** 时间Str */
@property (nonatomic, strong) NSString *secStr;

@end
