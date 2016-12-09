//
//  QTKChart.m
//  QTChart
//
//  Created by lq9869 on 2016/12/2.
//  Copyright © 2016年 lq9869. All rights reserved.
//

#import "QTKChart.h"
#import "QTKChartPaintbrush.h"

@interface QTKChart () <UIGestureRecognizerDelegate>
{
    CGFloat _finalX;
}
@property (nonatomic, strong) QTKChartPaintbrush *paintbrush;

@end

@implementation QTKChart

#pragma mark - life circle 
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
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    
    _horizontalLineCount = 5;
    _verticalLineCount = 5;
    _chartLineStyle = QTKChartLineStyleColumnChart;
    _columnStyle = QTKChartColumnStyleHollow;
    _upColor = [UIColor redColor];
    _downColor = [UIColor greenColor];
    _lineColor = [UIColor grayColor];
    _arealineWidth = 0.3f;
    _brokenLineWidth = 0.5f;
    _brokenLineColor = [UIColor orangeColor];
    _yFont = [UIFont systemFontOfSize:9.0];
    _yPirceColor = [UIColor grayColor];
    _yPirceDecimalCount = 2;
}

- (void)drawRect:(CGRect)rect {
    if (!_paintbrush) {
        _paintbrush = [QTKChartPaintbrush new];
        self.range = 50;
        self.rangeTo = self.dataSource.count;
        self.rangeFrom = self.dataSource.count - self.range;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
    }
    [_paintbrush paintInChart:self];
}

#pragma mark - action
- (void)pinchAction:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = sender.scale;
    CGFloat velocity = sender.velocity;//力度
    if (fabs(velocity) < 0.1) return;
    if (scale > 1) { //放大
        self.rangeFrom += 2;
        self.rangeTo -= 2;
        self.range = self.rangeTo - self.rangeFrom;
        if (self.range <= 50) {
            self.range = 50;
        }
    } else { //缩小
        
    }
    [self setNeedsDisplay];
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    CGPoint velocity = [sender velocityInView:self];
    CGFloat interval = fabs(velocity.x) / self.range;
    if (interval > 3) {
        interval = 3;
    }
    if (translation.x > 0) { //单指 右移 查看以前数据
        self.rangeFrom -= interval;
        if (self.rangeFrom < 0) {
            self.rangeFrom = 0;
        }
        self.rangeTo = self.rangeFrom + self.range;
        
    } else { //单指 左移
        self.rangeTo += interval;
        if (self.rangeTo > self.dataSource.count) {
            self.rangeTo = self.dataSource.count;
        }
        self.rangeFrom = self.rangeTo - self.range;
    }
    [self setNeedsDisplay];
    ///
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        CGFloat magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y));
//        CGFloat slideMult = magnitude / 200.0;
//        CGFloat slideFactor = 0.1 * slideMult;
//        _finalX =  velocity.x * slideFactor;
//        
//        StepAnimationHelper *helper = [[StepAnimationHelper alloc] initWithDuration:1];
//        helper.curveFunnction = AnimationCurveEaseOut;
//        [helper setStepCallback:^(double state) {
//            
//            _finalX = _finalX * state;
//            NSLog(@"%f",_finalX);
//            CGFloat interval = fabs(_finalX) / self.range;
//            if (interval > 4) {
//                interval = 4;
//            }
//            self.rangeFrom -= interval;
//            if (self.rangeFrom < 0) {
//                self.rangeFrom = 0;
//            }
//            self.rangeTo = self.rangeFrom + self.range;
//            [self setNeedsDisplay];
//        }];
//        [helper startAnimation];
//        
////        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(display:)];
////        displayLink.frameInterval = 1;
////        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    }
    [sender setTranslation:CGPointZero inView:self];
}

- (void)display:(CADisplayLink *)sender {
    if (_finalX <= 1) {
        [sender invalidate];
    } else {
        CGFloat interval = fabs(_finalX) / self.range;
        if (interval > 4) {
            interval = 4;
        }
        self.rangeFrom -= interval;
        if (self.rangeFrom < 0) {
            self.rangeFrom = 0;
        }
        self.rangeTo = self.rangeFrom + self.range;
        [self setNeedsDisplay];
    }
    CGFloat ration =  _finalX / 5;
    _finalX -= ration;
}

#pragma mark - public
- (void)reDisplay {
    [self setNeedsDisplay];
}

@end
