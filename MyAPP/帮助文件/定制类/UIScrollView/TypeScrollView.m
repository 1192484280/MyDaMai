//
//  TypeScrollView.m
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "TypeScrollView.h"

@interface TypeScrollView ()
@property (copy, nonatomic) NSArray *titles;
@property (weak, nonatomic) UIView *lineView;
@property (weak, nonatomic) UIButton *button;
@property (assign, nonatomic) NSInteger currentIndex;
@end

@implementation TypeScrollView

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titels
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titels;
        self.showsHorizontalScrollIndicator = NO;
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGFloat margin = 15;
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:NAVBARCOLOR forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont fontWithName:BASEFONT size:14];
        button.tag = i;
        [button addTarget:self action:@selector(didTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.height = self.height;
        button.y = 0;
        button.x = margin + i * 20;
        button.width = [button.titleLabel getTextWidth] + 6;
        margin += button.width;
        if (i == 0) {
            button.enabled = NO;
            self.button = button;
            
        }
        if (i == self.titles.count - 1) {
            NSLog(@"%f",self.height);
            self.contentSize = CGSizeMake(CGRectGetMaxX(button.frame) + 15, self.height);
            
        }
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.y = self.height - 2;
    lineView.height = 2;
    lineView.width = self.button.width;
    lineView.centerX = self.button.centerX;
    lineView.backgroundColor = NAVBARCOLOR;
    [self addSubview:lineView];
    self.lineView = lineView;
    
}

- (void)didTypeClick:(UIButton *)button
{
    self.button.enabled = YES;
    button.enabled = NO;
    self.button = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.width = button.width;
        self.lineView.centerX = button.centerX;
    }];
    
    if ([self.myDelegate respondsToSelector:@selector(didTypeWithIndex:)]) {
        [self.myDelegate didTypeWithIndex:button.tag];
    }
    
    //防止越出
    if (button.x + button.width / 2  < self.width / 2) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
    }
    if (button.x + button.width / 2 > self.contentSize.width - self.width / 2) {
        [self setContentOffset:CGPointMake(self.contentSize.width - self.width, 0) animated:YES];
        return;
    }
    
    //选中屏幕右侧的btn，scrollview位移到当前位置
    CGRect rect = [button.superview convertRect:button.frame toView:[UIApplication sharedApplication].keyWindow];
    CGFloat centerX = rect.origin.x + rect.size.width / 2;
    CGFloat offsetX = 0;
    if (centerX < self.width / 2) {
        offsetX = self.width / 2 - centerX;
        [self setContentOffset:CGPointMake(self.contentOffset.x - offsetX, 0) animated:YES];
    }else if (centerX > self.width / 2){
        offsetX = centerX - self.width / 2;
        [self setContentOffset:CGPointMake(self.contentOffset.x + offsetX, 0) animated:YES];
    }
}

- (void)selectedButtonForIndex:(NSInteger)index
{
    if (self.currentIndex == index) {
        return;
    }
    [self didTypeClick:self.subviews[index]];
    self.currentIndex = index;
}

@end
