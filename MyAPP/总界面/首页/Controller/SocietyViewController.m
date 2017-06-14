//
//  SocietyViewController.m
//  Family
//
//  Created by zhangming on 17/5/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SocietyViewController.h"
#import "sequenceView.h"

@interface SocietyViewController ()<sequenceViewDelegate,UIScrollViewDelegate>

@end

@implementation SocietyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    NSArray *titleArr = @[@"申请审批",@"时间调查",@"直接划款",@"申请审批",@"时间调查",@"直接划款"];
    NSArray *contentArr = @[@"拨打电话400-900-100,2017/5/1",@"第三方专业公估机构核实后,全平台公示,2017/5/5",@"公示通过无异议,从互助金中划款,2017/6/1",@"拨打电话400-900-100,2017/5/1",@"第三方专业公估机构核实后,全平台公示,2017/5/5",@"公示通过无异议,从互助金中划款,2017/6/1"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(ScreenWidth, 150*titleArr.count);
    [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
    sequenceView *sequence = [[sequenceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150*titleArr.count)];
    [sequence sequenceWith:titleArr contentArr:contentArr];
    sequence.delegate = self;
    [scrollView addSubview:sequence];
    
}

- (void)sequenceViewWithSequenceView:(sequenceView *)sequenceView sequenceBtn:(UIButton *)sequenceBtn {
    
    NSLog(@"%ld",sequenceBtn.tag);
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
