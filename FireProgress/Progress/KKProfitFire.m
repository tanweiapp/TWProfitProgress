//
//  KKProfitFire.m
//  KKProfitProgress
//
//  Created by sniffe on 16/9/23.
//  Copyright © 2016年 sniffe. All rights reserved.
//

#import "KKProfitFire.h"

@implementation KKProfitFire

- (void)setTrackFrame:(CGRect)trackFrame{
    _trackFrame = trackFrame;
    self.progress = 0;
}

- (void)setProgress:(CGFloat)progress{
    
//    CGFloat oldProgress = _progress;
//    double oldAngle = 2 * M_PI * oldProgress;
    
    _progress = progress;
    
    CGFloat radius = self.trackFrame.size.height > self.trackFrame.size.width ? self.trackFrame.size.width/2 -8 : self.trackFrame.size.height/2-8;

    CGPoint centerPoint = CGPointMake(self.trackFrame.size.width/2, self.trackFrame.size.height/2);
    double angle = 2 * M_PI * progress;
    
    [self.layer removeAllAnimations];
    
    CGFloat fireCenterX = centerPoint.x + radius * sin(angle);
    CGFloat fireCenterY = centerPoint.y - radius * cos(angle);
    
    //旋转飞机
    self.transform = CGAffineTransformMakeRotation(angle);
    self.center = CGPointMake(fireCenterX, fireCenterY);
    
    
    ///关键帧动画
//    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    
//    CGMutablePathRef trackPath = CGPathCreateMutable();
//    CGFloat fireCenterX = centerPoint.x + radius * sin(oldProgress);
//    CGFloat fireCenterY = centerPoint.y - radius * cos(oldProgress);
//    CGPathMoveToPoint(trackPath, NULL, fireCenterX, fireCenterY);
//   
//    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, -M_PI_2 + oldAngle, -M_PI_2 + angle, YES);
//    
//    bounceAnimation.path = trackPath;
//    bounceAnimation.duration = 0.009;
//    bounceAnimation.speed = 1;
//    [self.layer addAnimation:bounceAnimation forKey:@"move"];
//    
//  
//    CGFloat newFireCenterX = centerPoint.x + radius * sin(angle);
//    CGFloat newFireCenterY = centerPoint.y - radius * cos(angle);
//    self.center = CGPointMake(newFireCenterX, newFireCenterY);
//    self.transform = CGAffineTransformMakeRotation(angle);
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
