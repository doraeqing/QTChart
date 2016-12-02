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

@interface QTKChartPaintbrush ()
{
    double _maxPrice, _minPirce, _yRatio;
    CGRect _topArea;
    NSInteger _range;
}

@property (nonatomic, strong) QTKChart *KChart;
@property (nonatomic, strong) NSArray <QTKChartModel *> *dataSource;

@end

@implementation QTKChartPaintbrush

- (void)paintInChart:(__kindof QTChart *)chart {
    self.KChart = chart;
    self.dataSource = chart.dataSource;
    _maxPrice = self.dataSource.firstObject.maxPrice.doubleValue;
    _minPirce = self.dataSource.firstObject.minPrice.doubleValue;
    
    [self.dataSource enumerateObjectsUsingBlock:^(QTKChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _maxPrice = MAX(_maxPrice, obj.maxPrice.doubleValue);
        _minPirce = MIN(_minPirce, obj.minPrice.doubleValue);
    }];
    _topArea = CGRectMake(0,
                          0,
                          CGRectGetWidth(self.KChart.frame),
                          CGRectGetHeight(self.KChart.frame));
    _yRatio = (_maxPrice - _minPirce) / CGRectGetHeight(_topArea);
    _range = 100;//一页展示多少
    [self drawArea];
    [self drawDotLine];
}

- (void)drawArea {
    CGRect area = CGRectMake(0,
                             0,
                             CGRectGetWidth(self.KChart.frame),
                             CGRectGetHeight(self.KChart.frame));
    UIColor *lineColor = [UIColor orangeColor];
    //绘制区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, area);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextStrokePath(context);
    
    //绘制水平线条
    NSInteger ycount = 5;
    CGFloat areaH = CGRectGetHeight(area);
    CGFloat lineSpace = areaH / (ycount + 1);
    
    CGFloat lineSX = area.origin.x; //线条开始X
    CGFloat lineEX = CGRectGetMaxX(area);
    
    for (int i = 0; i < ycount; i ++) {
        CGFloat sy = (i + 1) * lineSpace;
        CGFloat ey = sy;
        
        CGContextMoveToPoint(context, lineSX, sy);
        CGContextAddLineToPoint(context, lineEX, ey);
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextStrokePath(context);
    }
}

- (void)drawDotLine {
    CGContextRef context = UIGraphicsGetCurrentContext();
    double dotSpace = CGRectGetWidth(_topArea)/_range;
    CGPoint linePoints[_range];
    NSInteger startIndex = self.dataSource.count - _range;
    for (NSInteger i = startIndex; i < self.dataSource.count; i++) {
        QTKChartModel *model = self.dataSource[i];
        CGPoint point = CGPointMake(_topArea.origin.x + (i - startIndex) * dotSpace, _topArea.origin.y + (_maxPrice - model.closePrice.doubleValue)/_yRatio);
        linePoints[i] = point;
    }
    CGContextBeginPath(context);
    CGContextAddLines(context, linePoints, _range);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetShouldAntialias(context, YES);
    CGContextStrokePath(context);
}

@end
