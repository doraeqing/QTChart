//
//  QTKChartModel.m
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTKChartModel.h"

@implementation QTKChartModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _openPrice          = [dic objectForKey:@"open_price"];
        _maxPrice           = [dic objectForKey:@"high"];
        _minPrice           = [dic objectForKey:@"low"];
        _closePrice         = [dic objectForKey:@"close"];
        _amount             = [dic objectForKey:@"vol"];
        _dateTime           = [dic objectForKey:@"time"];
    }
    return self;
}

- (NSArray<QTKChartModel *> *)kLineDatas {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KChartData" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrModels = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL*stop) {
        QTKChartModel *model = [[QTKChartModel alloc] initWithDic:obj];
        [arrModels addObject:model];
    }];
    return arrModels.copy;
    
}

@end
