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

@interface ViewController ()
@property (nonatomic, strong) QTKChart *KChart;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedCtrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.KChart = [[QTKChart alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    self.KChart.chartLineStyle = QTKChartLineStyleColumnChart;
    NSArray *array = [QTKChartModel kLineDatas];
    self.KChart.dataSource = array;
    [self.view addSubview:self.KChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)disp:(id)sender {
    [self.KChart reDisplay];
}
- (IBAction)didSegmetedCtrl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) { //k
        self.KChart.chartLineStyle = QTKChartLineStyleColumnChart;
    } else {//dot
        self.KChart.chartLineStyle = QTKChartLineStyleDotChart;
    }
    [self.KChart reDisplay];
}

@end
