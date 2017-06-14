//
//  IntroductionHeaderView.m
//  MyAPP
//
//  Created by zhangming on 17/3/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionHeaderView.h"

@interface IntroductionHeaderView ()

@property (weak , nonatomic) UIImageView *bgImg;
@property (weak, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic)UIView *bgView;
@property (weak , nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UIView *maskView;
@property (weak, nonatomic)UIImageView *icon;
@property (weak, nonatomic) UILabel *title;
@property (weak, nonatomic) UILabel *price;
@end

@implementation IntroductionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        [self setup];
    }
    
    return self;
}

- (void)setup{
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    bgImg.transform = CGAffineTransformMakeScale(1.8, 1.8);
    [self addSubview:bgImg];
    bgImg.image = [UIImage imageNamed:@"leaderPage_01"];
    self.bgImg = bgImg;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bgImg.bounds;
    [bgImg addSubview:effectView];
    self.effectView = effectView;

    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    maskView.frame = self.bounds;
    [self addSubview:maskView];
    self.maskView = maskView;

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, 265-70)];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 125, bgView.height - 25)];
    [bgView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"leaderPage_01"];
    self.imageView = imageView;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ticket_zongdai"]];
    icon.x = 0;
    icon.y = 0;
    [imageView addSubview:icon];
    self.icon = icon;
    
    CGFloat titleX = CGRectGetMaxX(imageView.frame)+15;
    CGFloat titileY = imageView.y;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titileY + 5, ScreenWidth-titleX-15, 0)];
    title.numberOfLines = 3;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:BASEFONT size:17];
    [bgView addSubview:title];
    title.text = @"赵丽颖:我只是个简单的演员，作为一个简单的演员我不会唱歌";
    title.height = [title getTextHeight];
    self.title = title;
    
    CGFloat priceX = CGRectGetMaxX(imageView.frame) + 15;
    CGFloat priceY = CGRectGetMaxY(imageView.frame) - 20;
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, 100, 20)];
    price.text = @"¥  1 2 0";
    price.font = [UIFont fontWithName:BASEFONT size:17];
    price.textColor = [UIColor whiteColor];
    [bgView addSubview:price];
    
}

-(void)updateSubViewsWithScrollOffsetY:(CGFloat)y
{
    CGFloat offsetY = y;
    if (offsetY < -265) {
        self.height = -offsetY;
        CGFloat offset = -offsetY - 265;
        self.bgView.y = offset + 70;
        
        CGFloat scale = offset / 200 + 1.8;
        if (scale > 2.2) {
            scale = 2.2;
        }
        self.bgImg.transform = CGAffineTransformMakeScale(scale, scale);
    }else {
        CGFloat height = offsetY + 265;
        CGFloat scale = 1.8 - height / (265 * 1.5);
        if (scale < 1.4) {
            scale = 1.4;
        }
        self.bgImg.transform = CGAffineTransformMakeScale(scale, scale);
        self.bgView.y = 70 - height / 4;
        CGFloat minH = 265 - 64;
        if (height > minH) {
            self.height = 64;
        }else {
            self.height = 265 -  height;
        }
        self.bgView.alpha = 1 - height / minH;
    }
    self.maskView.frame = self.bounds;
}
@end
