//
//  PriceView.m
//  比价
//
//  Created by apple-jd28 on 15/11/12.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "PriceView.h"
#import "NSString+Extension.h"

@interface PriceView ()


@property (nonatomic, strong) NSArray *priceTimeArr;
/** 波动价格数组 */
@property (nonatomic, strong) NSArray *priceArr;
/** 波动时间数组 */
@property (nonatomic, strong) NSArray *timeArr;
/** 标志时间数组 */
@property (nonatomic, strong) NSArray *signTimeArr;


/** 开始时间 */
@property (nonatomic, strong) NSString *startTime;
/** 结束时间 */
@property (nonatomic, strong) NSString *endTime;

/** 最高价格 */
@property (nonatomic) CGFloat hPrice;
/** 结束时间 */
@property (nonatomic) CGFloat lPrice;

/** 相差总天数 */
@property (nonatomic) NSUInteger days;

@end

@implementation PriceView

- (NSArray *)priceArr {
	if(_priceArr == nil) {
		_priceArr = [[NSArray alloc] init];
	}
	return _priceArr;
}

- (NSArray *)timeArr {
	if(_timeArr == nil) {
		_timeArr = [[NSArray alloc] init];
	}
	return _timeArr;
}

- (void)setData:(DealsPriceInfoDataModel *)data
{
    _data = data;
    _startTime = data.start;
    _endTime = data.end;
    [self setUpArr];
    /** 计算最大最小价格 */
    [self countHLPrice];
    /** 计算标志时间数组 */
    [self countSignTimeArr];
    /** 开始构图 4x4表格 宽x2=高 */
    [self setNeedsDisplay];
}

/** 数组分配 */
- (void)setUpArr
{
    NSMutableArray *prices = [NSMutableArray new];
    NSMutableArray *times = [NSMutableArray new];
    for (DealsPriceHistoryModel *priceTime in _data.price_history) {
        [prices addObject:priceTime.price];
        [times addObject:priceTime.time];
    }
    self.priceArr = [prices copy];
    self.timeArr = [times copy];
}

/** 计算标志时间数组 */
- (void)countSignTimeArr
{
    NSMutableArray *signArr = [NSMutableArray new];
    //开始时间 - 结束时间 / 4
    
    //总天数
    _days = [_startTime daysToDate:_endTime];
    //每格天数 一共4格
    NSInteger intervalDay = _days/4;
    
    NSDateComponents *startCmps = [_startTime dateCmpFormStr];
    NSUInteger month = startCmps.month;
    NSUInteger day = startCmps.day;
    NSUInteger monthDay = 0;
    for (int i = 0; i < 4; i++) {
        if (i == 0) {
            [signArr addObject:_startTime];
            i =1;
        }
        day += intervalDay;
        monthDay = [_startTime myDays:month];
        if (day > monthDay) {
            month++;
            day -= monthDay;
        }
        NSString *timeStr = [NSString stringWithFormat:@"%ld-%ld",month,day];
        [signArr addObject:timeStr];
        if (i == 3) {
            [signArr addObject:_endTime];
            break;
        }
    }
    _signTimeArr = [signArr copy];
}

- (void)countHLPrice
{
    _hPrice = [self.priceArr.firstObject floatValue];
    _lPrice = [self.priceArr.firstObject floatValue];
    for (NSString *x in self.priceArr) {
        CGFloat y = x.floatValue;
        if (y > _hPrice) {
            _hPrice = y;
        }
        if (_lPrice > y) {
            _lPrice = y;
        }
    }
}



#pragma mark - DrawRect绘图
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *tablePath = [UIBezierPath bezierPath];
    
    /** 表格的宽 高*/
    CGFloat tableW = (kWindowW - 2*30)/4;
    CGFloat tableH = tableW / 2;
    /** 绘制表格  8条线 i = 0 画横线 i = 1 画竖线 */
    /** 横线的起点 距离左边30 上边20*/
    CGFloat x = 0,y = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            
            if (i == 0) {
                x = 30;
                y = 20+j*tableH;
                [tablePath moveToPoint:CGPointMake(x, y)];
                x = 30+(i+1)*4*tableW;
                [tablePath addLineToPoint:CGPointMake(x, y)];
            }
            
            if (i == 1) {
                x = 30+j*tableW;
                y = 20;
                [tablePath moveToPoint:CGPointMake(x, y)];
                y = 20+j*4*tableH;
                [tablePath addLineToPoint:CGPointMake(x, y)];
            }
        }
    }
    
    [[UIColor blackColor] setStroke];
    [tablePath stroke];
    
    //字符串的属性
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //开始绘制点
    x = 10;
    y = 20 + tableH*4;
    /** 把时间字符串画上 据左边10 */
    for (NSString *str in self.signTimeArr) {
        x += tableW;
        [str drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
    }
    
    /** 开始绘制折线 */
    /** 绘制最高价格和最低价格 y轴相差3个tableH  */
    x = 30 + 4*tableW;
    y = 20 + tableH/3;
    [[NSString stringWithFormat:@"%lf",_hPrice] drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
    y += 3*tableH;
    [[NSString stringWithFormat:@"%lf",_lPrice] drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
    
    /** 计算价格差对应的Y值 */
    CGFloat ptPerH = 3*tableH/(_hPrice - _lPrice);
    /** 天数对应的X值 */
    CGFloat ptPerW = 4*tableW/_days;
    /** 解决行高价格的值  值对应的高 */
    UIBezierPath *trendPath = [UIBezierPath bezierPath];
    [trendPath moveToPoint:CGPointMake(30, 20+2*tableH)];
    for (NSUInteger i = 0; i < self.timeArr.count; i++) {
        x = 30 + ptPerW*[_startTime daysToDate:self.timeArr[i]];
        y = 20 + ptPerH*([self.priceArr[i] floatValue] - _lPrice);
        [trendPath addLineToPoint:CGPointMake(x, y)];
    }
    [[UIColor blueColor] setStroke];
    [trendPath stroke];
}



@end
