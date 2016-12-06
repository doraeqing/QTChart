//
//  QTKChartPaintbrush.m
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTKChartPaintbrush.h"
#import "QTKChart.h"
#import "QTKChartModel.h"

CGFloat const kChartReduce = 16.0;

@interface QTKChartPaintbrush ()
{
    double _maxPrice, _minPirce, _yRatio;
    CGRect _topArea, _topBackGroudArea;
}

@property (nonatomic, strong) QTKChart *KChart;
@property (nonatomic, strong) NSArray <QTKChartModel *> *dataSource;

@end

@implementation QTKChartPaintbrush

- (void)paintInChart:(__kindof QTChart *)chart {
    self.KChart = chart;
    self.dataSource = chart.dataSource;
    _maxPrice = [[self.dataSource[self.KChart.rangeFrom] maxPrice] doubleValue];
    _minPirce = [[self.dataSource[self.KChart.rangeFrom] minPrice] doubleValue];
    
    for (NSInteger i = self.KChart.rangeFrom; i < self.KChart.rangeTo; ++i) {
        QTKChartModel *model = self.dataSource[i];
        _maxPrice = MAX(_maxPrice, model.maxPrice.doubleValue);
        _minPirce = MIN(_minPirce, model.minPrice.doubleValue);
    }
    _topBackGroudArea = CGRectMake(0,
                                   0,
                                   CGRectGetWidth(self.KChart.frame),
                                   CGRectGetHeight(self.KChart.frame));
    _topArea = CGRectMake(0,
                          kChartReduce,
                          CGRectGetWidth(self.KChart.frame),
                          CGRectGetHeight(self.KChart.frame) - 2 * kChartReduce);
    _yRatio = (_maxPrice - _minPirce) / CGRectGetHeight(_topArea);
    //开始绘制
    [self drawArea];
    if (self.KChart.chartLineStyle == QTKChartLineStyleColumnChart) {
        [self drawColumnChart];
    } else {
        [self drawDotLine];
    }
}

#pragma mark - draw
- (void)drawArea {
    UIColor *lineColor = [UIColor orangeColor];
    //绘制区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, _topBackGroudArea);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextStrokePath(context);
    
    //绘制水平线条
    NSInteger ycount = 5;
    CGFloat areaH = CGRectGetHeight(_topBackGroudArea);
    CGFloat lineSpace = areaH / (ycount + 1);
    
    CGFloat lineSX = _topBackGroudArea.origin.x; //线条开始X
    CGFloat lineEX = CGRectGetMaxX(_topBackGroudArea);
    
    for (int i = 0; i < ycount; i ++) {
        CGFloat sy = (i + 1) * lineSpace;
        CGFloat ey = sy;
        CGContextMoveToPoint(context, lineSX, sy);
        CGContextAddLineToPoint(context, lineEX, ey);
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextStrokePath(context);
    }
}

- (void)drawColumnChart {
    CGContextRef context = UIGraphicsGetCurrentContext();
    double columnW = (CGRectGetWidth(_topArea) - (2 * (self.KChart.range - 1))) / self.KChart.range;
    for (NSInteger i = self.KChart.rangeFrom; i < self.KChart.rangeTo; i++) {
        QTKChartModel *model = self.dataSource[i];
        double offsetPrice = model.closePrice.doubleValue - model.openPrice.doubleValue;
        double columnH = fabs(offsetPrice) / _yRatio;
        double columnSX = _topArea.origin.x + (columnW + 2) * (i - self.KChart.rangeFrom);
        double columnSY = 0.00;
        UIColor *columnColor = nil;
        if (offsetPrice >= 0) { //涨
            columnSY = _topArea.origin.y + (_maxPrice - model.closePrice.doubleValue) / _yRatio;
            columnColor = [UIColor redColor];
        } else {
            columnSY = _topArea.origin.y + (_maxPrice - model.openPrice.doubleValue) / _yRatio;
            columnColor = [UIColor greenColor];
        }
        //空心柱子
        CGContextSetStrokeColorWithColor(context, columnColor.CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGContextAddRect(context, CGRectMake(columnSX, columnSY, columnW, columnH));
        CGContextStrokePath(context);
        //顶部线
        CGContextSetStrokeColorWithColor(context, columnColor.CGColor);
        CGFloat topLineX = columnSX + columnW / 2;
        CGFloat topLineSY = _topArea.origin.y + (_maxPrice - model.maxPrice.doubleValue) / _yRatio;
        CGContextMoveToPoint(context, topLineX, topLineSY);
        CGContextAddLineToPoint(context, topLineX, columnSY);
        CGContextStrokePath(context);
        //底部线
        CGFloat bottomX = topLineX;
        CGFloat bottomSY = columnSY + columnH;
        CGFloat bottomEY = _topArea.origin.y + (_maxPrice - model.minPrice.doubleValue) / _yRatio;
        CGContextMoveToPoint(context, bottomX, bottomSY);
        CGContextAddLineToPoint(context, bottomX, bottomEY);
        
    }
}

- (void)drawDotLine {
    CGContextRef context = UIGraphicsGetCurrentContext();
    double dotSpace = CGRectGetWidth(_topArea)/self.KChart.range;
    CGPoint linePoints[self.KChart.range];
    for (NSInteger i = self.KChart.rangeFrom; i < self.KChart.rangeTo; i++) {
        QTKChartModel *model = self.dataSource[i];
        CGPoint point = CGPointMake(_topArea.origin.x + (i - self.KChart.rangeFrom) * dotSpace,
                                    _topArea.origin.y + (_maxPrice - model.closePrice.doubleValue)/_yRatio);
        linePoints[i-self.KChart.rangeFrom] = point;
    }
    CGContextBeginPath(context);
    CGContextAddLines(context, linePoints, self.KChart.range);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetShouldAntialias(context, YES);
    CGContextStrokePath(context);
}

@end
