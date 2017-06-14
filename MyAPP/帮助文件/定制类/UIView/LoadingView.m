//
//  LoadingView.m
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *titleLa;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView *centerView = [[UIView alloc] init];
    centerView.layer.masksToBounds = YES;
    centerView.layer.cornerRadius = 5;
    centerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
    centerView.width = 110;
    centerView.height = 110;
    [self addSubview:centerView];
    self.centerView = centerView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    NSArray *images = @[@"loading_image1",@"loading_image2",@"loading_image3",@"loading_image4"];
    for (int i =0; i< images.count; i++) {
        
        [array addObject:[UIImage imageNamed:images[i]]];
    }
    imageView.animationImages = array;
    imageView.animationDuration = 0.1;
    imageView.width = 60;
    imageView.height = 60;
    [centerView addSubview:imageView];
    [imageView startAnimating];
    self.imageView = imageView;
    
    UILabel *titleLa = [[UILabel alloc] init];
    titleLa.text = @"努力加载中";
    titleLa.textColor = [UIColor whiteColor];
    titleLa.font = [UIFont systemFontOfSize:12];
    titleLa.textAlignment = NSTextAlignmentCenter;
    titleLa.x = 0;
    titleLa.width = centerView.width;
    titleLa.height = 15;
    [centerView addSubview:titleLa];
    self.titleLa = titleLa;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.centerView.centerX = self.width / 2;
    self.centerView.centerY = self.height / 2;
    self.imageView.centerX = self.centerView.width / 2;
    self.imageView.centerY = self.centerView.height / 2 - 10;
    self.titleLa.y = CGRectGetMaxY(self.imageView.frame) + 5;
}
@end
