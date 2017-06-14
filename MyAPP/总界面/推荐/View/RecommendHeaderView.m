//
//  RecommendHeaderView.m
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RecommendHeaderView.h"
#import "SDCycleScrollView.h"

@interface RecommendHeaderView ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) SDCycleScrollView *cycleView;
//@property (weak, nonatomic) UIView *typeView;
//@property (weak, nonatomic) HeadlinesScrollView *headScrollView;
//@property (weak, nonatomic) RecommendNewView *rNewView;
@property (strong, nonatomic) NSMutableArray *typeTitleAy;
@property (strong, nonatomic) NSMutableArray *typeOneAy;
@property (strong, nonatomic) NSMutableArray *typeTwoAy;
@property (strong, nonatomic) NSMutableArray *typeThreeAy;
@property (strong, nonatomic) NSMutableArray *typeFourAy;
@property (strong, nonatomic) NSMutableArray *typeTenAy;
@property (strong, nonatomic) NSMutableArray *typeTwelveAy;

@end
@implementation RecommendHeaderView

- (NSMutableArray *)typeTitleAy
{
    if (!_typeTitleAy) {
        _typeTitleAy = [NSMutableArray array];
    }
    return _typeTitleAy;
}

- (NSMutableArray *)typeOneAy
{
    if (!_typeOneAy) {
        _typeOneAy = [NSMutableArray array];
    }
    return _typeOneAy;
}

- (NSMutableArray *)typeTwoAy
{
    if (!_typeTwoAy) {
        _typeTwoAy = [NSMutableArray array];
    }
    return _typeTwoAy;
}

- (NSMutableArray *)typeThreeAy
{
    if (!_typeThreeAy) {
        _typeThreeAy = [NSMutableArray array];
    }
    return _typeThreeAy;
}

- (NSMutableArray *)typeFourAy
{
    if (!_typeFourAy) {
        _typeFourAy = [NSMutableArray array];
    }
    return _typeFourAy;
}

- (NSMutableArray *)typeTenAy
{
    if (!_typeTenAy) {
        _typeTenAy = [NSMutableArray array];
    }
    return _typeTenAy;
}

- (NSMutableArray *)typeTwelveAy
{
    if (!_typeTwelveAy) {
        _typeTwelveAy = [NSMutableArray array];
    }
    return _typeTwelveAy;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self setup];
    }
    return self;
}

- (void)setup{
    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 16 * 9) delegate:self placeholderImage:[UIImage imageNamed:@"bg_banner_placeholder"]];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleView.autoScrollTimeInterval = 4.0f;
    [self addSubview:cycleView];
    self.cycleView = cycleView;
    
    
}


@end
