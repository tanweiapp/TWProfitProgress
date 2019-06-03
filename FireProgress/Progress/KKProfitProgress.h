//
//  KKProfitProgress.h
//  KKProfitProgress
//
//  Created by sniffe on 16/9/23.
//  Copyright © 2016年 sniffe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKProfitProgress : UIView


@property (nonatomic, assign ,readwrite) CGFloat progress;//进度

@property (nonatomic, assign ,readwrite) CGFloat lineWidth;//线宽

@property (nonatomic, strong ,readwrite) UIColor *progressBackgroudColor;//线的背景色。不设置将没有背景色

@property (nonatomic, assign ,readonly) CGPoint centerPoint;//物理中心。只读

@property (nonatomic, assign ,readonly) CGFloat radius;//物理半径。只读


//设置渐变的起始色 和 终止色彩。
- (void)setStartColor:(UIColor*)startColor endColor:(UIColor*)endColor;

@end
