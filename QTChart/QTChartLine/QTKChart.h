//
//  QTKChart.h
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTChart.h"

typedef NS_ENUM(NSUInteger, QTKChartLayoutStyle) {
    QTKChartLayoutStyleNormal = 1,
    QTKChartLayoutStyleFull = 2, //横屏模式
};

typedef NS_ENUM(NSUInteger, QTKChartLineStyle) {
    QTKChartLineStyleColumnChart = 1, //K线图
    QTKChartLineStyleBrokenChart = 2, //折线图
};

typedef NS_ENUM(NSUInteger, QTKChartColumnStyle) {
    QTKChartColumnStyleHollow = 1, //柱子空心
    QTKChartColumnStyleSolid = 2, //柱子实心
};

@interface QTKChart : QTChart

///可见区域的开始位置
@property (nonatomic) NSInteger rangeFrom;
///可见区域的结束位置
@property (nonatomic) NSInteger rangeTo;
///显示在可见区域的个数
@property (nonatomic) NSInteger range;

///线条的形状 折线图 K线图 默认是K线图
@property (nonatomic) QTKChartLineStyle chartLineStyle;
///K线图形状下 柱子的形状 实心或者空心 默认是空心
@property (nonatomic) QTKChartColumnStyle columnStyle;
///竖屏或者横屏 默认是竖屏
@property (nonatomic) QTKChartLayoutStyle layoutStyle;
///topLeft绘制区域
@property (nonatomic) CGRect topLeftArea;
@property (nonatomic) UIEdgeInsets topLeftDrawInset;
///topRight绘制区域
@property (nonatomic) CGRect topRightArea;

///水平线条个数
@property (nonatomic)IBInspectable NSInteger horizontalLineCount;
///垂直线条个数
@property (nonatomic)IBInspectable NSInteger verticalLineCount;
///涨的颜色
@property (nonatomic, strong)IBInspectable UIColor *upColor;
///跌的颜色
@property (nonatomic, strong)IBInspectable UIColor *downColor;
///背景区域线条的颜色
@property (nonatomic, strong)IBInspectable UIColor *lineColor;
///背景区域线条的宽度
@property (nonatomic, assign)IBInspectable CGFloat arealineWidth;
///broken line width
@property (nonatomic, assign)IBInspectable CGFloat brokenLineWidth;
@property (nonatomic, strong)IBInspectable UIColor *brokenLineColor;

///y轴价格字体
@property (nonatomic, strong) UIFont *yFont;
///y轴价格颜色
@property (nonatomic, strong) UIColor *yPirceColor;
///y轴 价格小数点位置
@property (nonatomic) NSInteger yPirceDecimalCount;

///重绘
- (void)reDisplay;
@end
