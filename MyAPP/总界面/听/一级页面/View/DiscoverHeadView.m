//
//  DiscoverHeadView.m
//  MyAPP
//
//  Created by zhangming on 17/3/1.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "DiscoverHeadView.h"
#import "SDCycleScrollView.h"
#import "RadioCarousel.h"
#import "RadioHostList.h"

@interface DiscoverHeadView ()<SDCycleScrollViewDelegate>

/**
 * 顶部的轮播器
 */
@property (nonatomic, strong) SDCycleScrollView *SDcyView;

/**
 * 顶部轮播器的数据
 */
@property (nonatomic, strong) NSMutableArray *SDImages;

@end

@implementation DiscoverHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
    }
    return self;

}

- (void)setupSubView{
    
    //创建顶部图片轮播器
    [self setupTopView];
    
    //创建下方的最热专辑
    CGFloat margin = Margin;
    CGFloat btnW = HotImageW;
    CGFloat btnH = btnW;
    for (int i =0; i<3; i++) {
        
        CGFloat btnX = margin + (margin + btnW) * i;
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(btnX, 180+margin, btnW, btnH);
        imgView.tag = 100 + i;
        imgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:imgView];
    }
    
}

#pragma mark -
#pragma mark - 设置顶部视图
- (void)setupTopView{
    
    //设置顶部轮播器
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,180)];
    scrollView.delegate = self;
    self.SDcyView = scrollView;
    //设置分页位置
    self.SDcyView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //设置时间间隔
    self.SDcyView.autoScrollTimeInterval = 3.0;
    //设置当前分页圆点颜色
    self.SDcyView.currentPageDotColor = [UIColor whiteColor];
    //设置其它分页圆点颜色
    self.SDcyView.pageDotColor = [UIColor lightGrayColor];
    //设置动画样式
    self.SDcyView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    self.SDcyView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.SDcyView];
    
}

#pragma mark - 进行设置数据
- (void)setListArray:(NSMutableArray *)listArray
{
    _listArray = listArray;
    //设置顶部轮播器的图片数据
    NSMutableArray *topListArray = [listArray objectAtIndex:0];
    NSMutableArray *imgs = [NSMutableArray array];
    for (RadioCarousel *model in topListArray) {
        NSString *img = model.img;
        [imgs addObject:img];
        
    }
    self.SDImages  = imgs;
    self.SDcyView.imageURLStringsGroup = self.SDImages;
    
    
    //设置下方最热专辑的数据
    NSMutableArray *hotArray = [listArray objectAtIndex:1];
    for (int i = 0; i < 3; i ++) {
        RadioHostList *list = hotArray[i];
        NSString *img = list.coverimg;
        UIImageView *imgView = [self viewWithTag:(100 + i)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
}


#pragma mark - 轮播器代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSMutableArray *topListArray = self.listArray[0];
    RadioCarousel *model = topListArray[index];
    self.block(model.url);
}

#pragma mark - 懒加载
- (NSMutableArray *)SDImages{
    
    if (!_SDImages) {
        
        _SDImages = [NSMutableArray array];
    }
    return _SDImages;
}
@end
