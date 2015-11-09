//
//  DealsViewModel.h
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealsViewModel : NSObject

@property (nonatomic, assign) NSInteger rowNumber;

/** 时间Str */
@property (nonatomic, strong) NSString *secStr;

/** 图片URL */
- (NSURL *)picURLWithRow:(NSInteger)row;
/** 题目 */
- (NSString *)titleWithRow:(NSInteger)row;
/** 描述 */
- (NSString *)descWithRow:(NSInteger)row;
/** 集数 */
- (NSString *)numWithRow:(NSInteger)row;

@end
