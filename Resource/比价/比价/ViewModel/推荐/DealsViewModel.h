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


/** 时间 */
- (NSString *)timeWithRow:(NSInteger)row;
/** 图片URL */
- (NSURL *)picURLWithRow:(NSInteger)row;
/** 题目 */
- (NSMutableAttributedString *)titleWithRow:(NSInteger)row;
/** 来源 */
- (NSString *)sourceWithRow:(NSInteger)row;
/** 赞 */
- (NSString *)supportWithRow:(NSInteger)row;
/** 评论数 */
- (NSString *)commentWithRow:(NSInteger)row;
/** id */
- (NSString *)idStrWithRow:(NSInteger)row;



@end
