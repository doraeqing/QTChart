//
//  QTChartPaintbrush.h
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QTChart;

@interface QTChartPaintbrush : NSObject

- (void)paintInChart:(__kindof QTChart *)chart;

@end
