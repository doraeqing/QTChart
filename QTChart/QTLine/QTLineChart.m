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

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRed:225/255 green:1 blue:1 alpha:1];
}

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
