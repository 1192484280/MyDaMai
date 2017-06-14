//
//  MyStatusViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/2/15.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "MyStatusViewController.h"
#import "CustomPieView.h"
#define RGBCOLOR(r,g,b,_alpha) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:_alpha]
#define PhoneScreen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PhoneScreen_WIDTH [UIScreen mainScreen].bounds.size.width

@interface MyStatusViewController ()
{
    CustomPieView *chartView;
    
    NSMutableArray *segmentDataArray;
    
    NSMutableArray *segmentTitleArray;
    
    NSMutableArray *segmentColorArray;
    
}
@end

@implementation MyStatusViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBarWithTitle:@"我的日常"];
    
    [self loadPieData];
    
    [self loadPieChartView];
    
    //学习/特定几个圆角
    UIRectCorner leftRectCorner = UIRectCornerBottomLeft | UIRectCornerTopLeft;
    //任意视图
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, (ScreenWidth - 100)/2, 40)];
    [leftBtn setBackgroundColor:NAVBARCOLOR];
    [leftBtn setTitle:@"学习" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBezierPath *leftBezierPath = [UIBezierPath bezierPathWithRoundedRect:leftBtn.bounds byRoundingCorners:leftRectCorner cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *leftMaskLayer = [[CAShapeLayer alloc] init];
    leftMaskLayer.frame = leftBtn.bounds;
    leftMaskLayer.path = leftBezierPath.CGPath;
    leftBtn.layer.mask = leftMaskLayer;
    [self.view addSubview:leftBtn];
    
    //工作
    UIRectCorner rightRectCorner = UIRectCornerBottomRight | UIRectCornerTopRight;
    //任意视图
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(50 + leftBtn.width , 100, (ScreenWidth - 100)/2, 40)];
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = NAVBARCOLOR.CGColor;
    
    [rightBtn setTitle:@"工作" forState:UIControlStateNormal];
    [rightBtn setTitleColor:NAVBARCOLOR forState:UIControlStateNormal];
    UIBezierPath *rightBezierPath = [UIBezierPath bezierPathWithRoundedRect:rightBtn.bounds byRoundingCorners:rightRectCorner cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *rightMaskLayer = [[CAShapeLayer alloc] init];
    rightMaskLayer.frame = rightBtn.bounds;
    rightMaskLayer.path = rightBezierPath.CGPath;
    rightBtn.layer.mask = rightMaskLayer;
    [self.view addSubview:rightBtn];
    
}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadPieData
{

    segmentDataArray = [NSMutableArray arrayWithObjects:@"4",@"8",@"8",@"2",@"2", nil];
    
    segmentTitleArray = [NSMutableArray arrayWithObjects:@"吃饭",@"睡觉",@"工作",@"学习",@"运动", nil];
    
    segmentColorArray = [NSMutableArray arrayWithObjects:[UIColor redColor],[UIColor orangeColor],[UIColor greenColor],[UIColor brownColor], nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadPieChartView
{
    //包含文本的视图frame
    chartView = [[CustomPieView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    
    //数据源
    chartView.segmentDataArray = segmentDataArray;
    
    //颜色数组，若不传入，则为随即色
    chartView.segmentColorArray = segmentColorArray;
    
    //标题，若不传入，则为“其他”
    chartView.segmentTitleArray = segmentTitleArray;
    
    //动画时间
    chartView.animateTime = 2.0;
    
    //内圆的颜色
    chartView.innerColor = [UIColor whiteColor];
    
    //内圆的半径
    chartView.innerCircleR = 2;
    
    //大圆的半径
    chartView.pieRadius = 80;
    
    //整体饼状图的背景色
    chartView.backgroundColor = RGBCOLOR(240, 241, 242, 1.0);
    
    //圆心位置，此属性会被centerXPosition、centerYPosition覆盖，圆心优先使用centerXPosition、centerYPosition
    chartView.centerType = PieCenterTypeTopMiddle;
    
    //是否动画
    chartView.needAnimation = YES;
    
    //动画类型，全部只有一个动画；各个部分都有动画
    chartView.type = PieAnimationTypeTogether;
    
    //圆心，相对于饼状图的位置-x
    chartView.centerXPosition = 100;
    
    //圆心，y
    //chartView.centerYPosition = 250;
    
    //右侧的文本颜色是否等同于模块的颜色
    chartView.isSameColor = NO;
    
    //文本的行间距
    chartView.textSpace = 20;
    
    //文本的字号
    chartView.textFontSize = 12;
    
    //文本的高度
    chartView.textHeight = 30;
    
    //文本前的颜色块的高度
    chartView.colorHeight = 10;
    
    //文本前的颜色块是否为圆
    chartView.isRound = YES;
    
    //文本距离右侧的间距
    chartView.textRightSpace = 20;
    
    //支持点击事件
    chartView.canClick = YES;
    
    //点击圆饼后的偏移量
    chartView.clickOffsetSpace = 10;
    
    //不隐藏右侧的文本
    chartView.hideText = NO;
    
    //点击触发的block，index与数据源对应
    [chartView clickPieView:^(NSInteger index) {
        NSLog(@"Click Index:%ld",index);
    }];
    
    //添加到视图上
    [chartView showCustomViewInSuperView:self.view];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self loadNewDataArray];
    
    [self loadNewColorArray];
    
    
    NSInteger index = [self getRandomNumber:1 to:16];
    
    if (index == 1) {
        
        //更新半径
        chartView.pieRadius = 70;
        
    }else if (index == 2){
        
        //更新内圆颜色
        chartView.innerColor = [UIColor blackColor];
        
    }else if (index == 3){
        
        //更新内圆半径
        chartView.innerCircleR = 15;
        
        
    }else if (index == 4){
        
        //更新背景色
        chartView.backgroundColor = [UIColor lightGrayColor];
        
        
    }else if (index == 5){
        
        //更新大圆半径
        chartView.pieRadius = 80;
        
        
    }else if (index == 6){
        
        //更新动画类型
        chartView.type = PieAnimationTypeOne;
        
        
    }else if (index == 7){
        
        //更新圆心位置
        chartView.centerXPosition =  80;
        chartView.centerYPosition = 150;
        
    }else if (index == 8){
        
        //更新文本颜色与圆点颜色一致
        chartView.isSameColor = YES;
        
        
    }else if (index == 9){
        
        //更新文本行间距
        chartView.textSpace = 15;
        
        
    }else if (index == 10){
        
        //更新文本高度
        chartView.textHeight = 20;
        
        
    }else if (index == 11){
        
        //更新文本前圆点的高度
        chartView.colorHeight = 15;
        
        
    }else if (index == 12){
        
        //更新文本前的圆点为圆
        chartView.isRound = NO;
        
        
    }else if (index == 13){
        
        //更新文本右侧间距
        chartView.textRightSpace = 5;
        
        
    }else if (index == 14){
        
        //更新点击后的偏移量
        chartView.clickOffsetSpace = 30;
        
    }else if (index == 15){
        
        //移除文本，圆饼居中
        chartView.hideText = YES;
        chartView.pieRadius = 100;
        chartView.centerXPosition = 0;
        chartView.centerYPosition = 0;
        chartView.centerType = PieCenterTypeCenter;
    }
    
    
    [chartView updatePieView];
}

- (void)loadNewDataArray
{
    NSInteger dataCount = [self getRandomNumber:1 to:7];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i = 0; i< dataCount; i++) {
        
        NSInteger value = [self getRandomNumber:1 to:20];
        
        NSString *valueString = [NSString stringWithFormat:@"%ld",value];
        
        [dataArray addObject:valueString];
        
    }
    
    chartView.segmentDataArray = dataArray;
    
}

- (void)loadNewColorArray
{
    NSMutableArray *colorArray = [NSMutableArray array];
    
    for (int i = 0; i< chartView.segmentDataArray.count; i++) {
        
        CGFloat red = [self getRandomNumber:1 to:255];
        CGFloat green = [self getRandomNumber:1 to:255];
        CGFloat blue = [self getRandomNumber:1 to:255];
        
        UIColor *color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
        [colorArray addObject:color];
        
    }
    
    chartView.segmentColorArray = colorArray;
    
    
}

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from)));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
