//
//  ViewController.m
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "ViewController.h"
#import "QTKChart.h"
#import "QTKChartModel.h"
#import "QTLineChart.h"
#import "QTLineChartData.h"

@interface ViewController ()
@property (nonatomic, strong) QTKChart *KChart;
@property (nonatomic, strong) QTLineChart *lineChart;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedCtrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //K线图
    self.KChart = [[QTKChart alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    self.KChart.chartLineStyle = QTKChartLineStyleColumnChart;
    NSArray *array = [QTKChartModel kLineDatas];
    self.KChart.dataSource = array;
    [self.view addSubview:self.KChart];
    
    //折线图
    _lineChart = [[QTLineChart alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 300)];
    _lineChart.alpha = 0.0;
    //test data
    NSArray *array1 = @[@"25",@"26",@"12",@"19",@"56"];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < array1.count; i ++) {
        QTLineChartData *data = [[QTLineChartData alloc] init];
        data.lineValue = array1[i];
        [arr addObject:data];
    }
    _lineChart.dataSource = arr;
    [self.view addSubview:_lineChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)disp:(id)sender {
    [self.KChart reDisplay];
}
- (IBAction)didSegmetedCtrl:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.KChart.chartLineStyle = QTKChartLineStyleColumnChart;
            _lineChart.alpha = 0.0;
            break;
        case 1:
            self.KChart.chartLineStyle = QTKChartLineStyleBrokenChart;
            _lineChart.alpha = 0.0;
            break;
        case 2:
        {
            [UIView animateWithDuration:0.2 animations:^{_lineChart.alpha = 1.0;}];
        }
            break;
        default:
            break;
    }
    [self.KChart reDisplay];
}

@end
