//
//  QTLineChart.m
//  QTChart
//
//  Created by lq9869 on 2016/12/7.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTLineChart.h"
#import "QTLineChartPaintbrush.h"

@interface QTLineChart ()
@property (nonatomic, strong) QTLineChartPaintbrush *lineChartPaintbrush;
@end

@implementation QTLineChart

- (void)drawRect:(CGRect)rect {
    if (!_lineChartPaintbrush) {
        _lineChartPaintbrush = [QTLineChartPaintbrush new];
        self.range = 5;
        if (self.range > self.dataSource.count) {
            self.range = self.dataSource.count;
        }
        self.rangeTo = self.dataSource.count;
        self.rangeFrom = self.rangeTo - self.range;
        [_lineChartPaintbrush paintInChart:self];
    }
}

@end
