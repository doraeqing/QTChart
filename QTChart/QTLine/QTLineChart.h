//
//  QTLineChart.h
//  QTChart
//
//  Created by lq9869 on 2016/12/7.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTChart.h"
#import "QTLineChartDataProtocol.h"

struct QTLineChartRange {
    NSInteger range;
    NSInteger rangeFrom;
    NSInteger rangeTo;
};

typedef struct QTLineChartRange QTLineChartRange;

@interface QTLineChart : QTChart

/// 可见区域显示的个数
@property (nonatomic, assign) NSInteger range;
/// 可见区域的结束位置
@property (nonatomic, assign) NSInteger rangeTo;
/// 可见区域的开始位置
@property (nonatomic, assign) NSInteger rangeFrom;

@property (nonatomic, assign) QTLineChartRange lineChartRange;

@end


@protocol QTLineChartDataSource <NSObject>

/// 
- (NSInteger)numOfPointsInLineChart:(QTLineChart *)lineChart;

- (id <QTLineChartDataProtocol>)valueForPointAtIndex:(NSInteger)index;

@end
