//
//  IntroductionScrollView.m
//  MyAPP
//
//  Created by zhangming on 17/3/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionScrollView.h"
#import "IntroductionOneView.h"
#import "IntroductionTwoView.h"
#import "IntroductionThreeView.h"
@interface IntroductionScrollView ()

@property (weak, nonatomic) IntroductionOneView *oneView;
@property (weak, nonatomic) IntroductionTwoView *twoView;
@property (weak, nonatomic) IntroductionThreeView *threeView;

@end

@implementation IntroductionScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    IntroductionOneView *oneView = [[IntroductionOneView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self addSubview:oneView];
    self.oneView = oneView;
    [oneView layoutSubviews];
    
    IntroductionTwoView *twoView = [[IntroductionTwoView alloc] initWithFrame:CGRectMake(0, oneView.height, ScreenWidth, 0)];
    [self addSubview:twoView];
    self.twoView = twoView;
    [twoView layoutSubviews];
    
    IntroductionThreeView *threeView = [[IntroductionThreeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(twoView.frame), ScreenWidth, 0)];
    [self addSubview:threeView];
    self.threeView = threeView;
    [threeView layoutSubviews];
    
    self.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(threeView.frame));
}


@end
