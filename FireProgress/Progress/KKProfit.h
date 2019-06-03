//
//  KKProfit.h
//  KKProfitProgress
//
//  Created by sniffe on 16/9/23.
//  Copyright © 2016年 sniffe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKProfit : UIView


@property (nonatomic, strong) UIColor *progressBackgroundColor;

@property (nonatomic, assign) CGFloat progress;


- (instancetype)initWithFrame:(CGRect)frame;

@end
