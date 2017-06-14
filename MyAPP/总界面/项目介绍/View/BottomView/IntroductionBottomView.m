//
//  IntroductionBottomView.m
//  MyAPP
//
//  Created by zhangming on 17/3/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionBottomView.h"

@implementation IntroductionBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
        
    }
    return self;
}

- (void)setup{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    BAButton *btn = [[BAButton alloc] initWithFrame:CGRectMake(15, 0, 40, 40)];
    [btn setTitle:@"客服" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"zaixiankefu"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:BASEFONT size:13];
    btn.padding = 4;
    btn.buttonPositionStyle = BAButtonPositionStyleTop;
    [view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+10, 0, ScreenWidth - CGRectGetMaxX(btn.frame)-10, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"立即购票" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont fontWithName:BASEFONT size:17];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:btn2];
    [btn2 addTarget:self action:@selector(onBuyTicket) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onBuyTicket{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"即将出票" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [self.getCurrentViewController presentViewController:alert animated:YES completion:^{
        
    }];

}
@end
