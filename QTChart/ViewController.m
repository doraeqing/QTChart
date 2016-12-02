//
//  ViewController.m
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "ViewController.h"
#import "QTKChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    QTKChart *kchart = [[QTKChart alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    [self.view addSubview:kchart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
