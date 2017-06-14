//
//  HXRefreshHeader.m
//  BeautyApp
//
//  Created by zhangming on 17/2/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "HXRefreshHeader.h"

@interface HXRefreshHeader ()

@property (weak, nonatomic) UIImageView *imageView;

@property (assign , nonatomic) BOOL isStop;

@end

@implementation HXRefreshHeader

- (void)prepare{
    
    [super prepare];
    
    self.mj_h = 60;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshClose"]];
    [self addSubview:imageView];
    self.imageView = imageView;
}

- (void)placeSubviews{
    
    [super placeSubviews];
    
    self.imageView.centerX = self.width / 2;
    self.imageView.centerY = self.height / 2;
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.isStop = NO;
            [self.imageView.layer removeAllAnimations];
            break;
        case MJRefreshStatePulling:
            
            break;
        case MJRefreshStateRefreshing:{
            self.isStop = YES;
            CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"position"];
            basic.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.width / 2, self.imageView.height / 2 + 5)];
            basic.toValue = [NSValue valueWithCGPoint:CGPointMake(self.width / 2, self.height - self.imageView.height / 2 - 5)];
            basic.duration = 0.5f;
            basic.autoreverses = YES;
            basic.repeatDuration = MAXFLOAT;
            [self.imageView.layer addAnimation:basic forKey:@"basic"];
        }
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if (self.isStop) {
        return;
    }
    NSString *imageName;
    if (pullingPercent < 0.2) {
        imageName = @"refreshOpen";
    }else if (pullingPercent >= 0.2 && pullingPercent < 0.4) {
        imageName = @"refreshClose";
    }else if (pullingPercent >= 0.4 && pullingPercent < 0.6) {
        imageName = @"refreshOpen";
    }else if (pullingPercent >= 0.6 && pullingPercent < 0.8) {
        imageName = @"refreshClose";
    }else {
        imageName = @"refreshOpen";
        if (pullingPercent > 1) {
            pullingPercent = 1;
        }
    }
    self.imageView.image = [UIImage imageNamed:imageName];
    self.imageView.transform = CGAffineTransformMakeRotation(pullingPercent * M_PI);
}

@end
