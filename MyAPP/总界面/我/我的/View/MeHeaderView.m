//
//  MeHeaderView.m
//  BeautyApp
//
//  Created by zhangming on 17/1/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "MeHeaderView.h"

@interface MeHeaderView()



@end

@implementation MeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = NAVBARCOLOR;
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.backgroundColor = NAVBARCOLOR;
    [self addSubview:bgView];
    self.bgView = bgView;
    
    
    UIImageView *headIm = [[UIImageView alloc] init];
    [headIm setBackgroundColor:[UIColor blueColor]];
    headIm.image = [UIImage imageNamed:@"myHeader_hsq"];
    headIm.layer.cornerRadius = 35;
    headIm.layer.masksToBounds = YES;
    headIm.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:headIm];
    self.headIm = headIm;
    
    UIButton *titleBtn = [[UIButton alloc] init];
    [titleBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
    
    [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    titleBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    titleBtn.titleLabel.font = [UIFont fontWithName:@"迷你简启体" size:17.0];
    
    [titleBtn addTarget:self action:@selector(onLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleBtn];
    self.titleBtn = titleBtn;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIButton *couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [couponBtn setTitle:@"优惠券" forState:UIControlStateNormal];
    [couponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [couponBtn setImage:[UIImage imageNamed:@"my_coupon"] forState:UIControlStateNormal];
    couponBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    couponBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    couponBtn.width = ScreenWidth/2;
    couponBtn.height = 50;
    couponBtn.x = 0;
    couponBtn.y = 0;
    [couponBtn addTarget:self action:@selector(onLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:couponBtn];
    
    UIButton *interalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [interalBtn setTitle:@"我的积分" forState:UIControlStateNormal];
    [interalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [interalBtn setImage:[UIImage imageNamed:@"my_ntegrals"] forState:UIControlStateNormal];
    interalBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    interalBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    interalBtn.width = ScreenWidth/2;
    interalBtn.height = 50;
    interalBtn.x = ScreenWidth/2;
    interalBtn.y = 0;
    [interalBtn addTarget:self action:@selector(onRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:interalBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2-0.5, 10, 1, 30)];
    lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [bottomView addSubview:lineView];
}
#pragma mark - 点击登陆/注册
- (void)onLoginBtn:(UIButton *)btn{
    
    NSLog(@"点击登陆/注册");
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLogin)]) {
        
        [self.delegate onLogin];
    }
}

#pragma mark - 点击优惠券
- (void)onLeftBtn:(UIButton *)btn{
    
    NSLog(@"点击优惠券");
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLeft)]) {
        
        [self.delegate onLeft];
    }
}

#pragma mark - 点击我的积分
- (void)onRightBtn:(UIButton *)btn{
    
    NSLog(@"点击我的积分");
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRight)]) {
        
        [self.delegate onRight];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    self.bgView.y -= ScreenHeight;
    self.bgView.height += ScreenHeight;
    self.headIm.x = 30;
    self.headIm.y = 20;
    self.headIm.width = 70;
    self.headIm.height = 70;
    self.titleBtn.x = 100;
    self.titleBtn.y = 60;
    self.titleBtn.width = 150;
    self.titleBtn.height = 30;
    self.bottomView.x = 0;
    self.bottomView.y = self.height - 50;
    self.bottomView.width = ScreenWidth;
    self.bottomView.height = 50;
}
@end
