//
//  WRTool.m
//  比价
//
//  Created by apple-jd28 on 15/11/10.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRTool.h"

static WRTool *tool = nil;
@implementation WRTool

+ (id)defaultTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [WRTool new];
    });
    return tool;
}

@end
