//
//  KKProfitProgress.m
//  KKProfitProgress
//
//  Created by sniffe on 16/9/23.
//  Copyright © 2016年 sniffe. All rights reserved.
//

#import "KKProfitProgress.h"

@interface KKProfitProgress ()

@property (nonatomic, assign ,readwrite) CGPoint centerPoint;
@property (nonatomic, assign ,readwrite) CGFloat radius;


@property (nonatomic, assign) CGRect gradientRect1,gradientRect2;

@property (nonatomic, strong) CAGradientLayer * gradientLayer1,*gradientLayer2;

@property (nonatomic, strong) CALayer * mergeGradientLayer;

@property (nonatomic, strong) CAShapeLayer * shapelayer;

@property (nonatomic, strong) NSArray * array1,*array2;

@property (nonatomic, strong) UIBezierPath * apath;

@end


@implementation KKProfitProgress


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    self.backgroundColor = [UIColor clearColor];
    
    //设置默认线宽
    self.lineWidth = 16;
    
    //渐变layer
    self.gradientLayer1 = [CAGradientLayer layer];
    self.gradientLayer2 = [CAGradientLayer layer];
    
    //渐变范围
    self.gradientLayer1.startPoint = CGPointMake(0, 0);
    self.gradientLayer1.endPoint = CGPointMake(0, 1);
    self.gradientLayer2.startPoint = CGPointMake(0, 0);
    self.gradientLayer2.endPoint = CGPointMake(0, 1);
    
    //设置默认颜色
    [self setStartColor:[UIColor orangeColor] endColor:[UIColor yellowColor]];
    
    //合并渐变layer
    self.mergeGradientLayer = [CALayer layer];
    [self.mergeGradientLayer insertSublayer:self.gradientLayer1 atIndex:0];
    [self.mergeGradientLayer insertSublayer:self.gradientLayer2 atIndex:0];
    
    //使用shapelayer截取颜色渐变的层
    self.shapelayer = [CAShapeLayer layer];
    
    self.shapelayer.fillColor = [UIColor clearColor].CGColor;
    self.shapelayer.strokeColor = [UIColor orangeColor].CGColor;
    self.shapelayer.backgroundColor = [UIColor clearColor].CGColor;
    self.shapelayer.lineJoin = kCALineJoinRound;
    self.shapelayer.lineCap = kCALineJoinRound;
    self.shapelayer.frame = CGRectZero;

}
- (void)setStartColor:(UIColor*)startColor endColor:(UIColor*)endColor{
    
    self.array1 = [NSArray arrayWithObjects:(id)[startColor CGColor],(id)[endColor CGColor], nil];
    self.gradientLayer1.colors = self.array1;
    
    self.array2 = [NSArray arrayWithObjects:(id)[startColor CGColor],(id)[endColor CGColor], nil];
    self.gradientLayer2.colors = self.array2;
}


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self progressDidChange];
}

- (void)progressDidChange{

    CGFloat progress = 0.001;
    if (self.progress > progress) progress = self.progress;
    
    //使用strokeEnd表示进度
    self.shapelayer.strokeEnd = progress;
    
}

- (void)initDataWithRect:(CGRect)rect{
  
    
    self.radius = (rect.size.height > rect.size.width ? rect.size.width/2 : rect.size.height/2) -  5 ;
    NSLog(@"radius===:%f",self.radius);
    
    self.centerPoint = CGPointMake(rect.size.width/2, (rect.size.height/2) );
    
    
    self.gradientRect1 = CGRectMake(rect.size.width/2 - self.radius - self.lineWidth/2, rect.size.height/2 - self.radius - self.lineWidth/2, self.radius + self.lineWidth/2, 2*self.radius + self.lineWidth);
    self.gradientRect2 = CGRectMake(rect.size.width/2, rect.size.height/2 - self.radius - self.lineWidth/2, self.radius + self.lineWidth/2, 2*self.radius + self.lineWidth);
    
    
    self.gradientLayer1.frame = self.gradientRect1;
    self.gradientLayer2.frame = self.gradientRect2;
    
    
    self.mergeGradientLayer.frame = rect;
    self.shapelayer.frame = rect;
    self.shapelayer.lineWidth = self.lineWidth;
    self.shapelayer.duration = 0.0;//default it's not zero;
    
    
    self.apath = [UIBezierPath bezierPath];
    CGFloat startAngleOffset = 0;//self.lineWidth / self.radius;
    [self.apath addArcWithCenter:self.centerPoint radius:self.radius-2 startAngle:-M_PI_2 + startAngleOffset endAngle:M_PI_2*3 + startAngleOffset clockwise:YES];
    self.shapelayer.path = self.apath.CGPath;
    
    
    //设置图层蒙版
    [self.mergeGradientLayer setMask:self.shapelayer];
    
    
    [self.layer addSublayer:self.mergeGradientLayer];

    
    [self progressDidChange];
    
}

- (void)drawRect:(CGRect)rect {
    
    [self initDataWithRect:rect];
    
    
    //当有背景色的时候。绘制背景色环
    if (self.progressBackgroudColor) {
        
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGFloat xCenter = self.centerPoint.x;
        CGFloat yCenter = self.centerPoint.y;
        [self.progressBackgroudColor set];
        
        
        CGContextSetLineWidth(ctx, self.lineWidth );
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextAddArc(ctx, xCenter, yCenter, self.radius -3, 0, M_PI * 2, 0);
        CGContextStrokePath(ctx);
    }
 
}
///颜色混合
- (UIColor *)mixColor1:(UIColor*)color1 color2:(UIColor*)color2 ratio:(CGFloat)ratio{
    if(ratio > 1)
        ratio = 1;
    
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
    
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
