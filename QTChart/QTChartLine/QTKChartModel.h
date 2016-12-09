//
//  QTKChartModel.h
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTChartData.h"

@interface QTKChartModel : QTChartData
@property (nonatomic, strong) NSString *openPrice;
@property (nonatomic, strong) NSString *maxPrice;
@property (nonatomic, strong) NSString *minPrice;
@property (nonatomic, strong) NSString *closePrice;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *dateTime;

///MA
@property (nonatomic, strong) NSString *MA5Price;
@property (nonatomic, strong) NSString *MA10Price;
@property (nonatomic, strong) NSString *MA20Price;

///MACD
@property (nonatomic, strong) NSString *EMA12;
@property (nonatomic, strong) NSString *EMA26;
@property (nonatomic, strong) NSString *DIF;
@property (nonatomic, strong) NSString *DEA;
@property (nonatomic, strong) NSString *BAR;

///RSI
@property (nonatomic, strong) NSString *RSI6;
@property (nonatomic, strong) NSString *RSI12;
@property (nonatomic, strong) NSString *RSI24;

///KDJ
@property (nonatomic, strong) NSString *KDJ_K;
@property (nonatomic, strong) NSString *KDJ_D;
@property (nonatomic, strong) NSString *KDJ_J;

+ (NSArray <QTKChartModel *> *)kLineDatas;

@end
