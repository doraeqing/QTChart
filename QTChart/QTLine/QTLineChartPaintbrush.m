//
//  QTLineChartPaintbrush.m
//  QTChart
//
//  Created by lq9869 on 2016/12/7.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTLineChartPaintbrush.h"
#import "QTLineChart.h"
#import "QTLineChartData.h"

CGFloat const kRectReduce = 8.0;

@interface QTLineChartPaintbrush ()
{
    CGFloat _maxValue, _minValue, _yRatio;
    CGRect _paintRect;
}

@property (nonatomic, strong) QTLineChart *lineChart;
@property (nonatomic, strong) NSArray *lineChartDatas;
@end

@implementation QTLineChartPaintbrush

- (void)paintInChart:(__kindof QTChart *)chart {
    _lineChart = chart;
    _lineChartDatas = _lineChart.dataSource;
    _maxValue = [[_lineChartDatas[_lineChart.rangeFrom] lineValue] doubleValue];
    _minValue = _maxValue;
    for (NSInteger i = _lineChart.rangeFrom; i < _lineChart.rangeTo; i ++) {
        QTLineChartData *data = _lineChartDatas[i];
        _maxValue = MAX(_maxValue, data.lineValue.doubleValue);
        _minValue = MIN(_minValue, data.lineValue.doubleValue);
    }
    _paintRect = CGRectMake(kRectReduce,
                            kRectReduce,
                            CGRectGetWidth(_lineChart.frame) - 2*kRectReduce,
                            CGRectGetHeight(_lineChart.frame) - 2*kRectReduce);
    _yRatio = (_maxValue - _minValue) / CGRectGetHeight(_paintRect);
    [self drawLine];
}

- (void)drawLine {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat dotDistance = CGRectGetWidth(_paintRect) / _lineChart.range;
    CGPoint linePoints[_lineChart.range];
    for (NSInteger i = _lineChart.rangeFrom; i < _lineChart.rangeTo; i ++) {
        QTLineChartData *data = _lineChartDatas[i];
        CGFloat circleX = _paintRect.origin.x + dotDistance * (i - _lineChart.rangeFrom);
        CGFloat circleY = _paintRect.origin.y + (_maxValue - data.lineValue.doubleValue) / _yRatio;
        CGPoint point = CGPointMake(circleX, circleY);
        linePoints[i - _lineChart.rangeFrom] = point;
        
        CGContextAddArc(context, circleX, circleY, 4, 0, 2 * M_PI, 0);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextStrokePath(context);
        
    }
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetAlpha(context, 0.7);
    CGContextAddLines(context, linePoints, _lineChart.range);
    CGContextStrokePath(context);
}

@end
