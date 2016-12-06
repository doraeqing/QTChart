//
//  QTKChart.h
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTChart.h"

typedef NS_ENUM(NSUInteger, QTKChartLayoutStyle) {
    QTKChartLayoutStyleNormal = 1,
    QTKChartLayoutStyleFull = 2, //横屏模式
};

typedef NS_ENUM(NSUInteger, QTKChartLineStyle) {
    QTKChartLineStyleColumnChart = 1, //K线图
    QTKChartLineStyleDotChart = 2, //折线图
};

@interface QTKChart : QTChart

///可见区域的开始位置
@property (nonatomic, assign) NSInteger rangeFrom;
///可见区域的结束为止
@property (nonatomic, assign) NSInteger rangeTo;
///显示在可见区域的个数
@property (nonatomic, assign) NSInteger range;

///
@property (nonatomic, assign) QTKChartLineStyle chartLineStyle;

- (void)reDisplay;
@end
