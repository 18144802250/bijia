//
//  WRTool.h
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DealsNetManager.h"

@interface WRTool : NSObject

+ (WRTool*)defaultTool;

@property (nonatomic, strong) NSString *timeStr;

@property (nonatomic, assign) CategoryType type;

@property (nonatomic, assign) NSUInteger selectIndexItem;


@end
