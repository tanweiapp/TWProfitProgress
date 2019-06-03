//
//  KKProfit.m
//  KKProfitProgress
//
//  Created by sniffe on 16/9/23.
//  Copyright © 2016年 sniffe. All rights reserved.
//

#import "KKProfit.h"
#import "KKProfitProgress.h"
#import "KKProfitFire.h"

#define kDefaultBackGroundColor    [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1]

@interface KKProfit ()

@property (nonatomic, strong) KKProfitProgress *circleProgress;//进度
@property (nonatomic, strong) KKProfitProgress *fireProgress;//飞机路径
@property (nonatomic, strong) KKProfitFire *fire;//小飞机
@end


@implementation KKProfit


- (void)awakeFromNib{
    [super awakeFromNib];
    [self commonInit];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}



- (void)commonInit{

    self.backgroundColor = [UIColor whiteColor];
    
    KKProfitProgress *circleProgress = [[KKProfitProgress alloc]init];
    
    
    [circleProgress setStartColor:[[UIColor yellowColor] colorWithAlphaComponent:1]
                 endColor:[[UIColor orangeColor] colorWithAlphaComponent:1]];
//    circleProgress.lineWidth = 16;
    circleProgress.progressBackgroudColor = kDefaultBackGroundColor;
    self.circleProgress = circleProgress;
    
    KKProfitProgress *fireProgress = [[KKProfitProgress alloc]init];
    [fireProgress setStartColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]
                 endColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]];
    fireProgress.lineWidth = 4;
    self.fireProgress = fireProgress;
    
    UIImage *fireImage = [UIImage imageNamed:@"rocket"];
    KKProfitFire *fire = [[KKProfitFire alloc]initWithFrame:CGRectMake(0, 0, fireImage.size.width * 0.5, fireImage.size.height * 0.5)];
    fire.backgroundColor = [UIColor clearColor];
    fire.image = fireImage;
    self.fire = fire;
    
    
    [self addSubview:circleProgress];
    [self addSubview:fireProgress];
    [self addSubview:fire];
    
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.circleProgress.progress = progress;
    self.fireProgress.progress = progress;
    self.fire.progress = progress;
}
- (void)setProgressBackgroundColor:(UIColor *)progressBackgroundColor{
    _progressBackgroundColor = progressBackgroundColor;
    self.circleProgress.progressBackgroudColor = progressBackgroundColor;
}

- (void)drawRect:(CGRect)rect {
    
    
    UIColor *progressBackgroundColor = self.progressBackgroundColor ?:kDefaultBackGroundColor;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    [progressBackgroundColor set];
    
    
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - 10 - 20- 5 - 10;

    CGContextAddArc(ctx, xCenter, yCenter, radius, 0, M_PI * 2, 0);
    CGContextStrokePath(ctx);


    self.fireProgress.frame = rect;

    CGRect circleFrame = [self rect:rect haveGap:20];
    self.circleProgress.frame = circleFrame;

    
    CGRect fireTrackFrame = [self rect:rect haveGap:self.fireProgress.lineWidth * 0.5];
    self.fire.trackFrame = fireTrackFrame;
    
}


- (CGRect)rect:(CGRect)rect haveGap:(CGFloat)gap{
    CGRect newRect = rect;
    newRect.origin.x += gap;
    newRect.origin.y += gap;
    newRect.size.width -= gap * 2;
    newRect.size.height -= gap * 2;
    return newRect;
}

@end
