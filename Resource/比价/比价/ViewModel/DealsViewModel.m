
//
//  DealsViewModel.m
//  比价
//
//  Created by apple-jd28 on 15/11/9.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "DealsViewModel.h"
#import "WRTool.h"

@interface DealsViewModel ()

@end

@implementation DealsViewModel



- (instancetype)initWithType:(CategoryType)type
{
    if (self = [super init]) {
        
        _type = type;
        
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
    self.dataTask = [DealsNetManager getDealsDataWithType:_type Sec:_secStr completionHandle:^(DealsModel *model, NSError *error) {
        
        if ([_secStr isEqualToString:@"0"]) {
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray:model.data];
        
        completionHandle(error);
    }];
}


- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    _secStr = @"0";
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    if (self.dataArr.count) {
        
        NSTimeInterval sec = [self publishDateWithRow:self.dataArr.count-1].timeIntervalSince1970;
        
        _secStr = [NSString stringWithFormat:@"%ld0000",(NSInteger)sec/10];
    }
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (NSDate*)publishDateWithRow:(NSInteger)row
{
    NSDateFormatter *formatter = [NSDateFormatter new];//Tue Nov 10 08:30:28 +0800 2015
    formatter.dateFormat = @"EEE MMM d HH:mm:ss z yyyy";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en-us"];
    return [formatter dateFromString:[self modelWithRow:row].pub_time];
}

- (DealsDataModel *)modelWithRow:(NSInteger)row
{
    return self.dataArr[row];
}

- (NSInteger)rowNumber
{
    return self.dataArr.count;
}
/** 时间 */
- (NSString *)timeWithRow:(NSInteger)row
{
    NSDateComponents *cmp = [self modelWithRow:row].daysFromToday;
    if (cmp.day > 0) {
        return nil;
    } else {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [formatter stringFromDate:[self publishDateWithRow:row]];
        WRTool *tool = [WRTool defaultTool];
        tool.timeStr = dateStr;
        return dateStr;
    }
}
/** 图片URL */
- (NSURL *)picURLWithRow:(NSInteger)row
{
    NSString *strURL = [NSString stringWithFormat:@"%@.jpg",[self modelWithRow:row].image_url];
    return [NSURL URLWithString:strURL];
}
/** 题目 */
- (NSMutableAttributedString *)titleWithRow:(NSInteger)row
{
    NSString *subTitle = [self modelWithRow:row].sub_title;
    NSString *title = [NSString stringWithFormat:@"%@ %@",[self modelWithRow:row].title,subTitle];
    NSRange subRange = [title rangeOfString:subTitle];
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:subRange];
    return titleAttri;
}
/** 来源 */
- (NSString *)sourceWithRow:(NSInteger)row
{
    DealsDataMerchantModel *model = [self modelWithRow:row].merchant;
    return model.name;
}
/** 赞 */
- (NSString *)supportWithRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld",[self modelWithRow:row].supports_count];
}
/** 评论数 */
- (NSString *)commentWithRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld",[self modelWithRow:row].comments_count];
}



@end
