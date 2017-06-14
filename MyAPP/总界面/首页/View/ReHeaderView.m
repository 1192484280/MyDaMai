//
//  ReHeaderView.m
//  Family
//
//  Created by zhangming on 17/6/1.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ReHeaderView.h"
#import "SDCycleScrollView.h"

@interface ReHeaderView ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleView;

@property (copy, nonatomic) NSArray *imgArr;
@property (copy, nonatomic) NSArray *typeTitleList;

@end
@implementation ReHeaderView

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@"icon_slide01",@"icon_slide02",@"icon_slide03",@"icon_slide04",@"icon_slide05",@"icon_slide06"];
    }
    return _imgArr;
}

- (NSArray *)typeTitleList{
    
    if (!_typeTitleList) {
        
        _typeTitleList = @[@"热门",@"精品",@"书吧",@"大咖",@"大连",@"主播"];
    }
    return _typeTitleList;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.cycleView];
    
    [self setTypeView];
}

- (SDCycleScrollView *)cycleView{
    
    if (!_cycleView) {
        
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 16 * 9) shouldInfiniteLoop:YES imageNamesGroup:self.imgArr];
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleView.autoScrollTimeInterval = 4.0f;
        
    }
    
    return _cycleView;
}

- (void)setTypeView{
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ReTypeView" owner:self options:nil];
    UIView *view = views[0];
    view.frame = CGRectMake(0, ScreenWidth / 16 * 9, ScreenWidth, 88);
    [self addSubview:view];
    
    CGFloat padding = 88 - 10;
    self.typeWidth.constant = 30 + 70 * self.typeTitleList.count;
    for (int i = 0; i<self.typeTitleList.count; i++) {
        
        BAButton *btn = [[BAButton alloc] initWithFrame:CGRectMake(15 + 70*i, 10, 70, padding)];
        NSString *imgStr = [NSString stringWithFormat:@"type_icon0%d",i+1];
        //UIImage *img = [UIImage imageWithContentsOfFile:model.typeImg];
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        [btn setTitle:self.typeTitleList[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.padding = 2;
        btn.buttonPositionStyle = BAButtonPositionStyleTop;
        [self.typeView addSubview:btn];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}


@end
