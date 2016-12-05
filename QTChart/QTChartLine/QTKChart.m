//
//  QTKChart.m
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTKChart.h"
#import "QTKChartPaintbrush.h"

@interface QTKChart ()
@property (nonatomic, strong) QTKChartPaintbrush *paintbrush;

@end

@implementation QTKChart

- (void)drawRect:(CGRect)rect {
    if (!_paintbrush) {
        _paintbrush = [QTKChartPaintbrush new];
        self.range = 100;
        self.rangeTo = self.dataSource.count;
        self.rangeFrom = self.dataSource.count - self.range;
    }
    [_paintbrush paintInChart:self];
}

@end
