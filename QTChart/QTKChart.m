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
    }
    [_paintbrush paintInChart:self];
}

@end
