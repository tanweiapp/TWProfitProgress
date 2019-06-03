//
//  ViewController.m
//  FireProgress
//
//  Created by 耐克了解了 on 3/6/2019.
//  Copyright © 2019 耐克了解了. All rights reserved.
//

#import "ViewController.h"
#import "KKProfit.h"

@interface ViewController ()

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong)  KKProfit *profit;

@property (nonatomic,assign) CGFloat progress;

@property (nonatomic,assign) double prence;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profit = [[KKProfit alloc]initWithFrame:CGRectMake(50, 100, 300, 300)];
    [self.view addSubview:self.profit];
    self.prence = 0.75;
    [self loadData];
}


- (void)loadData
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(action:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    if (self.profit.progress <= 0) {
        self.profit.progress = 0;
        self.progress = 0.005;
    }
}

- (void)action:(id)sender{
    if (self.profit.progress < 1.0) {
        if (self.progress < 0.5) {//最高速度为0.5
            self.progress += 0.001;//加速因子。每秒加速0.02
        }
        //        progress += 0.001;//加速因子。每秒加速0.02
        self.profit.progress += self.progress;
        if (self.profit.progress >= self.prence) {
            self.profit.progress = self.prence;
            [self.timer invalidate];
            self.timer = nil;
        }
    }else{
        self.profit.progress = 1.0;
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

@end
