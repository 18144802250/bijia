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

- (instancetype)initWithDateModel:(DealsPriceInfoDataModel *)data rect:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _data = data;
        if (!data.other_quotes) {
            return nil;
        }
        _startTime = data.start;
        _endTime = data.end;
        
        /** 计算标志时间数组 */
        [self countSignTimeArr];
        
        _priceTimeArr = data.price_history;
        
        /** 计算最大最小价格 */
        [self countHLPrice];
        
//        [self setNeedsDisplayInRect:frame];
    }
    return self;
}



- (void)setData:(DealsPriceInfoDataModel *)data
{
    _data = data;
    if (!data.other_quotes) {
        return;
    }
    _startTime = data.start;
    _endTime = data.end;

    /** 计算最大最小价格 */
    [self countHLPrice];
    /** 计算标志时间数组 */
    [self countSignTimeArr];
    /** 开始构图 4x4表格 宽x2=高 */
    [self setNeedsDisplay];
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
    DealsPriceHistoryModel *phModel = _priceTimeArr.firstObject;
    _hPrice = [phModel.price floatValue];
    _lPrice = [phModel.price floatValue];
    for (DealsPriceHistoryModel *model in _priceTimeArr) {
        CGFloat y = model.price.floatValue;
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
    CGFloat tableW = (self.width - 2*30)/4;
    CGFloat tableH = tableW / 2;
    /** 绘制表格  8条线 i = 0 画横线 i = 1 画竖线 */
    /** 横线的起点 距离左边30 上边20*/
    CGFloat x = 0,y = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 5; j++) {
            
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
                y = 20+i*4*tableH;
                [tablePath addLineToPoint:CGPointMake(x, y)];
            }
        }
    }
    tablePath.lineWidth = 1;
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
        NSString *s = [str stringByReplacingOccurrencesOfString:@"2015-" withString:@""];
        [s drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
        x += tableW;
    }
    
  
    /** 开始绘制折线 */
    /**  如果一样，只画一个 绘制最高价格和最低价格 y轴相差3个tableH  */
    
    x = 30 + 4*tableW;
    if (_hPrice == _lPrice) {
        
        //表格的中间
        y = 20 + tableH*2;
        
        [[NSString stringWithFormat:@"%lf",_hPrice] drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
    } else {
        y = 20 + tableH/3;
        [[NSString stringWithFormat:@"%lf",_hPrice] drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
        y += 3*tableH;
        [[NSString stringWithFormat:@"%lf",_lPrice] drawAtPoint:CGPointMake(x, y) withAttributes:attributes];
    }
    /** 计算价格差对应的Y值   如果一样 直接绘制一条直线再中间*/
  
    /**  如果一样 只画一条直线*/
    CGFloat ptPerH = 3*tableH/(_hPrice - _lPrice);
    
    
    /** 天数对应的X值 */
    CGFloat ptPerW = 4*tableW/_days;
    /** 解决行高价格的值  值对应的高 */
    UIBezierPath *trendPath = [UIBezierPath bezierPath];
    
    for (NSUInteger i = 0; i < _priceTimeArr.count; i++) {
        DealsPriceHistoryModel *phModel = _priceTimeArr[i];
        x = 30 + ptPerW*[_startTime daysToDate:phModel.time];
        if (_hPrice == _lPrice) {
            y = 20 + tableH*2;
            if (i == 0) {
                [trendPath moveToPoint:CGPointMake(x, y)];
                continue;
            }
            
        } else {
            y = 4*tableH - ptPerH*(phModel.price.floatValue - _lPrice);
            if (i == 0) {
                [trendPath moveToPoint:CGPointMake(x, y)];
                continue;
            }
        }
        [trendPath addLineToPoint:CGPointMake(x, y)];
    }
    trendPath.lineWidth = 2;
    [[UIColor blueColor] setStroke];
    [trendPath stroke];
}



@end
