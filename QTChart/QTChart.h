//
//  QTChart.h
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTChartDataProtocol.h"
@class QTChartData;

@protocol QTChartDataSource;

@interface QTChart : UIView

@property (nonatomic, strong) NSArray <__kindof QTChartData *> *dataSource;

@end

@protocol QTChartDataSource <NSObject>


@end
