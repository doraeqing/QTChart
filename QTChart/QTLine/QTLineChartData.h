//
//  QTLineChartData.h
//  QTChart
//
//  Created by lq9869 on 2016/12/7.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTChartData.h"
#import "QTLineChartDataProtocol.h"

@interface QTLineChartData : QTChartData <QTLineChartDataProtocol>
@property (nonatomic, copy) NSString *lineValue;
@end
